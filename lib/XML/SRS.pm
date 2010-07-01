
package XML::SRS;

our $VERSION = "0.04_01";

BEGIN { our $PROTOCOL_VERSION = "5.0" };
use XML::SRS::Version;

use Moose::Role;
use XML::SRS::Types;
use XML::SRS::Node;

use PRANG::Graph;
BEGIN { with 'PRANG::Graph', 'XML::SRS::Node'; };

# packet types
use XML::SRS::Request;
use XML::SRS::Response;

# data types
use XML::SRS::Time;
use XML::SRS::Date;
use XML::SRS::TimeStamp;
use XML::SRS::Contact;
use XML::SRS::Contact::Filter;
use XML::SRS::Contact::Address::Filter;
use XML::SRS::Audit;

# ---
# plug-ins:

# Query types:
use XML::SRS::Whois;
use XML::SRS::ACL::Query;
use XML::SRS::Registrar::Query;
use XML::SRS::Registrar::Update;
use XML::SRS::Domain::Create;
use XML::SRS::Domain::Update;
use XML::SRS::Domain::Query;
use XML::SRS::UDAIValid::Query;
use XML::SRS::Handle::Create;
use XML::SRS::Handle::Update;
use XML::SRS::Handle::Query;
use XML::SRS::Message;
use XML::SRS::GetMessages;
use XML::SRS::AckMessage;

# ActionResponse types:
use XML::SRS::Error;
use XML::SRS::ACL;
use XML::SRS::Domain;
use XML::SRS::Handle;
use XML::SRS::Registrar;
use XML::SRS::UDAIValid;

1;

__END__

=head1 NAME

XML::SRS - Shared Registry System XML Protocol

=head1 SYNOPSIS

 my $create = XML::SRS::Domain::Create->new(
          action_id => "thinkbig.co.nz-create-".time(),
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

  my $xml_request = $create->to_xml;

=head1 DESCRIPTION

This module is an implementation of the XML protocol used by the .nz
registry.  This protocol was developed in 2002, using what were
considered stable XML standard methods at the time, such as SGML DTD.
This compares to the now de-facto standard, EPP (RFC3730, friends and
updates), which was developed using XML Schema and XML Namespaces.  As
such, the SRS protocol as a stable standard far pre-dates EPP, which
took a further 2 years to reach 1.0 status.

=head2 WARNING: SITE^WMODULE UNDER CONSTRUCTION

The classes which are present, while enough to be able to parse the
protocol specification, are not fixed in API terms until they are
documented and tested.  Please consider any attribute which is not yet
at least documented to be under review and subject to rename.  This is
thought to lead to a clearer implementation than fixing attribute
names to the somewhat random (though well-known) names used in the
XML.  Use of C<sub BUILDARGS { }> to allow either may be considered;
patches welcome.

Similarly with undocumented portions of the implementation.  If you
would like to make sure that the code you write against it doesn't
need rewriting, please send a patch/pull request!

This module currently implements the XML part of the protocol only;
converting this into the HTTPS POST, with PGP signature, is still
TO-DO.

=head1 GLOBALS

There is currently a C<$XML::SRS::PROTOCOL_VERSION> variable which
includes the version of the SRS protocol parsed by the module.
Currently, the ability to parse more than one version at a time is not
supported, so in the event of registry protocol version changes, you
will need to upgrade the version of L<XML::SRS> in lock-step for any
new functionality.  This global is not exported.

=head1 SOURCE, SUBMISSIONS, SUPPORT

Source code is available from Catalyst:

  git://git.catalyst.net.nz/XML-SRS.git

And Github:

  git://github.com/catalyst/XML-SRS.git

Please see the file F<SubmittingPatches> for information on preferred
submission formats.

Suggested avenues for support:

=over

=item *

The DNRS forum on SourceForge -
L<http://sourceforge.net/projects/dnrs/forums>

=item *

Contact the author and ask either politely or commercially for help.

=item *

Log a ticket on L<http://rt.cpan.org/>

=back

=head1 SEE ALSO

For the 0.01 release, there is little documentation of how to use the
classes, and the implemented portion of the protocol has a particular
focus towards a particular use case, which initially will not include
core registry functions such as adminstering domains.  That being
said, as you can see in the example, it is already possible to create
DomainCreate messages.

Implementation, tests and documentation will be expanded as the module
is put to use.  This module is provided as a preview release.

=head1 AUTHOR AND LICENCE

Development commissioned by NZ Registry Services, and carried out by
Catalyst IT - L<http://www.catalyst.net.nz/>

Copyright 2009, 2010, NZ Registry Services.  This module is licensed
under the Artistic License v2.0, which permits relicensing under other
Free Software licenses.

=cut
