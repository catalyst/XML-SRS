
package XML::SRS::Node;

use Moose::Role;

with 'XML::SRS::JSON';

sub xmlns { }  # no namespaces required.

1;
