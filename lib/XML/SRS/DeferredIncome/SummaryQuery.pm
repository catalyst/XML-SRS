package XML::SRS::DeferredIncome::SummaryQuery;

use Moose;
use PRANG::Graph;

has_attr "base_month" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'BaseMonth',
    ;

has_attr "base_year" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'BaseYear',
    ;

has_attr "income_month" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'IncomeMonth',
    ;

has_attr "income_year" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'IncomeYear',
    ;

sub root_element {"DeferredIncomeSummaryQry"}
with 'XML::SRS::Query';

1;
