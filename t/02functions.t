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
    infix2pharmml::init;
    my $xml=infix2pharmml::xmlify($in);
    my $twig=XML::Twig->new( pretty_print => 'indented'); 
    $twig->parse($xml);
    my $xml_indented=$twig->sprint;
    return $xml_indented;
}

my $s;


$s="f(a):=a+1";
eq_or_diff(i2p($s),
'<ct:FunctionDefinition symbId="f" symbolType="real">
  <ct:Description>Function: f</ct:Description>
  <ct:FunctionArgument symbId="a" symbolType="real"/>
  <ct:Definition>
    <math:Equation>
      <math:Binop op="plus">
        <ct:SymbRef symbIdRef="a"/>
        <ct:Real>1</ct:Real>
      </math:Binop>
    </math:Equation>
  </ct:Definition>
</ct:FunctionDefinition>
',$s);


$s="myFunction(x=sin(t),y=4!)";
eq_or_diff(i2p($s),
'<math:Equation>
  <math:FunctionCall>
    <ct:SymbRef symbIdRef="myFunction"/>
    <math:FunctionArgument symbId="x">
      <math:Equation>
        <math:Uniop op="sin">
          <ct:SymbRef symbIdRef="t"/>
        </math:Uniop>
      </math:Equation>
    </math:FunctionArgument>
    <math:FunctionArgument symbId="y">
      <math:Equation>
        <math:Uniop op="factorial">
          <ct:Real>4</ct:Real>
        </math:Uniop>
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
    <math:Equation>
      <math:Binop op="plus">
        <math:Binop op="plus">
          <ct:Real>1</ct:Real>
          <math:Constant op="pi"/>
        </math:Binop>
        <math:FunctionCall>
          <ct:SymbRef symbIdRef="myfunc"/>
          <math:FunctionArgument symbId="t">
            <math:Equation>
              <math:Uniop op="sin">
                <ct:SymbRef symbIdRef="x"/>
              </math:Uniop>
            </math:Equation>
          </math:FunctionArgument>
        </math:FunctionCall>
      </math:Binop>
    </math:Equation>
  </ct:Assign>
</ct:VariableAssignment>
',$s);


$s="diff(q,t)=1+sin(t)";
eq_or_diff(i2p($s),
q(<!-- q' (ODE) --><ct:DerivativeVariable symbId="q" symbolType="real">
  <ct:Assign>
    <math:Equation>
      <math:Binop op="plus">
        <ct:Real>1</ct:Real>
        <math:Uniop op="sin">
          <ct:SymbRef symbIdRef="t"/>
        </math:Uniop>
      </math:Binop>
    </math:Equation>
  </ct:Assign>
  <ct:IndependentVariable>
    <ct:SymbRef symbIdRef="t"/>
  </ct:IndependentVariable>
  <ct:InitialCondition>
    <ct:InitialValue>
      <ct:Assign>
        <ct:SymbRef symbIdRef="q_init"/>
      </ct:Assign>
    </ct:InitialValue>
  </ct:InitialCondition>
</ct:DerivativeVariable>
),$s);


$s="myFunction(x,y,z):=x^2+y^2";
eq_or_diff(i2p($s),
'<ct:FunctionDefinition symbId="myFunction" symbolType="real">
  <ct:Description>Function: myFunction</ct:Description>
  <ct:FunctionArgument symbId="x" symbolType="real"/>
  <ct:FunctionArgument symbId="y" symbolType="real"/>
  <ct:FunctionArgument symbId="z" symbolType="real"/>
  <ct:Definition>
    <math:Equation>
      <math:Binop op="plus">
        <math:Binop op="power">
          <ct:SymbRef symbIdRef="x"/>
          <ct:Real>2</ct:Real>
        </math:Binop>
        <math:Binop op="power">
          <ct:SymbRef symbIdRef="y"/>
          <ct:Real>2</ct:Real>
        </math:Binop>
      </math:Binop>
    </math:Equation>
  </ct:Definition>
</ct:FunctionDefinition>
',$s);
