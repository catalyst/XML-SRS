
package XML::SRS::AckMessage;

use Moose;
use PRANG::Graph;
use XML::SRS::Types;

sub root_element { 
  "AckMessage";
}

has_attr 'transaction_id' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "TransId",
	required => 1,
	;

has_attr 'originating_registrar' =>
	is => "ro",
	isa => "Str",
	xml_name => "OriginatingRegistrarId",
	;

with 'XML::SRS::Action';
1;
