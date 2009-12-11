
package XML::SRS::Answer;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

# DomainCreate, DomainUpdate RegistrarCreate RegistrarUpdate
# BillingAmountUpdate SysParamsUpdate RunLogCreate ScheduleCreate
# ScheduleCancel ScheduleUpdate BilledUntilAdjustment
# BuildDnsZoneFiles GenerateDomainReport AdjustRegistrarAccount
# AccessControlListRemove AccessControlListAdd 

has_attr 'Action' =>
	is => "ro",
	isa => "XML::SRS::ActionEtc",
	required => 1,
	;

has_attr 'FeId' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'FeSeq' =>
	is => "ro",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'OrigRegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	required => 1,
	;

has_attr 'RecipientRegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	;

has_attr 'TransId' =>
	is => "ro",
	isa => "XML::SRS::UID",
	;

has_attr 'Rows' =>
	is => "ro",
	isa => "XML::SRS::Number",
	;

has_attr 'MoreRowsAvailable' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	coerce => 1,
	;

has_attr 'Count' =>
	is => "ro",
	isa => "XML::SRS::Number",
	;

has_element 'FeTimeStamp' =>
	is => "ro",
	isa => "XML::SRS::FeTimeStamp",
	;

with 'XML::SRS::Node';

1;
