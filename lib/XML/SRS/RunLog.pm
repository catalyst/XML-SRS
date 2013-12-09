package XML::SRS::RunLog;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use XML::SRS::Types;
use XML::SRS::TimeStamp;

has_attr "ProcessName" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    ;

has_attr "Parameters" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;
    
has_attr "ActionStatus" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;
    
has_attr "Control" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;
    
has_element 'timestamp' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'RunLogTimeStamp',
    required => 1,
    coerce => 1,
    ;

has_element 'details' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "RunLogDetails",
    xml_required => 0,
    ;

coerce __PACKAGE__
    => from 'HashRef'
    => via { __PACKAGE__->new(%$_); };

sub root_element {
    "RunLog";
}
with 'XML::SRS::ActionResponse';



1;
