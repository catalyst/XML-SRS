package XML::SRS::Schedule::Cancel;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

sub root_element {
    "ScheduleCancel";
}

has_attr "ProcessName" =>
    is => "ro",
    isa => "XML::SRS::ScheduledJobType",
    xml_required => 1,
    ;

has_attr "Parameters" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;

has_element 'first_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FirstRunDate',
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
