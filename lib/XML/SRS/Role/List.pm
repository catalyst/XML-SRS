
package XML::SRS::Role::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Role;

has_element 'roles' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Role]",
	xml_nodeName => "Role",
	;

with 'XML::SRS::Node';

1;
