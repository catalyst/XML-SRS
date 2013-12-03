
package XML::SRS::BillingTrans;
use Moose;
use PRANG::Graph;

use XML::SRS::Types;
use XML::SRS::TimeStamp;

has_attr 'registrar_id' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "RegistrarId",
    ;

has_attr 'type' =>
    is => "ro",
    isa => "Str",
    xml_name => "Type",
    ;
    
has_attr 'transaction_status' =>
    is => "ro",
    isa => "XML::SRS::BillStatus",
    xml_name => "TransStatus",
    ;

has_attr 'domain_name' =>
    is => "ro",
    isa => "XML::SRS::DomainName",
    xml_name => "DomainName",
    ;

has_attr 'registrar_ref' =>
    is => "ro",
    isa => "Str",
    xml_name => "RegistrarRef",
    xml_required => 0,
    ;

has_attr 'billing_term' =>
    is => "ro",
    isa => "XML::SRS::Term",
    xml_name => "BillingTerm",
    ;

has_attr 'invoice_id' =>
    is => "ro",
    isa => "Str",
    xml_name => "InvoiceId",
    xml_required => 0,
    ;

has_attr 'amount' =>
    is => "ro",
    isa => "XML::SRS::Dollars",
    xml_name => "Amount",
    xml_required => 0,
    ;

has_element 'invoice_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_required => 0,
    xml_nodeName => 'InvoiceDate',
    coerce => 1,
    ;

has_element 'transaction_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    required => 1,
    xml_nodeName => 'TransDate',
    coerce => 1,
    ;
    
has_element 'bill_period_start' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    required => 1,
    xml_nodeName => 'BillPeriodStart',
    coerce => 1,
    ;

has_element 'bill_period_end' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    required => 1,
    xml_nodeName => 'BillPeriodEnd',
    coerce => 1,
    ;

sub root_element {
    "BillingTrans";
}
with 'XML::SRS::ActionResponse';

1;