package XML::SRS::SysParam::Query;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

sub root_element {
    "SysParamsQry";
}

with 'XML::SRS::Query';

1;
