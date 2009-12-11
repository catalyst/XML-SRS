
package XML::SRS::ActionResponse;

use Moose::Role;
use PRANG::Graph;
use XML::SRS::Types;

# the ActionId is on the Response node (XML::SRS::Result)

with 'XML::SRS::Node', 'PRANG::Graph';

1;
