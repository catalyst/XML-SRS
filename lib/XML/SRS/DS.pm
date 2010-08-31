package XML::SRS::DS;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

has_attr 'key_tag' =>
	is => "ro",
	isa => "Int",
	xml_name => "KeyTag",
	;

has_attr 'algorithm' =>
	is => "ro",
	isa => "Int",
	xml_name => "Algorithm",
	;

has_attr 'digest_type' =>
	is => "ro",
	isa => "Int",
	xml_name => "DigestType",
	;
	
has_element 'digest' =>
	is => "rw",
	isa => "Str",
	xml_nodeName => "Digest",
	;	

with 'XML::SRS::Node';

1;
