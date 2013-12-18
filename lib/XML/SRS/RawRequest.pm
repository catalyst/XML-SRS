package XML::SRS::RawRequest;

use Moose;
use PRANG::Graph;

has_element 'xml' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "XML",
    ;


has_element 'signature' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "Signature",
    ;

with 'XML::SRS::ActionResponse';

sub root_element { 'RawRequest' }

1;
