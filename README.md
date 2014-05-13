infix2pharmml
=============

Converter between mathematical infix notation and PharmML math markup.

PharmML is a markup for pharmacometrics documented at http://pharmml.org/ and developed within the DDMoRe consortium.

Author: Toni G at ISIB CNR


License
-------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




Usage
-----

The expression to convert is expected either interactively, or as the first command-line argument. The expression syntax is the one defined by Math::Symbolic. 

E.g: open a shell, then

~~~~~
shell>   perl -w convert.pl

Enter the expression to convert:
sin(-2*t)
About to parse: sin(-2*t)
XML:

~~~~~
~~~~~
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
~~~~~


Limitations
-----------

The expression syntax is defined by the Math::Symbolic parser. Some of its functions do not match those defined by PharmML. 

* Use _ln_ for the natural logarithm. The _log_ function is always two-argument (argument, base). 
* Calls to user-defined functions use a special syntax described in the next paragraph.
* Factorial can be expressed as "factorial()" or with the usual exclamation mark.
* All symbols are assumed to reference variables in the current block. In other words, the _blkIdRef_ attribute is never generated.
* Error reporting is essentially non-existent.
* The parser does not rely on the recently-released _libpharmml_ API.
* Logical operators and assignments are not supported.



Syntax for custom function calls
--------------------------------

Calling user-defined function (with named arguments) is achieved like this:

~~~~
   combinedErrorModel(a=a,b=b,f=Cc)
~~~~

which should yield

~~~~
<math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
  <math:FunctionCall>
    <!-- Translating: combinedErrorModel(a=a b=b f=Cc) -->
    <ct:SymbRef symbIdRef="combinedErrorModel"/>
    <math:FunctionArgument symbId="a">
      <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
        <ct:SymbRef symbIdRef="a"/>
      </math:Equation>
    </math:FunctionArgument>
    <math:FunctionArgument symbId="b">
      <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
        <ct:SymbRef symbIdRef="b"/>
      </math:Equation>
    </math:FunctionArgument>
    <math:FunctionArgument symbId="f">
      <math:Equation xmlns="http://www.pharmml.org/2013/03/Maths">
        <ct:SymbRef symbIdRef="Cc"/>
      </math:Equation>
    </math:FunctionArgument>
  </math:FunctionCall>
</math:Equation>
~~~~

Note that arguments are always wrapped into _Equation_ elements, even when they could be omitted.
