
package XML::SRS::DS::Filter::List;

use Moose;
use PRANG::Graph;

use XML::SRS::DS::Filter;

use Moose::Util::TypeConstraints;

has_element 'ds_filter' =>
	is => 'ro',
	isa => 'ArrayRef[XML::SRS::DS::Filter]',
	xml_nodeName => 'DSFilter',
	coerce => 0,
	required => 1,
	;

coerce __PACKAGE__
	=> from 'ArrayRef'
	=> via {
    	__PACKAGE__->new(
	   	   ds_filter => [map { XML::SRS::DS::Filter->new($_) } @{$_[0]}],
	   );
    };

with 'XML::SRS::Node';

1;
