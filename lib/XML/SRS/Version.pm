
package XML::SRS::Version;
use Moose::Role;
use PRANG::Graph;

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
	trigger => sub {
		my $self = shift;
		my $version = shift;
		$version = $XML::SRS::PROTOCOL_VERSION
			if $version eq "auto";
		my ($vmaj, $vmin) = split "\.", $version;
		$self->major(0+$vmaj);
		$self->minor(0+$vmin);
	},
	;

1;
