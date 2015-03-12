# -*- Perl -*-

use strict;
use warnings;

use lib 'cgi-perl/lib/perl5';

use Test::More tests => 8;
use Test::Differences;
use XML::Twig;

BEGIN { use_ok('infix2pharmml') }; # TEST 1

sub i2p {
    my $in=shift;
    infix2pharmml::init;
    my $xml=infix2pharmml::xmlify($in);
    my $twig=XML::Twig->new( pretty_print => 'indented'); 
    $twig->parse($xml);
    my $xml_indented=$twig->sprint;
    return $xml_indented;
}



my $s="1+sqrt(a^2+b^2)";
eq_or_diff(i2p($s),
   '<math:Equation>
  <math:Binop op="plus">
    <ct:Real>1</ct:Real>
    <math:Uniop op="sqrt">
      <math:Binop op="plus">
        <math:Binop op="power">
          <ct:SymbRef symbIdRef="a"/>
          <ct:Real>2</ct:Real>
        </math:Binop>
        <math:Binop op="power">
          <ct:SymbRef symbIdRef="b"/>
          <ct:Real>2</ct:Real>
        </math:Binop>
      </math:Binop>
    </math:Uniop>
  </math:Binop>
</math:Equation>
',$s);


$s="factorial(2)";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:Uniop op="factorial">
    <ct:Real>2</ct:Real>
  </math:Uniop>
</math:Equation>
',$s);

$s="2!";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:Uniop op="factorial">
    <ct:Real>2</ct:Real>
  </math:Uniop>
</math:Equation>
',$s);


$s="1-2-3";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:Binop op="minus">
    <math:Binop op="minus">
      <ct:Real>1</ct:Real>
      <ct:Real>2</ct:Real>
    </math:Binop>
    <ct:Real>3</ct:Real>
  </math:Binop>
</math:Equation>
',$s);

$s="-a*b+c";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:Binop op="plus">
    <math:Binop op="times">
      <math:Uniop op="minus">
        <ct:SymbRef symbIdRef="a"/>
      </math:Uniop>
      <ct:SymbRef symbIdRef="b"/>
    </math:Binop>
    <ct:SymbRef symbIdRef="c"/>
  </math:Binop>
</math:Equation>
',$s);


$s="logx(x,e)";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:Binop op="logx">
    <ct:SymbRef symbIdRef="x"/>
    <math:Constant op="exponentiale"/>
  </math:Binop>
</math:Equation>
',$s);


$s="delay(a,b)";
eq_or_diff(i2p($s),
'<math:Equation>
  <ct:Delay>
    <ct:SymbRef symbIdRef="a"/>
    <ct:DelayVariable>
      <ct:SymbRef symbIdRef="b"/>
    </ct:DelayVariable>
  </ct:Delay>
</math:Equation>
',$s);
