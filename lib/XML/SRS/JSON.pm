package XML::SRS::JSON;

use Moose::Role;

use Scalar::Util qw(blessed);
use JSON::Syck;

# Some fields should be skipped when converting to JSON
my %SKIP_FIELDS = (
    'XML::SRS::Request'  => [qw(major minor)],
    'XML::SRS::Response' => [qw(major minor)],
);

# These types need a custom function to convert to json
my %CUSTOM_CONVERT = (
    'XML::SRS::Server::List' => '_convert_nameservers_to_json',
    'XML::SRS::Response' => '_convert_response_to_json',
    'XML::SRS::Result' => '_convert_result_to_json',
    'XML::SRS::TimeStamp' => '_convert_timestamp_to_json',
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
        $model_class =~ m/^XML::SRS::(\w+)/;
        
        $json_obj->{response_type} = $1;
    }
    
    foreach my $attr_name ($self->meta->get_attribute_list) {   
        my $attr = $self->meta->get_attribute($attr_name);

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
        push @results, $package->_convert_transaction_response_from_json($response);
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
            my $class = "XML::SRS::" . delete $action_response->{response_type};
            push @action_resp, $class->new($action_response);
        } 
    }
    
    my $result = XML::SRS::Result->new(
        %$response,
        responses => \@action_resp,
        messages  => \@messages,
    );   
}


sub _convert_nameservers_to_json {
    my $self = shift;
    
    my @servers = map { $_->to_json_obj } @{$self->nameservers};
    
    return \@servers;   
}

sub _convert_response_to_json {
    my $self = shift;
    
    my @results = map { $_->to_json_obj } @{$self->results};
        
    return {
        responses => \@results,
        version => $self->version,
        registrar_id => $self->registrar_id,
    };
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
    delete $json_obj->{response}; 
    
    return $json_obj;   
}

sub _convert_timestamp_to_json {
    my $self = shift;
    
    return $self->timestamptz;   
}


1;