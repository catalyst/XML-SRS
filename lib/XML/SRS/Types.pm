
package XML::SRS::Types;

use 5.010;
use strict;
use warnings;

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;

our $PKG = "XML::SRS";
subtype "${PKG}::Number"
	=> as "PRANG::XMLSchema::nonNegativeInteger";
subtype "${PKG}::RegistrarId"
	=> as "PRANG::XMLSchema::positiveInteger";
subtype "${PKG}::Term"
	=> as "PRANG::XMLSchema::positiveInteger";
subtype "${PKG}::token_OTHERS"
	=> as "Str",
	=> where { $_ eq "OTHERS" };
subtype "${PKG}::RegistrarIdOrOTHERS"
	=> as "${PKG}::RegistrarId|${PKG}::token_OTHERS";

subtype "${PKG}::Dollars"
	=> as "PRANG::XMLSchema::decimal"
	=> where {
		($_ - sprintf("%.2f",$_)) < 0.0000001;
	};
subtype "${PKG}::UID"
	=> as "Str"; # XXX - any other constraints on ActionIDs?
subtype "${PKG}::DomainName"
	=> as "Str"; # FIXME - constrain this properly.

our @Boolean = qw(0 1);
subtype "${PKG}::Boolean"
	=> as "Bool"
	=> where {
		$_ ~~ @Boolean;
	};
coerce "${PKG}::Boolean"
	=> from "Bool"
	=> via { $_ ? 1 : 0 };
coerce "${PKG}::Dollars"
	=> from "PRANG::XMLSchema::decimal"
	=> via {
		sprintf("%.2f",$_);
	};

our @AccountingAction = qw(Credit Debit);
subtype "${PKG}::token_OTHERS"
	=> as "Str",
	=> where { $_ ~~ @AccountingAction };

enum "${PKG}::DomainWriteAction" =>
	qw(DomainCreate DomainUpdate);

enum "${PKG}::DomainQueryAction" =>
	qw(Whois DomainDetailsQry ActionDetailsQry UDAIValidQry);

enum "${PKG}::HandleWriteAction" =>
	qw(HandleCreate HandleUpdate);

subtype "${PKG}::HandleQueryAction"
	=> as "Str",
	=> where {
		$_ eq qw(HandleDetailsQry);
	};

enum "${PKG}::RegistrarWriteAction" =>
	qw(RegistrarCreate  RegistrarUpdate);

enum "${PKG}::RegistrarQueryAction" =>
	qw(RegistrarDetailsQry  RegistrarAccountQry  GetMessages);

enum "${PKG}::RegistryAction" =>
	qw(SysParamsUpdate SysParamsQry RunLogCreate RunLogQry
	   ScheduleCreate ScheduleCancel ScheduleQry ScheduleUpdate
	   BillingExtract SetBillingAmount BillingAmountQry
	   DeferredIncomeSummaryQry DeferredIncomeDetailQry
	   BilledUntilAdjustment BuildDnsZoneFiles GenerateDomainReport
	   AdjustRegistrarAccount AccessControlListQry
	   AccessControlListAdd AccessControlListRemove);

subtype "${PKG}::ActionName" =>
	as join("|", map { "${PKG}::$_" }
			qw(DomainWriteAction DomainQueryAction
			   HandleWriteAction HandleQueryAction
			   RegistrarWriteAction RegistrarQueryAction
			   RegistryAction));

enum "${PKG}::ActionEtcExtra" =>
	qw(UnknownTransaction  DomainTransfer);

enum "${PKG}::RegDomainStatus" =>
	qw(Active PendingRelease);
enum "${PKG}::DomainStatus" =>
	qw(Active PendingRelease Available);

subtype "${PKG}::ActionEtc"
	=> as "${PKG}::ActionName|${PKG}::ActionEtcExtra";

enum "${PKG}::RoleName" =>
	qw( Registrar Registry Whois Query CreateDomain UpdateDomain
	    TransferDomain CancelDomain UncancelDomain UpdateRegistrar
	    Administer Supervisor Connect ReleaseDomain QueryACL
	    UpdateACL );

1;
