package XML::SRS::Domain::Update;

use Moose;
use PRANG::Graph;
use PRANG::XMLSchema::Types;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;
use PRANG::Coerce;
use XML::SRS::Server::List;
use XML::SRS::DS::List;

# attributes
has_attr 'udai' =>
	is => 'ro',
	isa => 'XML::SRS::UDAI',
	xml_name => 'UDAI',
	xml_required => 0;

has_attr 'new_udai' =>
	is => 'rw',
	isa => 'XML::SRS::Boolean',
	xml_name => 'NewUDAI',
	xml_required => 0;

has_attr 'registrant_ref' =>
	is => 'ro',
	isa => 'XML::SRS::UID',
	xml_name => 'RegistrantRef',
	xml_required => 0,
	;

has_attr 'term' =>
	is => 'ro',
	isa => 'XML::SRS::Term',
	xml_name => 'Term',
	xml_required => 0,
	;

has_attr 'delegate' =>
	is => 'rw',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Delegate',
	xml_required => 0,
	;

has_attr 'renew' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Renew',
	xml_required => 0,
	;

has_attr 'no_auto_renew' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'NoAutoRenew',
	xml_required => 0,
	;

has_attr 'lock' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Lock',
	xml_required => 0,
	;

has_attr 'cancel' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Cancel',
	xml_required => 0,
	;

has_attr 'release' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Release',
	xml_required => 0,
	;

has_attr 'full_result' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'FullResult',
	xml_required => 0,
	;

has_attr 'convert_contacts_to_handles' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'ConvertContactsToHandles',
	xml_required => 0,
	;

# elements
has_element 'filter' =>
	is => 'ro',
	isa => 'PRANG::Coerce::ArrayRefOfStrs',
	xml_nodeName => 'DomainNameFilter',
	xml_required => 1,
    coerce => 1,
	;

has_element 'contact_registrant' =>
	is => 'ro',
	isa => 'XML::SRS::Contact',
	xml_nodeName => 'RegistrantContact',
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

has_element 'nameservers' =>
	is => 'ro',
	isa => 'XML::SRS::Server::List',
	xml_nodeName => 'NameServers',
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

sub root_element {'DomainUpdate'}
with 'XML::SRS::Action';

1;
