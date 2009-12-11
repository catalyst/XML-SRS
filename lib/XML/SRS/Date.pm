
package XML::SRS::Date;

use Moose::Role;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

subtype 'XML::SRS::Date::Year'
	=> as "Int",
	=> where {
		length(0+$_) == 4;
	};
subtype 'XML::SRS::Date::Month'
	=> as "Int",
	=> where {
		$_ >= 1 and $_ <= 12;
	};
subtype 'XML::SRS::Date::Day'
	=> as "Str",
	=> where {
		$_ >= 1 and $_ <= 31;
	};

has_attr 'Year' =>
	is => "rw",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'Month' =>
	is => "rw",
	isa => "XML::SRS::Number",
	required => 1,
	;

has_attr 'Day' =>
	is => "rw",
	isa => "XML::SRS::Number",
	required => 1,
	;

1;
