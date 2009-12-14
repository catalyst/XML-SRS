
package XML::SRS::Contact::Address;

use Moose;
use MooseX::Method::Signatures;
use PRANG::Graph;

method address() {
	( $self->address1,
	  $self->address2,
	  $self->city,
	  $self->region,
	  $self->postcode,
	  $self->cc,
	 );
}

has_attr 'address1' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "Address1",
	;

has_attr 'address2' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "Address2",
	;

has_attr 'city' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "City",
	;

has_attr 'region' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "Province",
	;

has_attr 'cc' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "CountryCode",
	;

has_attr 'postcode' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_name => "PostalCode",
	;

with 'XML::SRS::Node';

1;
