use inc::Module::Install;

name            ("SRS-EPP-Proxy");
abstract        ("EPP <=> SRS XML proxy server");
author          ("Catalyst SRS Team <team-srs\@catalyst.net.nz>");
version         0;
license         ('artistic');

requires        ("perl" => 5.008005);
requires        ("Moose" => 0.54);

&WriteAll;
