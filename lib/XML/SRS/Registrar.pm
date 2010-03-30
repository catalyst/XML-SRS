
package XML::SRS::Registrar;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

use XML::SRS::Contact;
use XML::SRS::Password;
use XML::SRS::Zone::List;
use XML::SRS::Role::List;

has_attr 'id' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	required => 1,
	xml_name => "RegistrarId",
	;

has_attr 'name' =>
	is => "ro",
	isa => "Str",
	required => 1,
	xml_name => "Name",
	;

has_attr 'account_reference' =>
	is => "ro",
	isa => "Str",
	required => 1,
	xml_name => "AccRef",
	;

has_attr 'url' =>
	is => "ro",
	isa => "Str",
	xml_name => "URL",
	xml_required => 0,
	;

has_element 'contact_public' =>
	is => "rw",
	isa => "XML::SRS::Contact",
	xml_nodeName => "RegistrarPublicContact",
	;

has_element 'contact_private' =>
	is => "rw",
	isa => "XML::SRS::Contact",
	xml_nodeName => "RegistrarSRSContact",
	;

has_element 'contact_technical' =>
	is => "rw",
	isa => "XML::SRS::Contact",
	xml_nodeName => "DefaultTechnicalContact",
	;

has_element 'keyring' =>
	is => "rw",
	isa => "XML::SRS::Keyring",
	xml_nodeName => "EncryptKeys",
	;

has_element 'epp_auth' =>
	is => "rw",
	isa => "XML::SRS::Password",
	xml_nodeName => "EPPAuth",
	predicate => "has_epp_auth",
	;

has_element 'allowed_zones' =>
	is => "rw",
	isa => "XML::SRS::Zone::List",
	xml_nodeName => "Allowed2LDs",
	predicate => "has_allowed_zones",
	;

has_element 'roles' =>
	is => "rw",
	isa => "XML::SRS::Role::List",
	xml_nodeName => "Roles",
	predicate => "has_roles",
	;

has_element 'audit' =>
	is => "rw",
	isa => "XML::SRS::Audit",
	xml_nodeName => "AuditDetails",
	predicate => "has_audit",
	;

sub root_element { "Registrar" }
with 'XML::SRS::ActionResponse';

1;
