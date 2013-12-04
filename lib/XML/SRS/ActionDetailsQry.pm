package XML::SRS::ActionDetailsQry;

use Moose;
use PRANG::Graph;

use XML::SRS::TimeStamp;

has_attr 'action_id' =>
    is => "ro",
    isa => "Str",
    xml_name => "ActionId",
    ;

has_attr 'originating_registrar_id' =>
    is => "ro",
    isa => "Str",
    xml_name => "OriginatingRegistrarId",
    xml_required => 0,
    ;

sub root_element {"ActionDetailsQry"}

with 'XML::SRS::Query';

1;
