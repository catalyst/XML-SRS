package XML::SRS::Domain::Create;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Server::List;
use XML::SRS::DS::List;

has_attr 'domain_name' =>
	is => "ro",
	isa => "XML::SRS::DomainName",
	xml_name => "DomainName",
	required => 1,
	;

has_attr 'domain_name_unicode' =>
	is => "ro",
	isa => "XML::SRS::DomainName",
	xml_name => "DomainNameUnicode",
	;

has_attr 'registrant_ref' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "RegistrantRef",
	xml_required => 0,
	;

has_attr 'term' =>
	is => "ro",
	isa => "XML::SRS::Term",
	xml_name => "Term",
	required => 1,
	;

has_attr 'delegate' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	xml_name => "Delegate",
	xml_required => 0,
	;

has_element 'contact_registrant' =>
	is => "ro",
	isa => "XML::SRS::Contact",
	xml_nodeName => "RegistrantContact",
	required => 1,
	coerce => 1,
	;

has_element 'contact_admin' =>
	is => "ro",
	isa => "XML::SRS::Contact",
	xml_nodeName => "AdminContact",
	xml_required => 0,
	coerce => 1,
	;

has_element 'contact_technical' =>
	is => "ro",
	isa => "XML::SRS::Contact",
	xml_nodeName => "TechnicalContact",
	xml_required => 0,
	coerce => 1,
	;

has_element "nameservers" =>
	is => "rw",
	isa => "XML::SRS::Server::List",
	xml_nodeName => "NameServers",
	xml_required => 0,
	coerce => 1,
	;
	
has_element "dns_sec" =>
	is => "rw",
	isa => "XML::SRS::DS::List",
	xml_nodeName => "DNSSEC",
	xml_required => 0,
	coerce => 1,
	;	

with 'XML::SRS::Audit';

sub root_element {'DomainCreate'}
with 'XML::SRS::Action';

1;
