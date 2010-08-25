
package XML::SRS::Server::List;

use Moose;
use PRANG::Graph;
use XML::SRS::Zone;

use Moose::Util::TypeConstraints;

use XML::SRS::Server;
has_element 'nameservers' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::Server]",
	xml_nodeName => "Server",
	required => 1,
	;

coerce __PACKAGE__
	=> from 'ArrayRef[Str]'
	=> via {
	__PACKAGE__->new(
		nameservers => [
			map {
				XML::SRS::Server->new( fqdn => $_ );
				} @$_
		],
	);
	};

coerce __PACKAGE__
	=> from 'ArrayRef[HashRef]'
	=> via {
	__PACKAGE__->new(
		nameservers => [
			map {
				XML::SRS::Server->new($_);
				} @$_
		],
	);
	};

with 'XML::SRS::Node';

1;
