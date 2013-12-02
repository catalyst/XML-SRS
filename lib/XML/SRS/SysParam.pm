package XML::SRS::SysParam;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::AuditDetails;

has_attr "name" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'Name',
    ;
    
has_element "value" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_nodeName => 'ParamValue',
    ;

has_element 'audit' =>
    is => "rw",
    isa => "XML::SRS::AuditDetails",
    xml_nodeName => "AuditDetails",
    predicate => "has_audit",
    traits => [qw(Aliased)],    
    alias => 'audit_details',
    coerce => 1,
    ;

sub root_element {
    "SysParam";
}

with 'XML::SRS::ActionResponse';
