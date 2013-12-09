package XML::SRS::Handle::Create;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Server::List;
use XML::SRS::AuditDetails;

# attributes
has_attr 'handle_id' =>
	is => "ro",
	isa => "Str",
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
	isa => "Str",
	xml_name => "Email",
	predicate => "has_email",
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
	coerce => 1,
	;

with 'XML::SRS::Audit';

sub root_element {'HandleCreate'}
with 'XML::SRS::Action';

1;
