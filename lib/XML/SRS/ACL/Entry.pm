
package XML::SRS::ACL::Entry;

use Moose;
use PRANG::Graph;

has_attr 'Address' =>
	is => "ro",
	isa => "Str",   # actually an IPv4/IPv6 address/network
	;

has_attr 'DomainName' =>
	is => "ro",
	isa => "Str",   # actually an valid domain name
	;

has_attr 'RegistrarId' =>
	is => "ro",
	isa => "XML::SRS::RegistrarId",
	;

has_attr 'Comment' =>
	is => "ro",
	isa => "Str",
	;

has_element 'EffectiveDate' =>
	is => "ro",
	isa => "XML::SRS::TimeStamp",
	;

with 'XML::SRS::Node';

1;
