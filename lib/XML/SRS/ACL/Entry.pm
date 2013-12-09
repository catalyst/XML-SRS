
package XML::SRS::ACL::Entry;

use Moose;
use PRANG::Graph;
use XML::SRS::TimeStamp;
use Moose::Util::TypeConstraints;

has_attr 'Address' =>
	is => "ro",
	isa => "Str",   # actually an IPv4/IPv6 address/network
	xml_required => 0,
	;

has_attr 'DomainName' =>
	is => "ro",
	isa => "Str",   # actually an valid domain name
	xml_required => 0,
	;

has_attr 'RegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	xml_required => 0,
	;

has_attr 'Comment' =>
	is => "ro",
	isa => "Str",
	xml_required => 0,
	;

has_element 'effective' =>
	is => "ro",
	isa => "XML::SRS::TimeStamp",
	xml_nodeName => "EffectiveDate",
	predicate => "has_effective",	
    xml_required => 0,
    coerce => 1,
	;

subtype 'ACLEntryArrayRef' =>
    as 'ArrayRef[XML::SRS::ACL::Entry]';

coerce 'ACLEntryArrayRef'
    => from 'ArrayRef[HashRef]'
    => via {
    [
        map {
            XML::SRS::ACL::Entry->new($_);
        } @$_
    ],
};

with 'XML::SRS::Node';

1;
