
package XML::SRS::Domain;
use Moose;
use PRANG::Graph;
use XML::SRS::Types;

has_attr 'name' =>
	is => "ro",
	isa => "XML::SRS::DomainName",
	xml_name => "DomainName",
	;

has_attr 'registrant_ref' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "RegistrantRef",
	xml_required => 0,
	;

has_attr 'registrar_name' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "RegistrarName",
	xml_required => 0,
	;

has_attr 'status' =>
	is => "ro",
	isa => "XML::SRS::DomainStatus",
	xml_name => "Status",
	xml_required => 0,
	;

has_attr 'delegate' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	xml_name => "Delegate",
	xml_required => 0,
	;

has_attr 'term' =>
	is => "ro",
	isa => "XML::SRS::Term",
	xml_name => "Term",
	xml_required => 0,
	;

has_attr 'registrar_id' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_name => "RegistrarId",
	xml_required => 0,
	;

has_attr 'UDAI' =>
	is => "ro",
	isa => 'XML::SRS::UDAI',
	xml_name => "UDAI",
	xml_required => 0,
	;

# elements
has_element 'nameservers' =>
	is => 'ro',
	isa => 'XML::SRS::Server::List',
	xml_nodeName => 'NameServers',
	xml_required => 0,
	;

has_element 'contact_registrant' =>
	is => 'ro',
	isa => 'XML::SRS::Contact',
	xml_nodeName => 'RegistrantContact',
	xml_required => 0,
	coerce => 1,
	;

# I think this element is wrong.
has_element 'contact_registrar_public' =>
	is => 'ro',
	isa => 'XML::SRS::Contact',
	xml_nodeName => 'RegistrarPublicContact',
	xml_required => 0,
	coerce => 1,
	;

has_element 'contact_admin' =>
	is => 'ro',
	isa => 'XML::SRS::Contact',
	xml_nodeName => 'AdminContact',
	xml_required => 0,
	coerce => 1,
	;

has_element 'contact_technical' =>
	is => 'ro',
	isa => 'XML::SRS::Contact',
	xml_nodeName => 'TechnicalContact',
	xml_required => 0,
	coerce => 1,
	;

has_element 'billed_until' =>
	is => 'ro',
	isa => 'XML::SRS::TimeStamp',
	xml_required => 0,
	xml_nodeName => 'BilledUntil',
	;

has_element 'registered_date' =>
	is => 'ro',
	isa => 'XML::SRS::TimeStamp',
	xml_required => 0,
	xml_nodeName => 'RegisteredDate',
	;

has_element 'cancelled_date' =>
	is => 'ro',
	isa => 'XML::SRS::TimeStamp',
	xml_required => 0,
	xml_nodeName => 'CancelledDate',
	;

has_element 'locked_date' =>
	is => 'ro',
	isa => 'XML::SRS::TimeStamp',
	xml_required => 0,
	xml_nodeName => 'LockedDate',
	;

has_element 'audit' =>
	is => "rw",
	isa => "XML::SRS::AuditDetails",
	xml_nodeName => "AuditDetails",
	predicate => "has_audit",
	;

sub root_element {
	"Domain";
}
with 'XML::SRS::ActionResponse';

1;
