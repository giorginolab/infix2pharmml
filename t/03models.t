# -*- Perl -*-

use strict;
use warnings;

use lib 'cgi-perl/lib/perl5';

use Test::More tests => 9;
use Test::Exception;
use XML::Twig;

BEGIN { use_ok('infix2pharmml') }; # TEST 1

sub i2p {
    my $in=shift;
    my $xml=infix2pharmml::xmlify($in);
    my $twig=XML::Twig->new( pretty_print => 'indented'); 
    $twig->parse($xml);
    my $xml_indented=$twig->sprint;
    return $xml_indented;
}

my $s;
$infix2pharmml::fullmodel=1;


$s="A:=1; B:=2";
ok(i2p($s),$s);

$s="A:=1; B:=2;";
ok(i2p($s),$s);

$s="par v_init=10, a=1;";   
ok(i2p($s),$s);

$s="y:=A*exp(-alpha*t)+B*exp(-beta*t)";
ok(i2p($s),$s);

$s="A:=dose*exp(-k*t) {Exponential decay model}; C:=A/V {Concentration}";
ok(i2p($s),$s);

$s="diff(A1,t)=-Cl*A1/V1+Q*(A2/V2-A1/V1); diff(A2,t)=-Q*(A2/V2-A1/V1); C1:=A1/V1";
ok(i2p($s),$s);

$s="Peripheral(k12, k21, amount=Ap1); E:=Ap1^2";
ok(i2p($s),$s);


$s="A:=2 ## B:=4;";
dies_ok { i2p($s)} "Expected error on $s";


