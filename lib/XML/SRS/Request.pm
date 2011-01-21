
package XML::SRS::Request;

use Moose;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

use XML::SRS::Types;

use XML::SRS::Query;
use XML::SRS::Action;
use XML::SRS::ActionResponse;

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
	required => 1,
	;

sub root_element {"NZSRSRequest"}
with 'XML::SRS', "XML::SRS::Version";

sub BUILDARGS {
	my $inv = shift;
	my %args = @_;
	if ( $args{version} ) {
		%args = (%args, $inv->buildargs_version($args{version}));
	}
	\%args;
}

1;

