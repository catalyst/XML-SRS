
package XML::SRS::Handle;
use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use PRANG::XMLSchema::Types;

use XML::SRS::AuditDetails;
use XML::SRS::ChangedDomains;

extends 'XML::SRS::Contact';

has '+handle_id' =>
	required => 1,
	;

has_attr 'registrar_id' =>
	is => "rw",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	xml_name => "RegistrarId",
	;

has_element 'created_date' =>
	is => 'ro',
	isa => 'XML::SRS::TimeStamp',
	xml_required => 0,
	xml_nodeName => 'CreatedDate',
	coerce => 1,
	;

has_element 'audit' =>
	is => "rw",
	isa => "XML::SRS::AuditDetails",
	xml_nodeName => "AuditDetails",
	predicate => "has_audit",
	coerce => 1,
	;

has_element 'changed_domains' =>
	is => "ro",
	isa => "XML::SRS::ChangedDomains",
	xml_nodeName => "ChangedDomains",
	predicate => "has_changed_domains",
	coerce => 1,
	;

has_attr 'action_id' =>
	is => "rw",
	isa => "XML::SRS::UID",
	xml_name => 'ActionId',
	xml_required => 0,
	;

sub root_element {
	"Handle";
}
with 'XML::SRS::ActionResponse';

1;
