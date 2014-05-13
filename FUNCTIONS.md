Functions are defined as follows

~~~~~
<FunctionDefinition xmlns="http://www.pharmml.org/2013/03/CommonTypes"
		    symbId="combinedErrorModel" symbolType="real">
  <FunctionArgument symbId="a" symbolType="real"/>
  <FunctionArgument symbId="b" symbolType="real"/>
  <FunctionArgument symbId="f" symbolType="real"/>
  <Definition>
    <Equation xmlns="http://www.pharmml.org/2013/03/Maths">
      <Binop op="plus">
	<ct:SymbRef symbIdRef="a"/>
	<Binop op="times">
	  <ct:SymbRef symbIdRef="b"/>
	  <ct:SymbRef symbIdRef="f"/>
	</Binop>
      </Binop>
    </Equation>
  </Definition>
</FunctionDefinition>
~~~~~

And used as follows

~~~~~
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
~~~~~

