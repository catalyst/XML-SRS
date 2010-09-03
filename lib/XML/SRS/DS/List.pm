package XML::SRS::DS::List;

use Moose;
use PRANG::Graph;
use XML::SRS::DS;

use Moose::Util::TypeConstraints;

use XML::SRS::Server;
has_element 'ds_list' =>
	is => "rw",
	isa => "ArrayRef[XML::SRS::DS]",
	xml_nodeName => "DS",
	xml_required => 0,
	;

coerce __PACKAGE__
	=> from 'ArrayRef[XML::SRS::DS]'
	=> via {
		__PACKAGE__->new(
			ds_list => $_,
		);
	};

with 'XML::SRS::Node';

1;
