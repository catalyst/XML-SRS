
package XML::SRS::Handle::Query;

use Moose;
use PRANG::Graph;
use PRANG::XMLSchema::Types;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;
use PRANG::Coerce;
use XML::SRS::Date::Range;

# attributes
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
has_element 'handle_id_filter' =>
	is => 'rw',
	isa => 'PRANG::Coerce::ArrayRefOfStrs',
	xml_nodeName => 'HandleIdFilter',
	xml_required => 0,
	coerce => 1,
	;

has_element 'search_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'SearchDateRange',
	coerce => 1,
	;

has_element 'changed_in_date_range' =>
	is => 'ro',
	isa => 'XML::SRS::Date::Range',
	xml_required => 0,
	xml_nodeName => 'ChangedInDateRange',
	coerce => 1,
	;

has_element 'contact_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::Filter',
	xml_nodeName => 'ContactFilter',
	xml_required => 0,
	coerce => 1,
	;

sub root_element {'HandleDetailsQry'}
with 'XML::SRS::Query';

1;
