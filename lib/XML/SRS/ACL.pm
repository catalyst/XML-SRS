
package XML::SRS::ACL;

use Moose;
use PRANG::Graph;

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
	isa => "XML::EPP::Number",
	;

has_attr 'SizeChange' =>
	is => "ro",
	isa => "XML::EPP::Number",
	;

sub BUILD {
	my $self = shift;
	defined($self->Size//$self->SizeChange)
		or die "Must specify either Size or SizeChange";
}

has_attr 'Type' =>
	is => "ro",
	isa => "Str",
	;

has_element 'entries' =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::ACL::Entry]",
	xml_nodeName => "AccessControlListEntry",
	;

sub root_element {
	"AccessControlList";
}

with 'XML::SRS::ActionResponse';

1;
