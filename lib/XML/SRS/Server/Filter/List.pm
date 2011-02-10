
package XML::SRS::Server::Filter::List;

use Moose;
use PRANG::Graph;

use XML::SRS::Server::Filter;

use Moose::Util::TypeConstraints;

has_element 'server_filter' =>
	is => 'ro',
	isa => 'ArrayRef[XML::SRS::Server::Filter]',
	xml_nodeName => 'ServerFilter',
	coerce => 0,
	required => 1,
	;

coerce __PACKAGE__
	=> from 'ArrayRef'
	=> via {
    	__PACKAGE__->new(
	   	   server_filter => [map { XML::SRS::Server::Filter->new($_) } @{$_[0]}],
	   );
    };

with 'XML::SRS::Node';

1;
