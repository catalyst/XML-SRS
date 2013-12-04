package XML::SRS::BilledUntilAdjustment;

use Moose;
use PRANG::Graph;

use XML::SRS::TimeStamp;

has_attr 'domain_name' =>
    is => "ro",
    isa => "Str",
    xml_name => "DomainName",
    ;

has_element 'new_billed_until_date' =>
    is => "ro",
    isa => "XML::SRS::TimeStamp",
    xml_nodeName => "NewBilledUntilDate",
    required => 1,
    coerce => 1,
    ;

sub root_element {"BilledUntilAdjustment"}

with 'XML::SRS::Action', 'XML::SRS::Audit';

1;
