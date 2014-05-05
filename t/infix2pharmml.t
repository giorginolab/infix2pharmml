# -*- Perl -*-

use strict;
use warnings;

use lib 'cgi-perl/lib/perl5';

use Test::More tests => 4;
use XML::Twig;

BEGIN { use_ok('infix2pharmml') }; # TEST 1

sub i2p {
    my $in=shift;
    my $xml=infix2pharmml::xmlify(Math::Symbolic->parse_from_string($in));
    my $twig=XML::Twig->new( pretty_print => 'indented'); 
    $twig->parse($xml);
    my $xml_indented=$twig->sprint;
    return $xml_indented;
}



my $s="1+sqrt(a^2+b^2)";
is(i2p($s),
   '<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Binop op="plus">
    <ct:Real>1</ct:Real>
    <Binop op="power">
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
      <ct:Real>0.5</ct:Real>
    </Binop>
  </Binop>
</math:Equation>
',$s);

$s="exp(ln(1))";
is(i2p($s),
   '<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Binop op="power">
    <ct:Real>2.71828182845905</ct:Real>
    <Uniop op="ln">
      <ct:Real>1</ct:Real>
    </Uniop>
  </Binop>
</math:Equation>
',$s);

$s="factorial(2)";
is(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Uniop op="factorial">
    <ct:Real>2</ct:Real>
  </Uniop>
</math:Equation>
',$s);
