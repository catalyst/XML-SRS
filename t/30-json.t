#!/usr/bin/perl

# Test convesion to/from json with some JSON data files
#  We create objects from JSON, then create JSON from those
#  objects, and compare the result.

use strict;
use warnings;

use Test::More qw(no_plan);

use Test::Deep;

use JSON::Syck;
use File::Slurp qw(read_dir read_file);
use FindBin qw($Bin);
use Data::Dumper;

my $data_dir = $Bin . "/30-json/";

use_ok 'XML::SRS';

my @files = read_dir( $data_dir ) ;

foreach my $file (@files) {
    my $json = read_file($data_dir . $file);
    my $json_obj_orig = JSON::Syck::Load($json);
    
    my $obj = XML::SRS->from_json($json);
    
    my $json_new = $obj->to_json;
    
    my $json_obj_new = JSON::Syck::Load($json_new);

    cmp_deeply($json_obj_new, $json_obj_orig, "$file: JSON objects match after conversion") or
        print "orig: " . Dumper($json_obj_orig) . "\nnew: " . Dumper($json_obj_new);
        
    # Do it again to ensure the conversion works in both directions
    my $obj2 = XML::SRS->from_json($json_new);

    my $json_new2 = $obj2->to_json;
    
    my $json_obj_new2 = JSON::Syck::Load($json_new2);

    cmp_deeply($json_obj_new2, $json_obj_new, "$file: JSON objects match after second conversion") or
        print "orig: " . Dumper($json_obj_new) . "\nnew: " . Dumper($json_obj_new2);
}