
# this is called 'Response', but we call it 'Result' to not clash with
# 'Response', which is actually 'NZSRSResponse'
package XML::SRS::Result;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;

has_attr 'Action' =>
	is => "ro",
	isa => "XML::SRS::ActionEtc",
	required => 1,
	;

has_attr 'FeId' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'FeSeq' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'OrigRegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	required => 1,
	;

has_attr 'RecipientRegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	;

has_attr 'TransId' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_required => 0,
	;

has_attr 'Rows' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_required => 0,
	;

has_attr 'MoreRowsAvailable' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	coerce => 1,
	xml_required => 0,
	;

has_attr 'Count' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_required => 0,
	;

has_element 'FeTimeStamp' =>
	is => "ro",
	isa => "XML::SRS::TimeStamp",
	;

# this is for GetMessages responses, so let's call it messages
has_element 'messages' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Response]",
	xml_nodeName => "Response",
	;

has_element 'ActionResponse' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::ActionResponse]",
	;

with 'XML::SRS::Node';

1;
