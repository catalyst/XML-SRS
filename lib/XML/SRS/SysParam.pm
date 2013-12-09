package XML::SRS::SysParam;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::Types;
use XML::SRS::AuditDetails;

has_attr "name" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_name => 'Name',
    ;
    
has_element "value" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    xml_nodeName => 'ParamValue',
    ;

has_element 'audit' =>
    is => "rw",
    isa => "XML::SRS::AuditDetails",
    xml_nodeName => "AuditDetails",
    predicate => "has_audit",
    traits => [qw(Aliased)],    
    alias => 'audit_details',
    coerce => 1,
    ;

coerce __PACKAGE__
    => from 'HashRef'
    => via { __PACKAGE__->new(%$_); };

sub root_element {
    "SysParam";
}

with 'XML::SRS::ActionResponse';
