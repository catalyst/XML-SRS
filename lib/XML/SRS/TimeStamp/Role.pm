
package XML::SRS::TimeStamp::Role;

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
	;

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
	;

has 'epoch' =>
	is => "rw",
	isa => "time_t",
	coerce => 1,
	lazy => 1,
	default => sub {
		my $self = shift;
		$self->timestamptz;
	};

with 'XML::SRS::Date', 'XML::SRS::Time';

1;
