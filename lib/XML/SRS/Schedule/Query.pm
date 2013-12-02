package XML::SRS::Schedule::Query;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::TimeStamp;

sub root_element {
    "ScheduleQry";
}

has_attr "ProcessName" =>
    is => "ro",
    isa => "XML::SRS::ScheduledJobType",
    xml_required => 0,
    ;

has_attr "Parameters" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;

has_element 'active_on' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'ActiveOn',
    xml_required => 0,
    coerce => 1,
    ;

has_element 'first_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FirstRunDate',
    xml_required => 0,
    coerce => 1,
    ;

with 'XML::SRS::Query';

1;
