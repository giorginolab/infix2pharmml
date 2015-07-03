<img src="CNR_logo_100.png" alt="Logo CNR" style="float:right"/>

Infix notation to PharmML math online converter
===============================================

<toni.giorgino@cnr.it>

This web service converts a mathematical expression in the usual infix
notation into the corresponding [PharmML](http://pharmml.org/)
markup. PharmML is a markup for pharmacometrics models developed
within the [DDMoRe consortium](http://www.ddmore.eu/).

Converter version 0.6.x. The output should be compliant with PharmML 0.6.


Quickstart
----------

This is an online version of the converter.  For details,a full list
of the converter's features and limitations, and source code see the
[project's README](https://sourceforge.net/p/infix2pharmml/code/ci/master/tree/README.md).
and the
[infix2pharmml](http://sourceforge.net/projects/infix2pharmml/)
project page at SourceForge.

The converter works in either **single-statement** or **stand-alone
model** modes.

* In **single-statement** mode it converts a variety of statement
   types into the equivalent PharmML constructs, one at a time. The
   user is responsible of combining them, and supplying boilerplate
   code in order to get a fully-functional (e.g., XML-valid) model.

* In **stand-alone mode** it creates a mostly ready-to-run model
   (encompassing only structural equations). In this mode, several
   statements can be provided separated by semicolons. Statement types
   are restricted to variable and derivative variable
   definitions. Stand-alone mode is intended to jump-start
   development, and it is not a full-fledged modeling tool.



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
  <p> <pre onclick="copyUp(event,true)">A:=dose*exp(-k*t) {Exponential decay model}; <br>C:=A/V {Concentration}</pre> 
  <p> <pre onclick="copyUp(event,true)">diff(A1,t)=-Cl*A1/V1+Q*(A2/V2-A1/V1); <br>diff(A2,t)=-Q*(A2/V2-A1/V1); <br>C1:=A1/V1</pre> 
  <p> <pre onclick="copyUp(event,true)">diff(E,t)=Rin-Rout*E</pre> 
  <p> <pre onclick="copyUp(event,true)">diff(G,t)=-(Sg+Si*Z)*G+Sg*Gb+Ra/V;<br>diff(Z,t)=-lambda*Z+lambda*(I-Ib);</pre> 
  <p> <pre onclick="copyUp(event,true)">par v_init=10, a=1; diff(v,t):=a+b;</pre> 
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


Privacy policy
--------------

Server use and the data submitted are logged. Do not submit any
confidential information. To use the server privately, download the
code and use it locally.

Acknowledgments
---------------

Partial funding from the DDMoRe IMI project is gratefully
acknowledged.
