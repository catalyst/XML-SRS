
package XML::SRS::Audit;

use Moose::Role;
use PRANG::Graph;

has_element 'audit' =>
	is => "rw",
	isa => "Str",
	xml_nodeName => "AuditText",
	xml_required => 0,
	;

1;
