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

my $s;


$s="f(a):=a+1";
eq_or_diff(i2p($s),
'<FunctionDefinition symbId="f" symbolType="real" xmlns="http://www.pharmml.org/2013/03/CommonTypes">
  <FunctionArgument symbId="a" symbolType="real"/>
  <Definition>
    <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
      <Binop op="plus">
        <ct:SymbRef symbIdRef="a"/>
        <ct:Real>1</ct:Real>
      </Binop>
    </math:Equation>
  </Definition>
</FunctionDefinition>
',$s);


$s="myFunction(x=sin(t),y=4!)";
eq_or_diff(i2p($s),
'<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <math:FunctionCall>
    <ct:SymbRef symbIdRef="myFunction"/>
    <math:FunctionArgument symbId="x">
      <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
        <Uniop op="sin">
          <ct:SymbRef symbIdRef="t"/>
        </Uniop>
      </math:Equation>
    </math:FunctionArgument>
    <math:FunctionArgument symbId="y">
      <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
        <Uniop op="factorial">
          <ct:Real>4</ct:Real>
        </Uniop>
      </math:Equation>
    </math:FunctionArgument>
  </math:FunctionCall>
</math:Equation>
',$s);

$s="output=1+pi+myfunc(t=sin(x))";
eq_or_diff(i2p($s),
'<ct:VariableAssignment>
  <ct:SymbRef symbIdRef="output"/>
  <ct:Assign>
    <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
      <Binop op="plus">
        <Binop op="plus">
          <ct:Real>1</ct:Real>
          <math:Constant op="pi"/>
        </Binop>
        <math:FunctionCall>
          <ct:SymbRef symbIdRef="myfunc"/>
          <math:FunctionArgument symbId="t">
            <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
              <Uniop op="sin">
                <ct:SymbRef symbIdRef="x"/>
              </Uniop>
            </math:Equation>
          </math:FunctionArgument>
        </math:FunctionCall>
      </Binop>
    </math:Equation>
  </ct:Assign>
</ct:VariableAssignment>
',$s);


$s="diff(q,t)=1+sin(t)";
eq_or_diff(i2p($s),
'<ct:DerivativeVariable symbId="q" symbolType="real">
  <ct:Assign>
    <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
      <Binop op="plus">
        <ct:Real>1</ct:Real>
        <Uniop op="sin">
          <ct:SymbRef symbIdRef="t"/>
        </Uniop>
      </Binop>
    </math:Equation>
  </ct:Assign>
  <ct:IndependentVariable>
    <ct:SymbRef symbIdRef="t"/>
  </ct:IndependentVariable>
  <ct:InitialCondition>
    <!-- WARNING InitialCondition need be edited -->
    <ct:Assign>
      <ct:Real>0</ct:Real>
    </ct:Assign>
  </ct:InitialCondition>
</ct:DerivativeVariable>
',$s);


$s="myFunction(x,y,z):=x^2+y^2";
eq_or_diff(i2p($s),
'<FunctionDefinition symbId="myFunction" symbolType="real" xmlns="http://www.pharmml.org/2013/03/CommonTypes">
  <FunctionArgument symbId="x" symbolType="real"/>
  <FunctionArgument symbId="y" symbolType="real"/>
  <FunctionArgument symbId="z" symbolType="real"/>
  <Definition>
    <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
      <Binop op="plus">
        <Binop op="power">
          <ct:SymbRef symbIdRef="x"/>
          <ct:Real>2</ct:Real>
        </Binop>
        <Binop op="power">
          <ct:SymbRef symbIdRef="y"/>
          <ct:Real>2</ct:Real>
        </Binop>
      </Binop>
    </math:Equation>
  </Definition>
</FunctionDefinition>
',$s);
