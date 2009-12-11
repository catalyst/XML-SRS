
package XML::SRS::Time;

use Moose::Role;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

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
		m{^[-+][\s\d]?\d:?\d\d$};
	};

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
	;

1;
