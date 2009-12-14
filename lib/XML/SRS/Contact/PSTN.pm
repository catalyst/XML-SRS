
package XML::SRS::Contact::PSTN;

use Moose;
use PRANG::Graph;

has_attr 'cc' =>
	is => "ro",
	isa => "Str",
	xml_name => "CountryCode",
	xml_required => 0,
	;

has_attr 'ndc' =>
	is => "ro",
	isa => "Str",
	xml_name => "AreaCode",
	xml_required => 0,
	;

has_attr 'subscriber' =>
	is => "ro",
	isa => "Str",
	xml_name => "LocalNumber",
	xml_required => 0,
	;

with 'XML::SRS::Node';

1;
