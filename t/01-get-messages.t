#!/usr/bin/perl -w

use Test::More no_plan;
use strict;
use warnings;
use XML::Compare;
BEGIN { use_ok("XML::SRS") }

my $get = XML::SRS::GetMessages->new(
      queue => 1,
      max_results => 1,
      type_filter => [
        XML::SRS::GetMessages::TypeFilter->new(Type => "third-party"),
        XML::SRS::GetMessages::TypeFilter->new(Type => "server-generated-data"),
      ],
);

isa_ok($get, "XML::SRS::GetMessages",
       "new GetMessages message");

my $xml_request = $get->to_xml;

my $xmlc = XML::Compare->new();

ok($xmlc->is_same( $xml_request, <<'XML' ), "GetMessages")
<GetMessages QueueMode="1" MaxResults="1">
  <TypeFilter Type="third-party"/>
  <TypeFilter Type="server-generated-data"/>
</GetMessages>
XML
	or diag("Error: ".$xmlc->error);

