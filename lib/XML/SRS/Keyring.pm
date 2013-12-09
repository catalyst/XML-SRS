
package XML::SRS::Keyring;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

subtype 'XML::SRS::PGP::PubKey'
	=> as "Str"
	=> where {
	m{\A-----BEGIN PGP PUBLIC KEY} &&
		m{-----END PGP PUBLIC KEY.*\Z};
	};

has_element 'keys' =>
	is => "rw",
	isa => "ArrayRef[Str]",
	xml_nodeName => "EncryptKey",
	;

coerce __PACKAGE__
    => from 'HashRef'
    => via { __PACKAGE__->new(%$_); };

with 'XML::SRS::Node';

1;
