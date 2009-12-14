
package XML::SRS::Password;

use Moose;
use PRANG::Graph;

has_attr 'crypted' =>
	is => "ro",
	isa => "Str",
	xml_name => "Password",
	required => 1,
	;

with 'XML::SRS::Node';

1;
