
package XML::SRS::Action;

use Moose::Role;
use PRANG::Graph;
use XML::SRS::Types;

# DomainCreate, DomainUpdate RegistrarCreate RegistrarUpdate
# BillingAmountUpdate SysParamsUpdate RunLogCreate ScheduleCreate
# ScheduleCancel ScheduleUpdate BilledUntilAdjustment
# BuildDnsZoneFiles GenerateDomainReport AdjustRegistrarAccount
# AccessControlListRemove AccessControlListAdd

has_attr 'action_id' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => 'ActionId',
	required => 1,
	;

with 'XML::SRS::Node', "PRANG::Graph";

1;
