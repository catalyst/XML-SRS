
package XML::SRS::Zone::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

use Moose::Util::TypeConstraints;

has_element 'zones' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Zone]",
	xml_nodeName => "SecondLD",
	xml_required => 0,	
	;

coerce __PACKAGE__
    => from 'ArrayRef[HashRef]'
    => via {
    __PACKAGE__->new(
        zones => [
            map {
                XML::SRS::Zone->new($_);
                } @$_
        ],
    );
};


with 'XML::SRS::Node';

1;
