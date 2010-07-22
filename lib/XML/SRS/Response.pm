
package XML::SRS::Response;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Result;
use XML::SRS::Error;

has_attr "registrar_id" =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	xml_name => "RegistrarId",
	;

has_element "results" =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Result|XML::SRS::Error]",
	xml_nodeName => {
		Response => "XML::SRS::Result",
		Error => "XML::SRS::Error",
	},
	required => 1,
	;

sub root_element { "NZSRSResponse" }
with 'XML::SRS', 'XML::SRS::Node', 'XML::SRS::Version';

sub BUILDARGS {
	my $inv = shift;
	my %args = @_;
	if ( $args{version} ) {
		%args = (%args, $inv->buildargs_version($args{version}));
	}
	\%args;
}

1;

