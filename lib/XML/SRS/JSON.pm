package XML::SRS::JSON;

use Moose::Role;

use Scalar::Util qw(blessed);
use JSON::Syck;
use Try::Tiny;
use Data::Dumper;

# Some fields should be skipped when converting to JSON
my %SKIP_FIELDS = (
    'XML::SRS::Request'  => [qw(major minor)],
    'XML::SRS::Response' => [qw(major minor)],
    'XML::SRS::Result'   => [qw(response)],
);

# These types need a custom function to convert to json
my %CUSTOM_CONVERT = (
    'XML::SRS::Server::List' => '_convert_nameservers_to_json',
    'XML::SRS::Role::List' => '_convert_roles_to_json',
    'XML::SRS::Zone::List' => '_convert_zones_to_json',
    'XML::SRS::DS::List' => '_convert_ds_to_json',
    'XML::SRS::Response' => '_convert_response_to_json',
    'XML::SRS::Result' => '_convert_result_to_json',
    'XML::SRS::TimeStamp' => '_convert_timestamp_to_json',
    'XML::SRS::ChangedDomains' => '_convert_changed_domains_to_json',
    'XML::SRS::Message' => '_convert_message_to_json',
);

# In JSON, we set a 'response_type' field for each 'ActionResponse'
#  (i.e. each top-level element in a response). This is usually based
#  on the root element of the ActionResponse (i.e. Domain for
#  XML::SRS::Domain). When we create classes from JSON, there are some
#  cases where we can't discover the class name from the response_type.
#  These exceptions are listed in this map.
my %RESPONSE_TYPE_MAP = (
    'AckResponse' => 'XML::SRS::Message::Ack::Response',
    'AccessControlList' => 'XML::SRS::ACL',
    'DomainTransfer' => 'XML::SRS::Domain::Transferred',
);

sub from_json {
    my $package = shift;
    my $json = shift;
    
    my $json_obj = JSON::Syck::Load($json);
    
    # Detect response vs request
    if ($json_obj->{requests}) {
        return $package->_convert_request_from_json($json_obj);
    }
    elsif ($json_obj->{responses}) {
        return $package->_convert_response_from_json($json_obj);
    }
    else {
        die "Can't figure out if this is a request or response\n";
    }
}

sub to_json {
    my $self = shift;
    
    my $json_obj = $self->to_json_obj;
    
    return JSON::Syck::Dump($json_obj);    
}

sub to_json_obj {
    my $self = shift;
    my $params = shift // {};
    
    my $json_obj = {};
    
    my $model_class = $self->meta->name;
        
    if (! $params->{no_custom} and my $custom_method = $CUSTOM_CONVERT{$model_class}) {
        return $self->$custom_method;
    }
    
    my @skip_fields = @{ $SKIP_FIELDS{$model_class} // [] };
        
    if ($self->does('XML::SRS::Action') || $self->does('XML::SRS::Query')) {
        $model_class =~ m/^XML::SRS::(\w+)(?:::(\w+))?/;
        
        my $type = $2 ? $1 : undef;
        my $action = $2 ? $2 : $1;
                
        $json_obj->{type}   = $type if defined $type;
        $json_obj->{action} = $action;
    }
    
    if ($self->does('XML::SRS::ActionResponse')) {        
        $json_obj->{response_type} = $self->root_element;
    }
        
    foreach my $attr ($self->meta->get_all_attributes) {
        
        next if $attr->name ~~ @skip_fields;
        
        my $model_obj_method = $attr->name;
        my $value = $self->$model_obj_method;
        
        if (ref $value eq 'ARRAY') {
            my @values;
            foreach my $val (@$value) {
                if (blessed $val) {
                    # Recurse to convert blessed value
                    $val = $val->to_json_obj;
                }
                push @values, $val;
            }
            
            $value = @values ? \@values : undef;
        }        
        elsif (blessed $value) {
            # Recurse to convert blessed value
            $value = $value->to_json_obj;
        }
        
        next if ! defined $value;
        
        $json_obj->{$model_obj_method} = $value;
    }
    
    return $json_obj;
}

sub _convert_request_from_json {
    my $package = shift;
    my $json_obj = shift;
    
    my @transactions;
    foreach my $transaction (@{ $json_obj->{requests} // [] }) {
        my $type = delete $transaction->{type} // '';
        my $action = delete $transaction->{action} // '';
        
        my $class = "XML::SRS::";
        $class .= "${type}::" if $type;
        $class .= "$action";
                
        my $trans = $class->new($transaction);
        
        push @transactions, $trans;
    }
    
    delete $json_obj->{requests};
    
    return XML::SRS::Request->new(
        %$json_obj,
        requests => \@transactions,
    );    
}

sub _convert_response_from_json {
    my $package = shift;
    my $json_obj = shift;
    
    my @results;
    foreach my $response (@{ $json_obj->{responses} // [] }) {
        if ($response->{response_type} && $response->{response_type} eq 'Error') {
            push @results, XML::SRS::Error->new(%$response);
        }
        else {
            push @results, $package->_convert_transaction_response_from_json($response);
        }
    }
    
    delete $json_obj->{responses};
    
    return XML::SRS::Response->new(
        %$json_obj,
        results => \@results,
    );
}

sub _convert_transaction_response_from_json {
    my $package = shift;
    my $response = shift;
    
    my @action_resp;
    my @messages;
    
    foreach my $action_response (@{ $response->{action_responses} // [] }) {        
        if ($action_response->{response_type} eq 'Result') {
            push @messages, $package->_convert_transaction_response_from_json($action_response);
        }
        else {
            my $resp = $package->_convert_action_response_from_json($action_response);   
            
            push @action_resp, $resp; 
        } 
    }
    
    return XML::SRS::Result->new(
        %$response,
        responses => \@action_resp,
        messages  => \@messages,
    );   
}

sub _convert_action_response_from_json {
    my $package = shift;
    my $action_response = shift;
    
    my $response_type = delete $action_response->{response_type};
    
    die "Unable to find response_type for action response: " . Dumper($action_response) . "\n"
        unless $response_type;
    
    my $class = $RESPONSE_TYPE_MAP{$response_type} // "XML::SRS::" . $response_type;
    
    if ($class eq 'XML::SRS::Message') {
        $action_response->{result} = $package->_convert_transaction_response_from_json($action_response->{result});
    }
                
    my $resp = try {
        $class->new($action_response)
    }
    catch {
        die "Failed creating $class from JSON ($_)\nData: " . Dumper($action_response);
    };
    
    return $resp;
}


sub _convert_nameservers_to_json {
    my $self = shift;
    
    return $self->_convert_list_to_json($self->nameservers);   
}

sub _convert_roles_to_json {
    my $self = shift;
    
    return $self->_convert_list_to_json($self->roles);
}

sub _convert_zones_to_json {
    my $self = shift;
    
    return $self->_convert_list_to_json($self->zones);
}

sub _convert_ds_to_json {
    my $self = shift;
    
    return $self->_convert_list_to_json($self->ds_list);
}

sub _convert_changed_domains_to_json {
    my $self = shift;
    
    return $self->_convert_list_to_json($self->domains);
}

sub _convert_list_to_json {
    my $self = shift;
    my $list_ref = shift;
    
    return [] unless $list_ref;
    
    my @list = map { $_->to_json_obj } @$list_ref;
    
    return \@list; 
}

sub _convert_response_to_json {
    my $self = shift;
    
    my @results = map { $_->to_json_obj } @{$self->results};
    
    my $resp = {
        responses => \@results,
        version => $self->version,
    };
    
    $resp->{registrar_id} = $self->registrar_id if defined $self->registrar_id;
        
    return $resp;
}

sub _convert_result_to_json {
    my $self = shift;
    
    my $json_obj = $self->to_json_obj({no_custom => 1});
    
    if ($json_obj->{messages}) {
        # We need to add a response_type into the 'Result'
        my @messages = map { $_->{response_type} = 'Result'; $_ } @{ delete $json_obj->{messages} };
        $json_obj->{action_responses} = \@messages;
    }
    else {
        $json_obj->{action_responses} = delete $json_obj->{responses};
    }
    
    return $json_obj;   
}

sub _convert_message_to_json {
    my $self = shift;
    
    my $json_obj = $self->to_json_obj({no_custom => 1});
    
    # Set response_type of result
    $json_obj->{result}{response_type} = 'Result'
        if $json_obj->{result};
        
    return $json_obj;
}

sub _convert_timestamp_to_json {
    my $self = shift;
    
    $self->timestamptz;
}


1;