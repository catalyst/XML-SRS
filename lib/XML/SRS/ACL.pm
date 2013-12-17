
package XML::SRS::ACL;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use Moose::Util::TypeConstraints;

use XML::SRS::ACL::Entry;

has_attr 'Resource' =>
	is => "ro",
	isa => "Str",
	required => 1,
	;

has_attr 'List' =>
	is => "ro",
	isa => "Str",
	required => 1,
	;

has_attr 'Size' =>
	is => "ro",
	isa => "XML::SRS::Number",
	xml_required => 0,
	;

has_attr 'SizeChange' =>
	is => "ro",
	isa => "Int",
	xml_required => 0,
	;

has_attr 'Type' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	;

use XML::SRS::ACL::Entry;

has_element 'entries' =>
	is => "ro",
	isa => "ACLEntryArrayRef",
	xml_nodeName => "AccessControlListEntry",
	xml_required => 0,
	coerce => 1,
	;

sub root_element {
	"AccessControlList";
}

with 'XML::SRS::ActionResponse';

1;
