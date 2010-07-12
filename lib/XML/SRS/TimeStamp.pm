
package XML::SRS::TimeStamp;

use Moose;
use PRANG::Graph;

with 'XML::SRS::TimeStamp::Role', 'XML::SRS::Node';

use Moose::Util::TypeConstraints;
use MooseX::Timestamp qw();
use MooseX::TimestampTZ qw();
use XML::SRS::Types;

coerce __PACKAGE__
	=> from Timestamp
	=> via {
		__PACKAGE__->new(timestamp => $_);
	};

coerce __PACKAGE__
	=> from TimestampTZ
	=> via {
		__PACKAGE__->new(timestamptz => $_);
	};

coerce __PACKAGE__
	=> from "Str"
	=> via {
		__PACKAGE__->new(timestamptz => $_);
	};

coerce __PACKAGE__
	=> from "Int"
	=> via {
		__PACKAGE__->new(epoch => $_);
	};

sub BUILDARGS {
	my $class = shift;
	my %args = @_;
	%args = (%args, $class->buildargs_timestamp($args{timestamp}))
		if $args{timestamp};
	%args = (%args, $class->buildargs_timestamptz($args{timestamptz}))
		if $args{timestamptz};
	%args = (%args, $class->buildargs_epoch($args{epoch}))
		if $args{epoch};
	\%args;
}

1;
