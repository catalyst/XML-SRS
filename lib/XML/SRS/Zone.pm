
package XML::SRS::Zone;   # aka "Allowed2LD"

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

has_attr 'DomainName' =>
	is => "rw",
	isa => "XML::SRS::DomainName",
	;

with 'XML::SRS::Node';

1;
