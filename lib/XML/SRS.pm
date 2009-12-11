
package XML::SRS;

use Moose::Role;
use XML::SRS::Types;
use XML::SRS::Node;

BEGIN { with 'PRANG::Graph', 'XML::SRS::Node'; };

# packet types
use XML::SRS::Request;
use XML::SRS::Response;

use XML::SRS::Time;
use XML::SRS::Date;
use XML::SRS::TimeStamp;

# ---
# plug-ins:

# Query types:
use XML::SRS::Whois;
use XML::SRS::ACL::Query;

# ActionResponse types:
use XML::SRS::Error;
use XML::SRS::ACL;
use XML::SRS::Domain;

1;
