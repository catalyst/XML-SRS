package XML::SRS::BillingAmount::Update;

use Moose;
use PRANG::Graph;

has_element 'billing_amount' =>
    is => "ro",
    isa => "XML::SRS::BillingAmount",
    xml_nodeName => "BillingAmount",
    required => 1,
    ;

sub root_element {"BillingAmountUpdate"}

with 'XML::SRS::Action';

1;
