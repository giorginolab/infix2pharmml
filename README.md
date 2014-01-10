infix2pharmml
=============

Converter between mathematical infix notation and PharmML math markup.

PharmML is a markup for pharmacometrics documented at http://pharmml.org/

Toni G at ISIB CNR

Notes
-----


This is preliminary and can be later packed in a stand-alone exe.
Until then, you need e.g. activeperl and the modules indicated at the
top of the source code. See notes therein.


Usage
-----

Open a shell, then

shell>   perl -w infix2mathml.pl

Enter the expression to convert:
sin(-2*t)
About to parse: sin(-2*t)
Parsed:         sin((-2) * t)
XML:

<Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <Uniop op="sin">
  <Binop op="times">
  <Uniop op="minus">
  <ct:Real>2</ct:Real>
  </Uniop>
  <ct:SymbRef symbIdRef="t"/>
  </Binop>
  </Uniop>
</Equation>





Syntax for custom function calls
--------------------------------

Due to a limitation in Symbolic::Math parser, calling user-defined function
(with named arguments) is achieved like this:

   call(combinedErrorModel,a=a,b=b,f=Cc)

which should yield


    <math:Equation>
      <math:FunctionCall>
	<ct:SymbRef symbIdRef="combinedErrorModel"/>
	<math:FunctionArgument symbId="a">
	  <ct:SymbRef symbIdRef="a"/>
	</math:FunctionArgument>
	<math:FunctionArgument symbId="b">
	  <ct:SymbRef symbIdRef="b"/>
	</math:FunctionArgument>
	<math:FunctionArgument symbId="f">
	  <math:Equation>
	    <ct:SymbRef blkIdRef="main" symbIdRef="Cc"/>
	  </math:Equation>
	</math:FunctionArgument>
      </math:FunctionCall>
    </math:Equation>

