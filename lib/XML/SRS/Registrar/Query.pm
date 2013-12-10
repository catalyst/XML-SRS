
package XML::SRS::Registrar::Query;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

use XML::SRS::Date::Range;

sub root_element {
	"RegistrarDetailsQry";
}

has_attr "registrar_id" =>
	is => "ro",
	isa => "Str",
	xml_name => "RegistrarId",
	xml_required => 0,
	;

has_attr "name_filter" =>
	is => "ro",
	isa => "Str",
	xml_name => "NameFilter",
	xml_required => 0,
	;

has_element "when" =>
	is => "ro",
	isa => "XML::SRS::Date::Range",
	xml_nodeName => "ResultDateRange",
	xml_required => 0,
	coerce => 1,
	;

with 'XML::SRS::Query';

1;
