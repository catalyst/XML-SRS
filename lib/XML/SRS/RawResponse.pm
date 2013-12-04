package XML::SRS::RawResponse;

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

sub root_element { 'RawResponse' }

1;
