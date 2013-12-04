package XML::SRS::AdjustRegistrarAccount;

use Moose;
use PRANG::Graph;

use XML::SRS::TimeStamp;

has_attr 'registrar_id' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "RegistrarId",
    ;

has_attr 'domain_name' =>
    is => "ro",
    isa => "XML::SRS::DomainName",
    xml_name => "DomainName",
    ;
    
has_attr 'months' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "Months",
    ;
    
has_attr 'action_type' =>
    is => "ro",
    isa => "XML::SRS::AccountingAction",
    xml_name => "ActionType",
    ;

has_element 'transaction_date' =>
    is => "ro",
    isa => "XML::SRS::TimeStamp",
    xml_nodeName => "TransactionDate",
    required => 1,
    coerce => 1,
    ;

has_element 'bill_period_start' =>
    is => "ro",
    isa => "XML::SRS::TimeStamp",
    xml_nodeName => "BillPeriodStart",
    required => 1,
    coerce => 1,
    ;

has_element 'bill_period_end' =>
    is => "ro",
    isa => "XML::SRS::TimeStamp",
    xml_nodeName => "BillPeriodEnd",
    required => 1,
    coerce => 1,
    ;

sub root_element {"AdjustRegistrarAccount"}

with 'XML::SRS::Action', 'XML::SRS::Audit';

1;
