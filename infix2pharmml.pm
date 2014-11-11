# Please note that this is a quick hack. This is not how XML should be
# generated.

package infix2pharmml;

use strict;
use Carp;
use infix2pharmml_eyapp;
use warnings;

our $fullmodel=0;

my %symbols=();
my @derivativeVariableList=();
my @variableList=();
my @functionList=();




# Top-level symbols
sub funcdef {
    my ($id,$al,$eq)=@_;

    croak "Function definitions not allowed in stand-alone mode yet" if $fullmodel;

    my $out= "<FunctionDefinition xmlns=\"http://www.pharmml.org/2013/03/CommonTypes\"  symbId=\"$id\" symbolType=\"real\">".
	$al.
	"<Definition>$eq</Definition>".
	"</FunctionDefinition>";
    push @functionList,$out;
    return $out;
}

# P. 42
sub vardef {
    my ($id,$y)=@_;
    my $out= "<ct:Variable symbId=\"$id\" symbolType=\"real\">".
	assign($y).
	"</ct:Variable>";
    push @variableList,$out;
    return $out;
}

# Can't be in StructuralModel.
sub varass {
    my ($id,$y)=@_;
    croak "Variable assignments not allowed in stand-alone mode yet" if $fullmodel;
    return "<ct:VariableAssignment>".symbref_no_store($id).
	assign($y).
	"</ct:VariableAssignment>";
}

sub diff {
    my ($id,$t,$y)=@_;
    my $out="<ct:DerivativeVariable symbId=\"$id\" symbolType=\"real\">".
	assign($y).
	"<ct:IndependentVariable>".symbref_no_store($t)."</ct:IndependentVariable>".
	"<ct:InitialCondition>".
	"<!-- WARNING InitialCondition need be edited -->".
	assign("<ct:Real>0</ct:Real>").
	"</ct:InitialCondition>".
	"</ct:DerivativeVariable>";
    push @derivativeVariableList,$out;
    return $out;
}
    




sub eqn {
    return "<math:Equation xmlns=\"http://www.pharmml.org/2013/03/Maths\">".
	shift.
	"</math:Equation>";
}

sub assign {
    my $y=shift;
    return "<ct:Assign>$y</ct:Assign>";
}

# Generic tag
sub e {
    my $tag=shift;
    my $c=join('',@_);
    return "<$tag>$c</$tag>\n";
}

# Uniop or binop (1st arg)
sub op {
    my $tag=shift;
    my $op=shift;
    my $c=join('',@_);
    return "<$tag op=\"$op\">$c</$tag>\n";
}

# Binop
sub b {
    return op("Binop",@_);
}

# Uniop
sub u {
    return op("Uniop",@_);
}

# Function call (name, args). Symbref should not be pushed in symbol table.
sub fc {
    my ($id,$args)=@_;
    return "<math:FunctionCall>".
    "<ct:SymbRef symbIdRef=\"$id\"/>".
    $args.
    "</math:FunctionCall>";
}

sub funcarg {
    my $id=shift;
    return "<FunctionArgument symbId=\"$id\" symbolType=\"real\"/>"
}

# Function arguments
sub fa {
    my ($id,$ref)=@_;
    return "<math:FunctionArgument symbId=\"$id\">".
	$ref.
      "</math:FunctionArgument>";
}

# Symbol
sub symbref {
    my $id=shift;
    # Exception: time need not be stored in parameter block
    if($id ne "t") {
	$symbols{$id}=1;
    }
    return symbref_no_store($id);
}

# Symbol, but don't store in table
sub symbref_no_store {
    my $id=shift;
    return "<ct:SymbRef blkId=\"p\" symbIdRef=\"$id\"/>";
}


# Constant
sub const {
    my $id=shift;
    return "<math:Constant op=\"$id\"/>";
}





sub getParameterModel {
    my $out="<ParameterModel blkId=\"p\">";
    foreach my $s (keys %symbols) {
	$out.="<SimpleParameter symbId=\"$s\" />";
    }
    $out.="</ParameterModel>";
}




my $parser=infix2pharmml_eyapp->new() or die "Building grammar"; 

sub xmlify {
    $parser->input(shift);
    my $err;
    my $out;

    my $tmpl;

    if($fullmodel) {
	open F,"<emptyModel.xml" or die "Opening template";
	$tmpl=join("", <F>);
    }

    {
	 local $SIG{__WARN__} = sub { $err=$_[0]; };
	 $out=$parser->Run;
    }

    if (my $ne = $parser->YYNberr > 0) {
	croak "There were $ne errors during parsing: $err\n";
    } 

    if(!$fullmodel) {
	return $out;
    } else {
	my $pm=getParameterModel();
	$tmpl =~ s/INFIX2PHARMML_PARAMETERMODEL/$pm/;

	my $dv=join "",@derivativeVariableList;
	$tmpl =~ s/INFIX2PHARMML_DERIVATIVEVARIABLE/$dv/;

	my $vl=join "",@variableList;
	$tmpl =~ s/INFIX2PHARMML_VARIABLE/$vl/;

	return $tmpl;
    }
    
}


1;
