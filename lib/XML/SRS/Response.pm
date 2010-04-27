
package XML::SRS::Response;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Result;
use XML::SRS::Error;

has_attr "RegistrarId" =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	;

has_element "results" =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Result|XML::SRS::Error]",
	xml_nodeName => {
		Response => "XML::SRS::Result",
		Error => "XML::SRS::Error",
	},
	;

sub root_element { "NZSRSResponse" }
with 'XML::SRS', 'XML::SRS::Node', 'XML::SRS::Version';

1;

