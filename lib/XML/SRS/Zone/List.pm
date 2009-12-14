
package XML::SRS::Zone::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

has_element 'zones' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Zone]",
	xml_nodeName => "SecondLD",
	;

with 'XML::SRS::Node';

1;
