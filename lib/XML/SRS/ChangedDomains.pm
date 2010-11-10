
package XML::SRS::ChangedDomains;

use Moose;
use PRANG::Graph;

has_element 'domains' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Domain]",
	xml_nodeName => "Domain",
	xml_required => 0,
	;

sub root_element {"ChangedDomain"}

with 'XML::SRS::Node';

1;
