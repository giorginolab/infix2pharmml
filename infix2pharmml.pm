package infix2pharmml;

use strict;
use Carp;
use infix2pharmml_eyapp;
use warnings;

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

# Function call (name, args)
sub fc {
    my ($id,$args)=@_;
    return "<math:FunctionCall>".
    "<ct:SymbRef symbIdRef=\"$id\"/>".
    $args.
    "</math:FunctionCall>";
}

sub eqn {
    return "<math:Equation xmlns=\"http://www.pharmml.org/2013/03/Maths\">".
	shift.
	"</math:Equation>";
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
    return "<ct:SymbRef symbIdRef=\"$id\"/>";
}

# Constant
sub const {
    my $id=shift;
    return "<math:Constant op=\"$id\"/>";
}

# P. 42
sub vardef {
    my ($id,$y)=@_;
    return "<ct:Variable symbId=\"$id\" symbolType=\"real\">".
	"<ct:Assign>$y</ct:Assign></ct:Variable>";
}

sub varass {
    my ($id,$y)=@_;
    return "<ct:VariableAssignment><ct:SymbRef symbIdRef=\"$id\"/>".
	"<ct:Assign>$y</ct:Assign></ct:VariableAssignment>";
}
    


my $parser=infix2pharmml_eyapp->new() or die "Building grammar"; 

sub xmlify {
    $parser->input(shift);
    my $err;
    my $out;

    {
	 local $SIG{__WARN__} = sub { $err=$_[0]; };
	 $out=$parser->Run;
    }

    if (my $ne = $parser->YYNberr > 0) {
	croak "There were $ne errors during parsing: $err\n";
    } else {
	return $out;
    }
    
}

1;
