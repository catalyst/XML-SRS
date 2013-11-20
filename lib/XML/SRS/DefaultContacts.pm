package XML::SRS::DefaultContacts;

use Moose;

use PRANG::Graph;
use Moose::Util::TypeConstraints;

has_attr 'admin_contact' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_required => 0,
	xml_name => 'AdminContact',
	;

has_attr 'technical_contact' =>
	is => 'ro',
	isa => 'XML::SRS::Boolean',
	xml_required => 0,
	xml_name => 'TechnicalContact',
	;
	
coerce __PACKAGE__
    => from "HashRef"
    => via { __PACKAGE__->new(%$_); };
	
with 'XML::SRS::Node';

1;