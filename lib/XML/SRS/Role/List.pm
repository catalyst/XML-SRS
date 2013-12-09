
package XML::SRS::Role::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Role;

use Moose::Util::TypeConstraints;

has_element 'roles' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Role]",
	xml_nodeName => "Role",
	xml_required => 0,
	;

coerce __PACKAGE__
    => from 'ArrayRef[HashRef]'
    => via {
    __PACKAGE__->new(
        roles => [
            map {
                XML::SRS::Role->new($_);
                } @$_
        ],
    );
};

with 'XML::SRS::Node';

1;
