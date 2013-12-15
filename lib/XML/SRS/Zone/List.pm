
package XML::SRS::Zone::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

use Moose::Util::TypeConstraints;

subtype 'XML::SRS::ZoneArrayRef',
    as "ArrayRef[XML::SRS::Zone]";

coerce "XML::SRS::ZoneArrayRef"
    => from 'ArrayRef[Str]'
    => via {
        [
            map {
                XML::SRS::Zone->new(DomainName => $_);
                } @$_
        ],
    };

has_element 'zones' =>
	is => "rw",
	isa => "XML::SRS::ZoneArrayRef",
	xml_nodeName => "SecondLD",
	xml_required => 0,
	coerce => 1,
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
