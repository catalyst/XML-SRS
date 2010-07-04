#!/usr/bin/perl

use strict;
use warnings;

use Test::More ('no_plan');

use_ok("XML::SRS::TimeStamp");


my $ts1 = XML::SRS::TimeStamp->new(year => 2010, month => 6, day => 2, hour => 15, minute => 12, second => 2, tz_offset => "+12:00");
my $ts2 = XML::SRS::TimeStamp->new(year => 2010, month => 6, day => 2, hour => 15, minute => 12, second => 2, tz_offset => "+1200");

ok($ts1->epoch == $ts2->epoch, "timestamps represent the same moment");

for my $ts ( $ts1, $ts2 ) {
  ok($ts,"create timstamp");

  ok($ts->timestamp =~ m/2010-06-02/, "nice timestamp date...");
  ok($ts->timestamp =~ m/15:12:02/, "nice timestamp time...");

  ok($ts->timestamptz =~ m/2010-06-02/, "nice timestamptz date...");
  ok($ts->timestamptz =~ m/15:12:02/, "nice timestamptz time...");
  ok($ts->timestamptz =~ m/1200/, "nice timestamptz tz...");
}
