# -*- Perl -*-

use strict;
use warnings;

use lib 'cgi-perl/lib/perl5';

use Test::More tests => 19;
use Test::Exception;
use Test::Differences;
use XML::Twig;

BEGIN { use_ok('infix2pharmml') }; # TEST 1

require "t/i2p.pl";


my $s;
$infix2pharmml::fullmodel=1;
$infix2pharmml::noinput=1;


$s="A:=1; B:=2";
ok(i2p($s),$s);

$s="A:=1; B:=2;";
ok(i2p($s),$s);

my $n="A:=1\nB:=2;";
eq_or_diff(i2p($n),i2p($s),$n);

$s="par v_init=10, a=1;";   
ok(i2p($s),$s);

$s="par part=1;";   
ok(i2p($s),$s);

$s="y:=A*exp(-alpha*t)+B*exp(-beta*t)";
ok(i2p($s),$s);

$s="A:=dose*exp(-k*t) {Exponential decay model}; C:=A/V {Concentration}";
ok(i2p($s),$s);

$s="diff(A1,t)=-Cl*A1/V1+Q*(A2/V2-A1/V1); diff(A2,t)=-Q*(A2/V2-A1/V1); C1:=A1/V1";
ok(i2p($s),$s);

$s="Peripheral(k12, k21, amount=Ap1); E:=Ap1^2";
ok(i2p($s),$s);

$s="A:=2 ?? B:=4;";
dies_ok { i2p($s)} "Expected error on $s";


# Various ways to comment

$s="# comment only";
ok(i2p($s),$s);


$s="A:=2";
ok(i2p($s),$s);

my $ref=i2p($s);

$s="A:=2 # nothing";
eq_or_diff(i2p($s),$ref,$s);

$s="A:=2; # semicolon";
eq_or_diff(i2p($s),$ref,$s);

$s="A:=2;\n # semicolon, newline";
eq_or_diff(i2p($s),$ref,$s);

$s="A:=2\n # newline";
eq_or_diff(i2p($s),$ref,$s);

$s="# pre-newline\nA:=2";
eq_or_diff(i2p($s),$ref,$s);

$s="# pre\nA:=2\n# post";
eq_or_diff(i2p($s),$ref,$s);






