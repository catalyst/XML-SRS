package XML::SRS::BillingAmount;
use Moose;
use PRANG::Graph;

use XML::SRS::Types;
use XML::SRS::TimeStamp;

has_attr 'amount' =>
    is => "ro",
    isa => "XML::SRS::Dollars",
    xml_name => "Amount",
    xml_required => 0,
    ;

has_element 'effective_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_required => 0,
    xml_nodeName => 'EffectiveDate',
    coerce => 1,
    ;

sub root_element {
    "BillingAmount";
}
with 'XML::SRS::ActionResponse';

1;