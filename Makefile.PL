#
# Copyright (C) 2009  NZ Registry Services
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the Artistic License 2.0 or later.  You should
# have received a copy of the Artistic License the file COPYING.txt.
# If not, see <http://www.perlfoundation.org/artistic_license_2_0>

use inc::Module::Install;

name            ("XML-SRS");
abstract        ("PRANG implementation of the XML SRS protocol");
author          ("Catalyst SRS Team <team-srs\@catalyst.net.nz>");
version_from    ("lib/XML/SRS.pm");
license         ('artistic');

requires        ("Moose" => 0.54);
requires        ("MooseX::Method::Signatures" => 0);
requires        ("PRANG" => "0.10_01");
requires        ("Regexp::Common" => 0);
requires        ("MooseX::Timestamp" => 0.06);
requires        ("Crypt::Password" => 0.05);
test_requires   ("XML::Compare" => 0.04);

&WriteAll;
