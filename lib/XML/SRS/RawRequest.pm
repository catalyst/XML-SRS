package XML::SRS::RawRequest;

use Moose;
use PRANG::Graph;

has_element 'xml' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "XML",
    required => 1,
    ;


has_element 'signature' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "Signature",
    required => 1,
    ;

with 'XML::SRS::ActionResponse';

sub root_element { 'RawRequest' }

1;
