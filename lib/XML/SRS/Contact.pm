
package XML::SRS::Contact;

use Moose;
use PRANG::Graph;
use XML::SRS::Contact::Address;
use XML::SRS::Contact::PSTN;
use XML::SRS::Types;

# handles
has_attr 'handle_id' =>
	is => "ro",
	isa => "XML::SRS::HandleId",
	xml_name => "HandleId",
	predicate => "has_handle_id",
	;

has_attr 'action_id' =>
	is => "rw",
	isa => "XML::SRS::UID",
	xml_name => 'ActionId',
	xml_required => 0,
	predicate => "has_action_id",
	;

# attributes
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

# elements
has_element 'address' =>
	is => "ro",
	isa => "XML::SRS::Contact::Address",
	xml_nodeName => "PostalAddress",
	predicate => "has_address",
	coerce => 1,
	xml_required => 0,
	;

has_element 'phone' =>
	is => "ro",
	isa => "XML::SRS::Contact::PSTN",
	predicate => "has_phone",
	xml_nodeName => "Phone",
	coerce => 1,
	xml_required => 0,
	;

has_element 'fax' =>
	is => "ro",
	isa => "XML::SRS::Contact::PSTN",
	predicate => "has_fax",
	xml_nodeName => "Fax",
	coerce => 1,
	xml_required => 0,
	;

with 'XML::SRS::Node';

use Moose::Util::TypeConstraints;
coerce __PACKAGE__
	=> from "HashRef"
	=> via { __PACKAGE__->new(%$_); };
1;
