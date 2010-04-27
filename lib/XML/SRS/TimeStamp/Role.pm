
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
	isa => "MooseX::Timestamp",
	coerce => 1,
	lazy => 1,
	default => sub {
		my $self = shift;
		sprintf("%.4d-%.2d-%.2d %.2d:%.2d:%.2d",
			$self->Year, $self->Month, $self->Day,
			$self->Hour, $self->Minute, $self->Second//0,
		       );
	},
	trigger => sub {
		my $self = shift;
		my ($date, $time) = split " ", $self->timestamp;
		$self->setup_date($date);
		$self->setup_time($time);
	};

has 'timestamptz' =>
	is => "rw",
	isa => "MooseX::TimestampTZ",
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
	trigger => sub {
		my $self = shift;
		$self->timestamptz =~ m{
			(?<ymd>\d+-\d+-\d+)
			\s(?<hms>\d+:\d+:\d+)
			(?: (?<utc>Z) | (?<offset> [+-]\d{2} (?::?\d{2})? )
			)}x;
		my $offset = $+{utc} ? "+00:00" : $+{offset};
		$self->setup_date($+{ymd});
		$self->setup_time($+{hms}, $offset);
	};
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
	trigger => sub {
		my $self = shift;
		$self->timestamptz(
			MooseX::TimestampTZ::timestamptz($self->epoch),
		       );
	}
	;

with 'XML::SRS::Date', 'XML::SRS::Time';

1;
