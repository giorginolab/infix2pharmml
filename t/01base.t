# -*- Perl -*-

use strict;
use warnings;

use lib 'cgi-perl/lib/perl5';

use Test::More tests => 6;
use Test::Differences;
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



my $s="1+sqrt(a^2+b^2)";
eq_or_diff(i2p($s),
   '<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Binop op="plus">
    <ct:Real>1</ct:Real>
    <Uniop op="sqrt">
      <Binop op="plus">
        <Binop op="power">
          <ct:SymbRef symbIdRef="a"/>
          <ct:Real>2</ct:Real>
        </Binop>
        <Binop op="power">
          <ct:SymbRef symbIdRef="b"/>
          <ct:Real>2</ct:Real>
        </Binop>
      </Binop>
    </Uniop>
  </Binop>
</math:Equation>
',$s);


$s="factorial(2)";
eq_or_diff(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Uniop op="factorial">
    <ct:Real>2</ct:Real>
  </Uniop>
</math:Equation>
',$s);

$s="2!";
eq_or_diff(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Uniop op="factorial">
    <ct:Real>2</ct:Real>
  </Uniop>
</math:Equation>
',$s);


$s="1-2-3";
eq_or_diff(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Binop op="minus">
    <Binop op="minus">
      <ct:Real>1</ct:Real>
      <ct:Real>2</ct:Real>
    </Binop>
    <ct:Real>3</ct:Real>
  </Binop>
</math:Equation>
',$s);

$s="-a*b+c";
eq_or_diff(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Binop op="plus">
    <Binop op="times">
      <Uniop op="minus">
        <ct:SymbRef symbIdRef="a"/>
      </Uniop>
      <ct:SymbRef symbIdRef="b"/>
    </Binop>
    <ct:SymbRef symbIdRef="c"/>
  </Binop>
</math:Equation>
',$s);

