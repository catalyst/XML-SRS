
package XML::SRS::Server::Filter::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

has_element 'server_filter' =>
	is => 'ro',
	isa => 'ArrayRef[XML::SRS::Server::Filter]',
	xml_nodeName => 'ServerFilter',
	;

with 'XML::SRS::Node';

1;
