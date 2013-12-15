
package XML::SRS::Role::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Role;

use Moose::Util::TypeConstraints;

subtype 'XML::SRS::RoleArrayRef',
    as "ArrayRef[XML::SRS::Role]";

coerce "XML::SRS::RoleArrayRef"
    => from 'ArrayRef[Str]'
    => via {
        [
            map {
                XML::SRS::Role->new(RoleName => $_);
                } @$_
        ],
    };

has_element 'roles' =>
	is => "rw",
	isa => "XML::SRS::RoleArrayRef",
	xml_nodeName => "Role",
	xml_required => 0,
	coerce => 1,
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
