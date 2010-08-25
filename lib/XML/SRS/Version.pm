
package XML::SRS::Version;
use Moose::Role;
use PRANG::Graph;
use MooseX::Method::Signatures;

has_attr "major" =>
	is => "rw",
	isa => "Int",
	required => 1,
	xml_name => "VerMajor",
	;

has_attr "minor" =>
	is => "rw",
	isa => "Int",
	required => 1,
	xml_name => "VerMinor",
	;

has "version" =>
	is => "ro",
	isa => "Str",
	lazy => 1,
	default => sub {
	my $self = shift;
	$self->major.".".$self->minor;
	},
	;

method buildargs_version( $inv: Str $version ) {
	$version = $XML::SRS::PROTOCOL_VERSION
		if $version eq "auto";
	my ($vmaj, $vmin) = split /\./, $version;
	(major => 0+$vmaj, minor => 0+$vmin);
}

1;
