package XML::SRS::SysParam::Update;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::SysParam;

sub root_element {
    "SysParamsUpdate";
}

has_element 'sys_param' =>
    is => "rw",
    isa => "XML::SRS::SysParam",
    xml_nodeName => "SysParam",
    required => 1,
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
