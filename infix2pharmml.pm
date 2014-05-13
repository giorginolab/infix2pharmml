package infix2pharmml;

use strict;
use warnings;
use Parse::RecDescent;
use Carp;

sub e {
    my $tag=shift;
    my $c="@_";
    return "<$tag>$c</$tag>\n";
}

sub op {
    my $tag=shift;
    my $op=shift;
    my $c=join('',@_);
    return "<$tag op=\"$op\">$c</$tag>\n";
}

sub b {
    return op("Binop",@_);
}

sub u {
    return op("Uniop",@_);
}

sub fc {
    my ($id,$args)=@_;
    return "  <math:FunctionCall>
    <ct:SymbRef symbIdRef=\"$id\"/>
    $args
    </math:FunctionCall>";
}

sub fa {
    my ($id,$ref)=@_;
    return "<math:FunctionArgument symbId=\"$id\">
      <math:Equation xmlns=\"http://www.pharmml.org/2013/03/Maths\">$ref</math:Equation>
     </math:FunctionArgument>";
}

sub symbref {
    my $id=shift;
    return "<ct:SymbRef symbIdRef=\"$id\"/>";
}



$::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
$::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
$::RD_HINT   = 1; # Give out hints to help fix problems.


# http://www.adp-gmbh.ch/perl/rec_descent.html
open FILE, "infix2pharmml.g" or die "Couldn't open file: $!"; 
my $grammar = join("", <FILE>); 
close FILE;


my $parser=Parse::RecDescent->new($grammar);

sub xmlify {
    return $parser->start(shift);
}

1;
