
package XML::SRS::Password;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;


has_attr 'crypted' =>
	is => "ro",
	isa => "Str",
	xml_name => "Password",
	required => 1,
	;

with 'XML::SRS::Node';

coerce __PACKAGE__
	=> from "Str"
	=> via {
	__PACKAGE__->new(crypted => $_);
	};
1;
