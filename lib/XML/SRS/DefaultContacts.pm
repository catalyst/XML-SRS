package XML::SRS::DefaultContacts;

use Moose;

use PRANG::Graph;

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
	
with 'XML::SRS::Node';

1;