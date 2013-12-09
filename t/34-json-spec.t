#!/usr/bin/perl

# Use the XML spec files to create XML::SRS objects, then emit them as
#  JSON, and create as JSON again. Compare

use strict;
use warnings;

use Test::More qw(no_plan);

use FindBin qw($Bin);
use lib $Bin;

use XML::Compare;
use XMLTests;

$XMLTests::test_dir = $Bin . '/24-xml-draft-nzrs-srs-01';

our @tests = XMLTests::find_tests;

#plan tests => @tests * 3;

use_ok 'XML::SRS';

my $xml_compare = XML::Compare->new(
    ignore => [
        q{//Error//text()},  # FIXME - cdata types
        q{//DomainNameFilter/text()},  # FIXME - cdata types
        q{//AuditText/text()},  # FIXME - cdata types
        q{//AccessControlListQry/@FullResult},
    ],
);

for my $test ( sort @tests ) {
    my $xml = XMLTests::read_xml($test);

    my $object_orig = XMLTests::parse_test( "XML::SRS", $xml, $test );
    
    my $json = $object_orig->to_json;
            
    my $object_new = XML::SRS->from_json($json);
        
    my $r_xml = XMLTests::emit_test( $object_new, $test );
    
    XMLTests::xml_compare_test(
        $xml_compare, $xml, $r_xml, $test,
    ) or diag "JSON: $json\n";
}