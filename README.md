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

Online: see http://infix2pharmml.sourceforge.net .

Offline: use `convert.pl`. The infix expression to convert is expected either interactively, or as the first command-line argument. The `-s` switch activates the stand-alone model output.

E.g: open a shell, then

~~~~~
shell>   perl -w convert.pl

Enter the expression to convert:
sin(-2*t)
About to parse: sin(-2*t)
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
~~~~~


Supported features
------------------


The following features are supported:

-   All operators defined by PharmML 0.5 should be supported
-   Constants (with user-friendly aliases, such as `e` for *exponentiale*).
-   Variable assignments, as in `a=b+c` and definitions, as `a:=b+c`
-   Derivative variable (ODE) definitions, as `diff(q,t):=1+sin(t)`.  The initial condition is a parameter named `q_init`.
-   Function definitions, such as `f(x,y):=x+y`.
-   Use `ln` for the natural logarithm. The `logx` function is always two-argument (argument, base).
-   Calls to user-defined functions use an R-like named-argument syntax shown in the examples below.
-   Factorial can be expressed as `factorial()` or with the usual exclamation mark.
-   The `delay(X,delta)` operator (PharmML 0.3.2 and up?).
-   Description tags for variables and derivative variables, in curly brackets.


The following features are supported in *model mode only*:

-   Parameter assignments, as e.g. `par a=2, b=1+1`.



Stand-alone mode
----------------

Stand-alone mode generates full models which should be approximately ready to run. The following caveats apply:

* Only variable assignments and derivative variables are supported.
* Multiple statements can be provided, separated by semicolon.


Limitations
-----------

* In single-statement mode, all symbols are assumed to reference variables in the current block (in other words, the _blkIdRef_ attribute is never generated).
* All symbols are assumed to be of  type _real_.
* Logical operators are _not_ supported.
* Piecewise functions are _not_ supported.
* Matrix and vector operations are absent.
* Initial conditions and starting time for differential equations are missing.
* Code generation is based on string processing rather than a more appropriate abstract syntax tree, and does not rely on the official [libpharmml](https://sites.google.com/site/pharmmltemp/libpharmml) API.



Constants
---------

These constants and aliases are defined:

PharmML      | Aliases
------------ | ----------
exponentiale | e
pi	         |
infinity     | inf
notanumber   | nan, NaN



Syntax for custom function calls
--------------------------------

Calling user-defined function (with named arguments) is achieved as follows:

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


Acknowledgments
---------------

This software is based on the [eyapp](http://search.cpan.org/~casiano/Parse-Eyapp-1.182/lib/Parse/Eyapp/eyapp)
parser and several other Perl modules.

Online syntax highlighting is provided by [prism](http://prismjs.com/).

Partial funding from the DDMoRe IMI project is gratefully acknowledged.
