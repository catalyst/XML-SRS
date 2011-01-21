
package XML::SRS::Contact::Address;

use Moose;
use PRANG::Graph;

sub address() {
    my $self = shift;
    
	(   $self->address1,
		$self->address2,
		$self->city,
		$self->region,
		$self->postcode,
		$self->cc,
	);
}

has_attr 'address1' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "Address1",
	;

has_attr 'address2' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "Address2",
	;

has_attr 'city' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "City",
	;

has_attr 'region' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "Province",
	;

has_attr 'cc' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "CountryCode",
	;

has_attr 'postcode' =>
	is => "rw",
	isa => "Str",
	xml_required => 0,
	xml_name => "PostalCode",
	;

with 'XML::SRS::Node';

use Moose::Util::TypeConstraints;

coerce __PACKAGE__
	=> from "HashRef"
	=> via { __PACKAGE__->new(%$_); };

1;
