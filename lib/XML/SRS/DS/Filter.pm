package XML::SRS::DS::Filter;

use Moose;

extends 'XML::SRS::DS';

has '+key_tag' =>
    required => 0,
    ;

has '+algorithm' =>
    required => 0,
    ;

has '+digest_type' =>
    required => 0,
    ;

has '+digest' =>
    required => 0,
    ;

1;