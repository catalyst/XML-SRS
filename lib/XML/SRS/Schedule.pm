package XML::SRS::Schedule;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::TimeStamp;

has_attr "ProcessName" =>
    is => "ro",
    isa => "XML::SRS::ScheduledJobType",
    xml_required => 1,
    ;

has_attr "Frequency" =>
    is => "ro",
    isa => "Str",
    xml_required => 1,
    ;

has_attr "Parameters" =>
    is => "ro",
    isa => "Str",
    xml_required => 0,
    ;
    
has_attr "created_by_registrar" =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_required => 0,
    xml_name => 'CreateByRegistrarId',
    ;
    
has_attr "created_action_id" =>
    is => "ro",
    isa => "XML::SRS::UID",
    xml_required => 0,
    xml_name => 'CreateActionId',
    ;

has_attr "cancelled_by_registrar" =>
    is => "ro",
    isa => "XML::SRS::Number",
    xml_required => 0,
    xml_name => 'CancelByRegistrarId',
    ;
    
has_attr "cancelled_action_id" =>
    is => "ro",
    isa => "XML::SRS::UID",
    xml_required => 0,
    xml_name => 'CancelActionId',
    ;

has_element 'first_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FirstRunDate',
    required => 1,
    coerce => 1,
    ;

has_element 'final_run_date' =>
    is => 'ro',
    isa => 'XML::SRS::TimeStamp',
    xml_nodeName => 'FinalRunDate',
    xml_required => 0,
    coerce => 1,
    ;
    
has_element 'create_audit_text' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "CreateAuditText",
    xml_required => 0,
    ;

has_element 'cancel_audit_text' =>
    is => "rw",
    isa => "Str",
    xml_nodeName => "CancelAuditText",
    xml_required => 0,
    ;

sub root_element {
    "Schedule";
}
with 'XML::SRS::ActionResponse';



1;
