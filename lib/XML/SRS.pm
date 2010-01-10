
package XML::SRS;

use Moose::Role;
use XML::SRS::Types;
use XML::SRS::Node;

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
use XML::SRS::Domain::Query;
use XML::SRS::UDAIValid::Query;

# ActionResponse types:
use XML::SRS::Error;
use XML::SRS::ACL;
use XML::SRS::Domain;
use XML::SRS::Domain::Create;
use XML::SRS::Domain::Update;
use XML::SRS::Registrar;
use XML::SRS::UDAIValid;

1;
