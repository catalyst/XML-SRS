#!/usr/bin/perl -w

use Test::More no_plan;
use strict;
use warnings;
use XML::Compare;
BEGIN { use_ok("XML::SRS") }

my $create = XML::SRS::Domain::Create->new(
	action_id => "thinkbig.co.nz-".1273643528,
	domain_name => "thinkbig.co.nz",
	term => 12,
	delegate => 1,
	contact_registrant => {
		name => "Robert Muldoon",
		email => 'get.drunk.and.call.a.snap.election@gmail.com',
		address => {
			address1 => "57 Mount Pleasant St",
			address2 => "Burbia",
			city => "Ohai",
			region => "Southland",
			cc => "NZ",
		},
		phone => {
			cc => "64",
			ndc => "4",
			subscriber => "499 2267",
		},
	},
	nameservers => [qw( ns1.registrar.net.nz ns2.registrar.net.nz )],
       );

isa_ok($create, "XML::SRS::Domain::Create",
       "new DomainCreate message");

my $xml_request = $create->to_xml;

my $xmlc = XML::Compare->new();

ok($xmlc->is_same( $xml_request, <<'XML' ), "CreateDomain")
<DomainCreate Delegate="1" DomainName="thinkbig.co.nz" Term="12" ActionId="thinkbig.co.nz-1273643528">
  <RegistrantContact Name="Robert Muldoon" Email="get.drunk.and.call.a.snap.election@gmail.com">
    <PostalAddress Address2="Burbia" Address1="57 Mount Pleasant St" Province="Southland" City="Ohai" CountryCode="NZ" />
    <Phone LocalNumber="499 2267" AreaCode="4" CountryCode="64" />
  </RegistrantContact>
  <NameServers>
    <Server FQDN="ns1.registrar.net.nz" />
    <Server FQDN="ns2.registrar.net.nz" />
  </NameServers>
</DomainCreate>
XML
	or diag("Error: ".$xmlc->error);
