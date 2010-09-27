
package XML::SRS::GetMessages;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

sub root_element {
	"GetMessages";
}

has_attr 'originating_registrar' =>
	is => "ro",
	isa => "Str",
	xml_name => "OriginatingRegistrarId",
	;

has_attr 'recipient_registrar' =>
	is => "ro",
	isa => "Str",
	xml_name => "RecipientRegistrarId",
	;

has_attr 'queue' =>
	is => "ro",
	isa => "Bool",
	xml_name => "QueueMode",
	;

has_element "when" =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::Date::Range]",
	xml_nodeName => "TransDateRange",
	xml_required => 0,
	;

has_attr 'max_results' =>
	is => 'ro',
	isa => 'XML::SRS::Number',
	xml_name => 'MaxResults',
	xml_required => 0,
	;

use XML::SRS::GetMessages::TypeFilter;
has_element "type_filter" =>
	is => "ro",
	isa => "ArrayRef[XML::SRS::GetMessages::TypeFilter]",
	xml_min => 0,
	xml_nodeName => "TypeFilter",
	coerce => 1,
	;

use Moose::Util::TypeConstraints;
coerce 'ArrayRef[XML::SRS::GetMessages::TypeFilter]'
	=> from "ArrayRef[Str]"
	=> via {
	[   map {
			XML::SRS::GetMessages::TypeFilter->new(
				Type => $_,
			);
			} @$_
	];
	};

with 'XML::SRS::Query';
1;
