package XML::SRS::RunLog::Query;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::Date::Range;

sub root_element {
    "RunLogQry";
}

has_attr "ProcessName" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;

has_attr "Parameters" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;


has_element 'log_date_range' =>
    is => 'ro',
    isa => 'XML::SRS::Date::Range',
    xml_required => 0,
    xml_nodeName => 'LogDateRange',
    coerce => 1,
    ;

with 'XML::SRS::Query';

1;
