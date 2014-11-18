<img src="CNR_logo_100.png" alt="Logo CNR" style="float:right"/>

Infix notation to PharmML math online converter
===============================================

<toni.giorgino@isib.cnr.it>

This web service converts a mathematical expression in the usual infix
notation into the corresponding [PharmML](http://pharmml.org/)
markup. For details and source code see the
[infix2pharmml](http://sourceforge.net/projects/infix2pharmml/)
project page at SourceForge.

Version 0.6


What's new
----------

The new *stand-alone mode* creates (mostly) ready-to-run model (only
comprising structural equations). In this mode, multiple statements
can be provided, separated by semicolons. Statements are restricted to
variable and derivative variable definitions. Stand-alone mode is
intended to jump-start development, and it is not a full-fledged
modeling tool.


The following features are supported:

-   All operators defined by PharmML 0.3 should be supported
-   Constants (with user-friendly aliases, such as `e` for
    *exponentiale*).
-   Variable assignments, as in `a=b+c` and definitions, as `a:=b+c`
-   Derivative variable (ODE) definitions, as `diff(q,t):=1+sin(t)`.
    Initial condition has to be edited by hand.
-   Function definitions, such as `f(x,y):=x+y`.
-   Use `ln` for the natural logarithm. The `logx` function is always
    two-argument (argument, base).
-   Calls to user-defined functions use a special syntax described
    below.
-   Factorial can be expressed as `factorial()` or with the usual
    exclamation mark.
-   Preliminary macro support, as e.g. `Oral(2)` or `IV(adm=1)`. Arguments
    names are unchecked.


For a full list of the converter's features and limitations, see [the
project's
README](https://sourceforge.net/p/infix2pharmml/code/ci/master/tree/README.md).


Enter the formula below
-----------------------

<form name="input" action="/cgi-bin/infix2pharmml/infix2pharmml.cgi" method="get">
<textarea rows="4" cols="50" id="math" name="math">1+sin(t)+b</textarea>
<input type="checkbox" id="standalone" name="standalone" value="true">Build a stand-alone model<br>
<input type="submit" value="Submit">
</form> 


Examples
--------

Click to copy in the input area above.


 <table style="width:80%; margin:2em">
  <tr style="background-color: rgb(15, 42, 82); color: white;">
   <td><em>Single-statement mode</em></td>
   <td><em>Stand-alone model mode</em></td>
  </tr>
  <tr>
   <td>
     <p> <pre onclick="copyUp(event,false)">1+sqrt(a^2+b^2)</pre> 
     <p> <pre onclick="copyUp(event,false)">logx(x,e)</pre> 
     <p> <pre onclick="copyUp(event,false)">A*exp(-alpha*t)+B*exp(-beta*t)</pre> 
     <p> <pre onclick="copyUp(event,false)">output=1+pi+myfunc(t=sin(x))</pre>
     <p> <pre onclick="copyUp(event,false)">diff(q,t)=1+sin(t)</pre>
     <p> <pre onclick="copyUp(event,false)">myLength(x,y,z):=x^2+y^2+z^2</pre>
     <p> <pre onclick="copyUp(event,false)">sqrt(myLength(x=sin(t),y=4!,z=0))</pre> 
   </td>
   <td>
     <p> <pre onclick="copyUp(event,true)">y:=A*exp(-alpha*t)+B*exp(-beta*t)</pre> 
     <p> <pre onclick="copyUp(event,true)">diff(a,t)=b; <br>diff(b,t)=-a;</pre> 
     <p> <pre onclick="copyUp(event,true)">diff(A,t)=-k*A; <br>C:=A/V</pre> 
     <p> <pre onclick="copyUp(event,true)">A:=dose*exp(-k*t); <br>C:=A/V</pre> 
     <p> <pre onclick="copyUp(event,true)">diff(A1,t)=-Cl*A1/V1+Q*(A2/V2-A1/V1); <br>diff(A2,t)=-Q*(A2/V2-A1/V1); <br>C1:=A1/V1</pre> 
     <p> <pre onclick="copyUp(event,true)">diff(E,t)=Rin-Rout*E</pre> 
     <p> <pre onclick="copyUp(event,true)">diff(G,t)=-(Sg+Si*Z)*G+Sg*Gb+Ra/V;<br>diff(Z,t)=-lambda*Z+lambda*(I-Ib);</pre> 
   </td>
  </tr>
 </table>


License
-------

*infix2pharmml - Infix notation to PharmML math online converter*

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see
[http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
