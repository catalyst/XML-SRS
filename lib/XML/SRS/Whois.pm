
package XML::SRS::Whois;

use Moose;
use PRANG::Graph;

has_attr 'query_id' =>
	is => "ro",
	isa => "XML::SRS::UID",
	xml_name => "QryId",
	predicate => "has_query_id",
	;

has_attr 'full' =>
	is => "ro",
	isa => "XML::SRS::Boolean",
	xml_name => "FullResult",
	predicate => "has_full",
	lazy => 1,
	default => sub {1},
	;

has_attr 'source_ip' =>
	is => "ro",
	isa => "Str",
	predicate => "has_source_ip",
	xml_name => "SourceIP",
	;

has_attr 'domain' =>
	is => "ro",
	isa => "XML::SRS::DomainName",
	xml_name => "DomainName",
	;

sub root_element {"Whois"}
with 'XML::SRS::Query';
1;
