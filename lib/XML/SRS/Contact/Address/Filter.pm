
package XML::SRS::Contact::Address::Filter;

use Moose;
use PRANG::Graph;

extends 'XML::SRS::Contact::Address';

with 'XML::SRS::Node';

use Moose::Util::TypeConstraints;

coerce __PACKAGE__
    => from "HashRef"
    => via { __PACKAGE__->new(%$_); };

1;
