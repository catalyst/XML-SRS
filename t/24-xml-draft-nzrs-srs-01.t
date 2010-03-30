#!/usr/bin/perl -w
#
# test script for validation and load/dump between Perl/Moose and XML
# for complete messages and fragments described in described in
# draft-nzrs-srs-01 (SRS protocol mapping)

use strict;
use Test::More;

# yes ... this will be a complete re-implementation of the XML
# portions of NativeData in the DNRS code base :-)

use FindBin qw($Bin $Script);
use File::Find;
use Scriptalicious;
use XML::SRS;
use YAML;

my $xml_compare = XML::Compare->new(
	ignore => [ q{//epp:msg/@lang} ],
	ignore_xmlns => {
		"epp" => "urn:ietf:params:xml:ns:epp-1.0",
	},
       );

for my $test ( sort @tests ) {
	my $xml = XMLTests::read_xml($test);

	my $object = XMLTests::parse_test( "XML::EPP", $xml, $test );
 SKIP: {
		skip "didn't parse", 2 unless $object;
		my $r_xml = XMLTests::emit_test( $object, $test );
		if ( !defined $r_xml ) {
			skip "no XML returned", 1;
		}
		XMLTests::xml_compare_test(
			$xml_compare, $xml, $r_xml, $test,
		       );
	}
}

# Copyright (C) 2009  NZ Registry Services
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the Artistic License 2.0 or later.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Artistic License 2.0 for more details.
#
# You should have received a copy of the Artistic License the file
# COPYING.txt.  If not, see
# <http://www.perlfoundation.org/artistic_license_2_0>

# Copyright (C) 2009  NZ Registry Services
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the Artistic License 2.0 or later.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Artistic License 2.0 for more details.
#
# You should have received a copy of the Artistic License the file
# COPYING.txt.  If not, see
# <http://www.perlfoundation.org/artistic_license_2_0>
