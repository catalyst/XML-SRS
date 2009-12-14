
package XML::SRS::Date::Range;

use Moose;
use PRANG::Graph;

has_element 'begin' =>
	is => "ro",
	isa => "XML::SRS::TimeStamp",
	xml_nodeName => "From",
	xml_required => 0,
	;

has_element 'end' =>
	is => "ro",
	isa => "XML::SRS::TimeStamp",
	xml_nodeName => "To",
	xml_required => 0,
	;

with 'XML::SRS::Node';

1;
