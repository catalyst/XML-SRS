
package XML::SRS::GetMessages;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

use XML::SRS::Date::Range;

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
	isa => "XML::SRS::Date::Range",
	xml_nodeName => "TransDateRange",
	xml_required => 0,
	coerce => 1,
	;

has_element "audit_text_filter" =>
    is => "ro",
    isa => "Str",
    xml_nodeName => "AuditTextFilter",
    xml_required => 0,
    ;

has_attr 'max_results' =>
	is => 'ro',
	isa => 'XML::SRS::Number',
	xml_name => 'MaxResults',
	xml_required => 0,
	;
	
has_attr 'skip_results' =>
    is => 'ro',
    isa => 'XML::SRS::Number',
    xml_name => 'SkipResults',
    xml_required => 0,
    ;

has_attr 'count_results' =>
    is => 'ro',
    isa => 'XML::SRS::Number',
    xml_name => 'CountResults',
    xml_required => 0,
    ;
    
has_attr 'action_id' =>
    is => 'ro',
    isa => 'Str',
    xml_name => 'ActionId',
    xml_required => 0,
    ;

use XML::SRS::GetMessages::TypeFilter;
use Moose::Util::TypeConstraints;

# For some reason, we have to create this subtype
#  Supposedly, it should work without it if we define the coercion
#  after the 'has_element', but that generated a warning. Possible Moose bug?
subtype 'TypeFilterArrayRef' =>
    as 'ArrayRef[XML::SRS::GetMessages::TypeFilter]';

coerce 'TypeFilterArrayRef'
	=> from "ArrayRef[Str]"
	=> via {
	[   map {
			XML::SRS::GetMessages::TypeFilter->new(
				Type => $_,
			);
			} @$_
	];
};

coerce 'TypeFilterArrayRef'
    => from "ArrayRef[HashRef]"
    => via {
    [   map {
            XML::SRS::GetMessages::TypeFilter->new(
                $_,
            );
            } @$_
    ];
};

has_element "type_filter" =>
	is => "ro",
	isa => "TypeFilterArrayRef",
	xml_min => 0,
	xml_nodeName => "TypeFilter",
	coerce => 1,
	;

with 'XML::SRS::Query';
1;
