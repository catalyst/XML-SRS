
package XML::SRS::Date;

use Moose::Role;
use PRANG::Graph;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;

BEGIN {
subtype "XML::SRS::Date::ymd"
	=> as "Str"
	=> where {
		m{^(\d{4})-(\d{1,2})-(\d{1,2})$};
	};

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
}

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

method setup_date(XML::SRS::Date::ymd $ymd) {
	$self->setup_date_ymd(split "-", $ymd);
}

method setup_time_ymd( XML::SRS::Date::Year $y, XML::SRS::Date::Month $m, XML::SRS::Date::Day $d) {
	$self->Year($y);
	$self->Month($m);
	$self->Day($d);
}

1;
