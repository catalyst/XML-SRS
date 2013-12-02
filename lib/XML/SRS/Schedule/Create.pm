package XML::SRS::Schedule::Create;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::TimeStamp;

sub root_element {
    "ScheduleCreate";
}

has_attr "ProcessName" =>
    is => "ro",
    isa => "XML::SRS::ScheduledJobType",
    xml_required => 1,
    ;

has_attr "Frequency" =>
    is => "ro",
    isa => "Str",
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

has_element 'final_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FinalRunDate',
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
