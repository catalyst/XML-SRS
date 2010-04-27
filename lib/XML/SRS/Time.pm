
package XML::SRS::Time;

use Moose::Role;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;

BEGIN{
subtype 'XML::SRS::Time::Hour'
	=> as "Int",
	=> where {
		$_ >= 0 and $_ <= 23;
	};
subtype 'XML::SRS::Time::Sexagesimal'
	=> as "Int",
	=> where {
		$_ >= 0 and $_ <= 59;
	};
subtype 'XML::SRS::Time::TZOffset'
	=> as "Str",
	=> where {
		m{^[-+][\s\d]?\d(?::?\d\d)?$};

	};

subtype 'XML::SRS::Time::hms'
	=> as "Str",
	=> where {
		m{^(\d{1,2}):(\d{1,2}):(\d{1,2})$};
	};
}

method buildargs_time($inv: XML::SRS::Time::hms $hms, Maybe[XML::SRS::Time::TZOffset] $offset?) {
	my @buildargs;
	if (defined $offset) {
		push @buildargs, tz_offset => $offset;
	}
	my ($h, $m, $s) = split ":", $hms;
	push @buildargs, hour => $h, minute => $m, second => $s;
	@buildargs;
}

has_attr 'hour' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	required => 1,
	xml_name => "Hour",
	;

has_attr 'minute' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	required => 1,
	xml_name => "Minute",
	;

has_attr 'second' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	xml_name => "Second",
	;

has_attr 'tz_offset' =>
	is => "rw",
	isa => "XML::SRS::Time::TZOffset",
	xml_required => 0,
	clearer => "make_floating",
	xml_name => "TimeZoneOffset",
	;

1;
