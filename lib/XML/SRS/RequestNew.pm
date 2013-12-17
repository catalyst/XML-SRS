package XML::SRS::RequestNew;

# Allow parsing of Request with 'new' root element

use Moose;

extends 'XML::SRS::Request';

sub root_element { 'SRSRequest' }

1;
