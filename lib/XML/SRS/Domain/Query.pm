
package XML::SRS::Domain::Query;

use Moose;
use PRANG::Graph;
use PRANG::XMLSchema::Types;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;
use PRANG::Coerce;

# attributes
has_attr 'query_id' =>
	is => 'ro',
	isa => 'XML::SRS::UID',
	xml_name => 'QryId',
	xml_required => 0,
	;

has_attr 'status' =>
	is => 'ro',
	isa => 'XML::SRS::RegDomainStatus',
	xml_name => 'Status',
	xml_required => 0,
	;

has_attr 'delegate' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'Delegate',
	xml_required => 0,
	;

has_attr 'term' =>
	is => 'ro',
	isa => 'XML::SRS::Term',
	xml_name => 'Term',
	xml_required => 0,
	;

has_attr 'registrant_ref' =>
	is => 'ro',
	isa => 'XML::SRS::UID',
	xml_name => 'RegistrantRef',
	xml_required => 0,
	;

has_attr 'max_results' =>
	is => 'ro',
	isa => 'XML::SRS::Number',
	xml_name => 'MaxResults',
	xml_required => 0,
	;

has_attr 'skip_results' =>
	is => 'ro',
	isa => 'XML::SRS::Number',
	xml_name => 'SkipResults',
	xml_required => 0,
	;

has_attr 'count_results' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_name => 'CountResults',
	xml_required => 0,
	;

# elements
has_element 'domain_name_filter' =>
	is => 'ro',
	isa => 'PRANG::Coerce::ArrayRefOfStrs',
	xml_nodeName => 'DomainNameFilter',
	xml_required => 0,
	coerce => 1,
	;

has_element 'name_server_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Server::Filter',
	xml_nodeName => 'NameServerFilter',
	xml_required => 0,
	;

has_element 'registrant_contact_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::Filter',
	xml_nodeName => 'RegistrantContactFilter',
	xml_required => 0,
	;

has_element 'admin_contact_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::Filter',
	xml_nodeName => 'AdminContactFilter',
	xml_required => 0,
	;

has_element 'technical_contact_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::Filter',
	xml_nodeName => 'TechnicalContactFilter',
	xml_required => 0,
	;

has_element 'result_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'ResultDateRange',
	;

has_element 'search_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'SearchDateRange',
	;

has_element 'changed_in_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'ChangedInDateRange',
	;

has_element 'registered_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'RegisteredDateRange',
	;

has_element 'locked_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'LockedDateRange',
	;

has_element 'cancelled_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'CancelledDateRange',
	;

has_element 'billed_until_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'BilledUntilDateRange',
	;

has_element 'audit_text_filter' =>
	is => 'ro',
	isa => 'Str',
	xml_required => 0,
	xml_nodeName => 'AuditTextFilter'
	;

has_element 'action_id_filter' =>
	is => 'ro',
	isa => 'Str',
	xml_required => 0,
	xml_nodeName => 'ActionIdFilter'
	;

has_element 'field_list' =>
	is => 'ro',
	isa => 'XML::SRS::FieldList',
	xml_required => 0,
	xml_nodeName => 'FieldList',
	;

sub root_element { 'DomainDetailsQry' }
with 'XML::SRS::Query';

1;
