
package XML::SRS::Contact::PSTN;

use Moose;
use PRANG::Graph;

has_attr 'cc' =>
	is => "ro",
	isa => "Str",
	xml_name => "CountryCode",
	xml_required => 0,
	;

has_attr 'ndc' =>
	is => "ro",
	isa => "Str",
	xml_name => "AreaCode",
	xml_required => 0,
	;

has_attr 'subscriber' =>
	is => "ro",
	isa => "Str",
	xml_name => "LocalNumber",
	xml_required => 0,
	;

with 'XML::SRS::Node';

use Moose::Util::TypeConstraints;
coerce __PACKAGE__
	=> from "HashRef"
	=> via { __PACKAGE__->new( %$_ ); };

# a coerce from Str will only handle strings in the format
# defined in the EPP specification ()
coerce __PACKAGE__
	=> from "Str"
	=> via { $_ =~ m/^\+(\d{1,3})\.(\d+)$/; __PACKAGE__->new(cc=>$1,ndc=>'',subscriber=>$2); };

coerce __PACKAGE__
	=> from "Undef"
	=> via { __PACKAGE__->new() };

1;
