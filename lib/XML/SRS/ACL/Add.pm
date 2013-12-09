package XML::SRS::ACL::Add;

use Moose;
use PRANG::Graph;

use XML::SRS::ACL::Entry;

sub root_element {
    "AccessControlListAdd";
}

has_attr "Resource" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    ;

has_attr "List" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    ;

has_attr "FullResult" =>
    is => "ro",
    isa => "Bool",
    coerce => 1,
    default => 0,
    ;

has_element "entries" =>
    is => "rw",
    isa => "ACLEntryArrayRef",
    xml_nodeName => "AccessControlListEntry",
    xml_required => 0,
    coerce => 1,
    ;
    
has_element 'audit_text' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "AuditText",
    predicate => "has_audit",
    ;


with 'XML::SRS::Action';

1;
