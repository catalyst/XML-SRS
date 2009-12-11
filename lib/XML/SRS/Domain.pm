
package XML::SRS::Domain;
use Moose;
use PRANG::Graph;

has_attr 'name' =>
	is => "ro",
	isa => "XML::SRS::DomainName",
	xml_name => "DomainName",
	;

has_attr 'registrant_ref' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "RegistrantRef",
	xml_required => 0,
	;

has_attr 'registrar_name' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "RegistrarName",
	xml_required => 0,
	;

has_attr 'status' =>
	is => "ro",
	isa => "XML::SRS::DomainStatus",
	xml_name => "Status",
	xml_required => 0,
	;

has_attr 'delegate' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	xml_name => "Delegate",
	xml_required => 0,
	;

has_attr 'term' =>
	is => "ro",
	isa => "XML::SRS::Term",
	xml_name => "Term",
	xml_required => 0,
	;

sub root_element {
	"Domain";
}
with 'XML::SRS::ActionResponse';

1;
