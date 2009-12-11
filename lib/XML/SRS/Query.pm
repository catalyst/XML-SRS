
package XML::SRS::Query;

use Moose::Role;
use PRANG::Graph;
use XML::SRS::Types;

with 'XML::SRS::Node', "PRANG::Graph";

1;
