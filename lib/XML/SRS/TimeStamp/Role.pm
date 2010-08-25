
package XML::SRS::TimeStamp::Role;

use 5.010;
use XML::SRS::Date;
use XML::SRS::Time;
use Moose::Role;
use MooseX::Method::Signatures;

use MooseX::Timestamp qw();
use MooseX::TimestampTZ
	timestamptz => { -as => "_timestamptz" },
	epoch => { -as => "_epoch" },
	;

has 'timestamp' =>
	is => "rw",
	isa => "Timestamp",
	coerce => 1,
	lazy => 1,
	default => sub {
	my $self = shift;
	sprintf(
		"%.4d-%.2d-%.2d %.2d:%.2d:%.2d",
		$self->year, $self->month, $self->day,
		$self->hour, $self->minute, $self->second//0,
	);
	},
	;

method buildargs_timestamp( $inv: Timestamp $timestamp is coerce ) {
	my ($date, $time) = split " ", $timestamp;
	($inv->buildargs_time($time), $inv->buildargs_date($date));
}

method buildargs_timestamptz( $inv: TimestampTZ $timestamptz is coerce ) {
	$timestamptz =~ m{
		(?<ymd>\d+-\d+-\d+)
		\s(?<hms>\d+:\d+:\d+)
		(?: (?<utc>Z) | (?<offset> [+-]\d{2} (?::?\d{2})? )
		)}x or warn "$timestamptz didn't match";
	my $hms = $+{hms};
	my $ymd = $+{ymd};
	my $offset = $+{utc} ? "+00:00" : $+{offset};
	(   $inv->buildargs_time($hms, $offset),
		$inv->buildargs_date($ymd)
	);
}

method buildargs_epoch( $inv: time_t $epoch is coerce ) {
	$inv->buildargs_timestamptz(_timestamptz $epoch);
}

has 'timestamptz' =>
	is => "rw",
	isa => "TimestampTZ",
	coerce => 1,
	lazy => 1,
	default => sub {
	my $self = shift;
	sprintf(
		"%.4d-%.2d-%.2d %.2d:%.2d:%.2d%s",
		$self->year, $self->month, $self->day,
		$self->hour, $self->minute, $self->second//0,
		$self->tz_offset//"",
	);
	},
	;

has 'epoch' =>
	is => "rw",
	isa => "time_t",
	coerce => 1,
	lazy => 1,
	default => sub {
	my $self = shift;
	_epoch $self->timestamptz;
	},
	;

with 'XML::SRS::Date', 'XML::SRS::Time';

1;
