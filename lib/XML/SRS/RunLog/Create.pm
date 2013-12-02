package XML::SRS::RunLog::Create;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::TimeStamp;

sub root_element {
    "RunLogCreate";
}

has_element 'first_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FirstRunDate',
    required => 1,
    coerce => 1,
    ;

has_element 'run_log' =>
    is => "rw",
    isa => "XML::SRS::RunLog",
    xml_nodeName => "RunLog",
    required => 1,
    ;

with 'XML::SRS::Action';

1;
