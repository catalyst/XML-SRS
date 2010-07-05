
# this is called 'Response' in the XML, but we call it 'Result' to not clash
# with 'Response', which is actually 'NZSRSResponse'
package XML::SRS::Result;

use Carp;
use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;

has_attr 'action' =>
	is => "ro",
	isa => "XML::SRS::ActionEtc",
	required => 1,
	xml_name => "Action",
	;

has_attr 'fe_id' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	xml_name => "FeId",
	;

has_attr 'unique_id' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	xml_name => "FeSeq",
	;

has_attr 'by_id' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	required => 1,
	xml_name => "OrigRegistrarId",
	;

has_attr 'for_id' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	xml_name => "RecipientRegistrarId",
	;

has_attr 'client_id' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_required => 0,
	xml_name => "TransId",
	;

has_attr 'rows' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_required => 0,
	xml_name => "Rows",
	;

has_attr 'has_more_rows' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	coerce => 1,
	xml_required => 0,
	xml_name => "MoreRowsAvailable",
	;

has_attr 'count' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_required => 0,
	xml_name => "Count",
	;

subtype 'XML::SRS::timeStampType'
	=> as "XML::SRS::TimeStamp",
	;

has_element 'server_time' =>
	is => "ro",
	isa => "XML::SRS::timeStampType",
	coerce => 1,
	xml_nodeName => "FeTimeStamp",
	;

use MooseX::Timestamp;
use MooseX::TimestampTZ;

coerce "XML::SRS::timeStampType"
	=> from TimestampTZ
	=> via {
		XML::SRS::TimeStamp->new(timestamptz => $_);
	};

# this is for GetMessages responses, so let's call it messages
has_element 'messages' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Result]",
	xml_nodeName => "Response",
	xml_min => 0,
	;

has_element 'responses' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::ActionResponse]",
	xml_required => 0,
	lazy => 1,
	default => sub {
		my $self = shift;
		($self->has_response and defined $self->response)
			? [ $self->response ] : [];
	},
	;

has 'response' =>
	is => "ro",
	isa => "Maybe[XML::SRS::ActionResponse]",
	predicate => "has_response",
	lazy => 1,
	default => sub {
		my $self = shift;
		my $rs_a = $self->responses;
		if ( $rs_a and @$rs_a ) {
			if ( @$rs_a > 1 ) {
				confess "result has multiple responses";
			}
			else {
				$rs_a->[0];
			}
		}
		else {
			undef;
		}
	},
	;

with 'XML::SRS::Node';

1;
