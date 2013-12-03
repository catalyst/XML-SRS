package XML::SRS::GenerateDomainReport;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::TimeStamp;

has_element 'run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    required => 1,
    xml_nodeName => 'RunDate',
    coerce => 1,
    ;

sub root_element {"GenerateDomainReport"}
with 'XML::SRS::Action';

1;
