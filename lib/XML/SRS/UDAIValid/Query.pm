
package XML::SRS::UDAIValid::Query;

use Moose;
use PRANG::Graph;

has_attr 'domain' =>
	is => 'ro',
	isa => 'XML::SRS::DomainName',
	xml_name => 'DomainName',
	;

has_attr 'udai' =>
	is => 'ro',
	isa => 'XML::SRS::UDAI',
	xml_name => 'UDAI',
	;

sub root_element {'UDAIValidQry'}
with 'XML::SRS::Query';
1;
