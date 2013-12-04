package XML::SRS::DeferredRegistrarIncome;
use Moose;
use PRANG::Graph;

use XML::SRS::Types;

has_attr "base_month" =>
    is => "ro",
    isa => "Str",
    xml_name => 'BaseMonth',
    ;

has_attr "base_year" =>
    is => "ro",
    isa => "Str",
    xml_name => 'BaseYear',
    ;

has_attr "income_month" =>
    is => "ro",
    isa => "Str",
    xml_name => 'IncomeMonth',
    ;

has_attr "income_year" =>
    is => "ro",
    isa => "Str",
    xml_name => 'IncomeYear',
    ;

has_attr 'registrar_id' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "RegistrarId",
    ;
    
has_attr 'billed_amount' =>
    is => "ro",
    isa => "XML::SRS::Dollars",
    xml_name => "BilledAmount",
    ;

has_attr 'billed_count' =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_name => "BilledCount",
    ;

sub root_element {
    "DeferredRegistrarIncome";
}
with 'XML::SRS::ActionResponse';