
package XML::SRS::Server::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

has_element 'nameservers' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Server]",
	xml_nodeName => "Server",
	;

with 'XML::SRS::Node';

1;
