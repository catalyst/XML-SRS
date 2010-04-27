
package XML::SRS::TimeStamp::Role;

use 5.010;
use XML::SRS::Date;
use XML::SRS::Time;
use Moose::Role;
use MooseX::Method::Signatures;

use MooseX::Timestamp;
use MooseX::TimestampTZ;

has 'timestamp' =>
	is => "rw",
	isa => "Timestamp",
	coerce => 1,
	lazy => 1,
	default => sub {
		my $self = shift;
		sprintf("%.4d-%.2d-%.2d %.2d:%.2d:%.2d",
			$self->Year, $self->Month, $self->Day,
			$self->Hour, $self->Minute, $self->Second//0,
		       );
	},
	;

method buildargs_timestamp( $inv: Timestamp $timestamp ) {
	my ($date, $time) = split " ", $timestamp;
	($inv->buildargs_time($time), $inv->buildargs_date($date));
}

method buildargs_timestamptz( $inv: TimestampTZ $timestamptz ) {
	$timestamptz =~ m{
		(?<ymd>\d+-\d+-\d+)
		\s(?<hms>\d+:\d+:\d+)
		(?: (?<utc>Z) | (?<offset> [+-]\d{2} (?::?\d{2})? )
		)}x or warn "$timestamptz didn't match";
	my $hms = $+{hms};
	my $ymd = $+{ymd};
	my $offset = $+{utc} ? "+00:00" : $+{offset};
	($inv->buildargs_time($hms, $offset),
	 $inv->buildargs_date($ymd));
}

method buildargs_epoch( $inv: time_t $epoch ) {
	$inv->buildargs_timestamptz(timestamptz $epoch);
}

has 'timestamptz' =>
	is => "rw",
	isa => "TimestampTZ",
	coerce => 1,
	lazy => 1,
	default => sub {
		my $self = shift;
		sprintf("%.4d-%.2d-%.2d %.2d:%.2d:%.2d%s",
			$self->Year, $self->Month, $self->Day,
			$self->Hour, $self->Minute, $self->Second//0,
			$self->TimeZoneOffset//"",
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
		epoch $self->timestamptz;
	},
	;

with 'XML::SRS::Date', 'XML::SRS::Time';

1;
