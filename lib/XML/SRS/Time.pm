
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

method setup_time(XML::SRS::Time::hms $hms, Maybe[XML::SRS::Time::TZOffset] $offset?) {
	$self->setup_time_hms(split ":", $hms);
	if ( !defined $offset ) {
		$self->make_floating;
	}
	else {
		$self->TimeZoneOffset($offset);
	}
}

method setup_time_hms( XML::SRS::Time::Hour $h, XML::SRS::Time::Sexagesimal $m, XML::SRS::Time::Sexagesimal $s) {
	$self->Hour($h);
	$self->Minute($m);
	$self->Second($s);
}

has_attr 'Hour' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	required => 1,
	;

has_attr 'Minute' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	required => 1,
	;

has_attr 'Second' =>
	is => "rw",
	isa => "XML::SRS::Time::Sexagesimal",
	;

has_attr 'TimeZoneOffset' =>
	is => "rw",
	isa => "XML::SRS::Time::TZOffset",
	xml_required => 0,
	clearer => "make_floating",
	;

1;
