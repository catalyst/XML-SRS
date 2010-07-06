
package XML::SRS::Error;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

sub root_element { "Error" }

has_attr "error_id" =>
	is => "ro",
	isa => "XML::SRS::UID",
	required => 1,
	xml_name => "ErrorId",
	;

enum "XML::SRS::Error::Severity" =>
	qw( alert crit err );

has_attr "severity" =>
	is => "ro",
	isa => "XML::SRS::Error::Severity",
	required => 1,
	xml_name => "Severity",
	;

has_attr "hint" =>
	is => "ro",
	isa => "XML::SRS::UID",  # odd
	required => 1,
	xml_name => "Hint",
	;

has_element "desc" =>
	is => "ro",
	isa => "Str",
	xml_nodeName => "Description",
	;

has_element "details" =>
	is => "ro",
	isa => "ArrayRef[Str]",
	xml_min => 0,
	xml_nodeName => "ErrorDetails",
	auto_deref => 1,
	;

with 'XML::SRS::ActionResponse';

1;
