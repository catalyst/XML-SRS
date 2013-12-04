package XML::SRS::BillingAmount::Query;

use Moose;
use PRANG::Graph;

sub root_element {"BillingAmountQry"}

with 'XML::SRS::Query';

1;
