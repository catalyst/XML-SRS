
package XML::SRS::Message;

# response to a GetMessages QueueMode=1

use Moose;
use PRANG::Graph;

has_attr 'unacked' =>
	is => "rw",
	isa => "Int",
	required => 0,
	xml_name => "Remaining",
	;

has_element 'result' =>
	is => "rw",
	isa => "XML::SRS::Result",
	xml_nodeName => "Response",
	;

sub root_element { "Message" }
with 'XML::SRS::ActionResponse', 'XML::SRS::Node';

1;
