
package XML::SRS::Request;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;

use XML::SRS::Types;

use XML::SRS::Query;
use XML::SRS::Action;
use XML::SRS::ActionResponse;

has_attr "major" =>
	is => "ro",
	isa => "Int",
	xml_name => "VerMajor",
	required => 1,
	;

has_attr "minor" =>
	is => "ro",
	isa => "Int",
	xml_name => "VerMinor",
	required => 1,
	;

has_attr "registrar_id" =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_name => "RegistrarId",
	xml_required => 0,
	;

role_type 'XML::SRS::Action';
role_type 'XML::SRS::Query';

has_element "requests" =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Action|XML::SRS::Query]",
	;

sub root_element { "NZSRSRequest" }
with 'XML::SRS';

1;

