
package XML::SRS::Contact::Filter;

use Moose;
use PRANG::Graph;
use XML::SRS::Contact::Address;
use XML::SRS::Contact::PSTN;

# attributes
has_attr 'name' =>
	is => 'ro',
	isa => 'Str',
	xml_name => 'Name',
	xml_required => 0,
	;

has_attr 'email' =>
	is => 'ro',
	isa => 'Str',
	xml_name => 'Email',
	xml_required => 0,
	;

# elements
has_element 'postal_address_filter' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::Address',
	xml_nodeName => 'PostalAddressFilter',
	xml_required => 0,
	;

has_element 'phone' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::PSTN',
	xml_nodeName => 'Phone',
	xml_required => 0,
	;

has_element 'fax' =>
	is => 'ro',
	isa => 'XML::SRS::Contact::PSTN',
	xml_nodeName => 'Fax',
	xml_required => 0,
	;

sub root_element {'ContactFilter'}

with 'XML::SRS::Node';

1;
