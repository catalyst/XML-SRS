
package XML::SRS::Password;

use Moose;
use PRANG::Graph;
use Crypt::Password;
use Moose::Util::TypeConstraints;

class_type "Crypt::Password";

has_attr 'crypted' =>
	is => "ro",
	isa => "Crypt::Password",
	handles => [qw/check/],
	xml_name => "Password",
	required => 1,
	coerce => 1,
	;

coerce "Crypt::Password"
	=> from "Str"
	=> via {
		password($_);
	};

with 'XML::SRS::Node';

coerce __PACKAGE__
	=> from "Str"
	=> via {
		__PACKAGE__->new(crypted => password($_));
	},
	=> from "Crypt::Password"
	=> via {
		__PACKAGE__->new(crypted => $_);
	};
1;
