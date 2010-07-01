
package XML::SRS::Error;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

sub root_element { "Error" }

has_attr "ErrorId" =>
	is => "ro",
	isa => "XML::SRS::UID",
	required => 1,
	;

enum "XML::SRS::Error::Severity" =>
	qw( emergency alert critical error err warning notice info );

has_attr "Severity" =>
	is => "ro",
	isa => "XML::SRS::Error::Severity",
	required => 1,
	;

has_attr "Hint" =>
	is => "ro",
	isa => "XML::SRS::UID",  # odd
	required => 1,
	;

has_element "Description" =>
	is => "ro",
	isa => "Str",
	;

has_element "ErrorDetails" =>
	is => "ro",
	isa => "ArrayRef[Str]",
	xml_min => 0,
	;

with 'XML::SRS::ActionResponse';

1;
