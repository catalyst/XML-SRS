
package XML::SRS::Version;
use Moose::Role;
use PRANG::Graph;
has_attr "major" =>
	is => "ro",
	isa => "Int",
	required => 1,
	xml_name => "VerMajor",
	;

has_attr "minor" =>
	is => "ro",
	isa => "Int",
	required => 1,
	xml_name => "VerMinor",
	;

has "version" =>
	is => "ro",
	isa => "Str",
	default => sub {
		my $self = shift;
		$self->VerMajor.".".$self->VerMinor;
	},
	trigger => sub {
		my $self = shift;
		my $version = $self->version;
		$version = $XML::SRS::PROTOCOL_VERSION
			if $version eq "auto";
		my ($vmaj, $vmin) = split "\.", $version;
		$self->VerMajor(0+$vmaj);
		$self->VerMinor(0+$vmin);
	},
	;

1;
