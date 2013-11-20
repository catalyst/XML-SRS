
package XML::SRS::AuditDetails;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;
use XML::SRS::Date::Range;

use MooseX::Aliases;
use MooseX::Aliases::Meta::Trait::Attribute;

use Moose::Util::TypeConstraints;

coerce __PACKAGE__
    => from "HashRef"
    => via { __PACKAGE__->new(%$_); };

has_attr 'registrar_id' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_name => "RegistrarId",
	xml_required => 0,
	;

has_attr 'action_id' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "ActionId",
	xml_required => 0,
	;

has_element 'when' =>
	is => "ro",
	isa => "XML::SRS::Date::Range",
	xml_required => 0,
	xml_nodeName => "AuditTime",
	coerce => 1,
	;

has_element 'comment' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	xml_nodeName => "AuditText",
    traits => [qw(Aliased)],    
    alias => 'audit_text',
	;

with 'XML::SRS::Node';
1;
