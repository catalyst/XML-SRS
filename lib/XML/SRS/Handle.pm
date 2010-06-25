
package XML::SRS::Handle;
use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use PRANG::XMLSchema::Types;

# attributes
has_attr 'handle_id' =>
	is => "ro",
	isa => "XML::SRS::HandleId",
	xml_name => "HandleId",
	predicate => "has_handle_id",
	;

has_attr 'name' =>
	is => "ro",
	isa => "Str",
	xml_name => "Name",
	predicate => "has_name",
	;

has_attr 'email' =>
	is => "ro",
	isa => "XML::SRS::Email",
	xml_name => "Email",
	predicate => "has_email",
	;

has_attr 'action_id' =>
	is => "ro",
	isa => "Str",
	xml_name => "ActionId",
	predicate => "has_action_id",
	;

has_attr 'registrar_id' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::positiveInteger',
	xml_name => 'RegistrarId',
	xml_required => 0,
	predicate => 'has_registrar_id',
	;

# elements
has_element 'address' =>
	is => "ro",
	isa => "XML::SRS::Contact::Address",
	xml_nodeName => "PostalAddress",
	predicate => "has_address",
	coerce => 1,
	;

has_element 'phone' =>
	is => "ro",
	isa => "XML::SRS::Contact::PSTN",
	predicate => "has_phone",
	xml_nodeName => "Phone",
	coerce => 1,
	;

has_element 'fax' =>
	is => "ro",
	isa => "XML::SRS::Contact::PSTN",
	predicate => "has_fax",
	xml_nodeName => "Fax",
	coerce => 1,
	;

has_element 'audit' =>
	is => "rw",
	isa => "XML::SRS::AuditDetails",
	xml_nodeName => "AuditDetails",
	predicate => "has_audit",
	;

sub root_element {
	"Handle";
}
with 'XML::SRS::ActionResponse';

1;
