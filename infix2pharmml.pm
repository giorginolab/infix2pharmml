package infix2pharmml;

use strict;
use warnings;
use Carp;
use infix2pharmml_eyapp;

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

# Function arguments
sub fa {
    my ($id,$ref)=@_;
    return "<math:FunctionArgument symbId=\"$id\">".
      "<math:Equation xmlns=\"http://www.pharmml.org/2013/03/Maths\">$ref</math:Equation>".
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
    




my $parser=infix2pharmml_eyapp->new() or die "Building grammar"; 

sub xmlify {
    $parser->input(shift);
    my $out=$parser->Run();

    if (my $ne = $parser->YYNberr > 0) {
	print "There were $ne errors during parsing\n";
	return undef;
    } else {
	return $out;
    }
    
}

1;
