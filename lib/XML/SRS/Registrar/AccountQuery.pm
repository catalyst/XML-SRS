
package XML::SRS::Registrar::AccountQuery;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Date::Range;

has_attr 'registrar_ref' =>
    is => "ro",
    isa => "Str",
    xml_name => "RegistrantRef",
    xml_required => 0,
    ;

has_attr 'domain_name' =>
    is => "ro",
    isa => "XML::SRS::DomainName",
    xml_name => "DomainName",
    xml_required => 0,
    ;
    
has_attr 'invoice_id' =>
    is => "ro",
    isa => "Str",
    xml_name => "InvoiceId",
    xml_required => 0,
    ;

has_attr 'max_results' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "MaxResults",
    xml_required => 0,
    ;

has_attr 'skip_results' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "SkipResults",
    xml_required => 0,
    ;

has_attr 'transaction_status' =>
    is => "ro",
    isa => "XML::SRS::BillStatus",
    xml_name => "TransStatus",
    xml_required => 0,
    ;
    
has_attr 'count_results' =>
    is => 'ro',
    isa => 'XML::SRS::Boolean',
    xml_name => 'CountResults',
    xml_required => 0,
    ;
    
has_element 'transaction_date_range' =>
    is => 'ro',
    isa => 'XML::SRS::Date::Range',
    xml_required => 0,
    xml_nodeName => 'TransDateRange',
    coerce => 1,
    required => 0,
    ;

has_element 'invoice_date_range' =>
    is => 'ro',
    isa => 'XML::SRS::Date::Range',
    xml_required => 0,
    xml_nodeName => 'InvoiceDateRange',
    coerce => 1,
    required => 0,
    ;

sub root_element {"RegistrarAccountQry"}
with 'XML::SRS::Query';

1;
