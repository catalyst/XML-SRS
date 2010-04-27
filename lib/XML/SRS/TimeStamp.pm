
package XML::SRS::TimeStamp;

use Moose;
use PRANG::Graph;

with 'XML::SRS::TimeStamp::Role', 'XML::SRS::Node';

use Moose::Util::TypeConstraints;
use MooseX::TimestampTZ;

coerce __PACKAGE__
	=> from "Timestamp"
	=> via {
		__PACKAGE__->new(timestamp => $_);
	};

coerce __PACKAGE__
	=> from "TimestampTZ"
	=> via {
		__PACKAGE__->new(timestamptz => $_);
	};

coerce __PACKAGE__
	=> from "time_t"
	=> via {
		__PACKAGE__->new(epoch => $_);
	};

1;
