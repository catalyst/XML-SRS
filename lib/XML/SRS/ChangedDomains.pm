
package XML::SRS::ChangedDomains;

use Moose;
use PRANG::Graph;

use Moose::Util::TypeConstraints;

has_element 'domains' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Domain]",
	xml_nodeName => "Domain",
	xml_required => 0,
	;

coerce __PACKAGE__
    => from 'ArrayRef[HashRef]'
    => via {
        __PACKAGE__->new(
            domains => [ map { XML::SRS::Domain->new($_) } @$_ ],
        ); 
    };

sub root_element {"ChangedDomain"}

with 'XML::SRS::Node';

1;
