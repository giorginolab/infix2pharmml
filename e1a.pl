use strict;
use warnings;

use Parse::RecDescent;

sub e {
    my $tag=shift;
    my $c="@_";
    return "<$tag>$c</$tag>\n";
}

sub op {
    my $tag=shift;
    my $op=shift;
    my $c="@_";
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

my $grammar = q {

start:        expression /^\Z/ {$item [1]}

statement:      variable '=' statement   {$item [1] . "=" . $item [3]}
              | expression               {$item [1]}

expression:     term '+' expression      {main::b("plus",$item [1], $item [3])}
              | term '-' expression      {main::b("minus",$item [1] , $item [3])}
              | term                     

term:           factor '*' term          {main::b("times",$item [1] , $item [3])}
              | factor '/' term          {main::b("divide",$item [1] , $item [3])}
              | factor

factor:         number
              | '+' factor               {$item [2]}
              | '-' factor               {main::u("minus",$item [2])}
              | '(' expression ')'       {$item [2]}
              | uniop '(' expression ')' {main::u($item[1],$item[3])}
              | binop '(' expression ',' expression ')' 
                                         {main::b($item[1],$item[3],$item[5])}
              | variable '(' argpairlist ')' 
                                         {main::fc($item[1],$item[3])}
              | variable                 {main::symbref($item[1])}

uniop:          'sin' | 'cos' | 'tan' | 'ln'

binop:          'atan2' | 'log'

number:         /([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?/
                                         {main::e("ct:Real",$item[1])}

argpair:        variable '=' expression { main::fa($item[1],$item[3]) } 
                                       

argpairlist:    argpair ',' argpairlist { $item[1].$item[3] }
              | argpair

variable:       /[a-z]+/i


};

my $parser=Parse::RecDescent->new($grammar);

my $result = $parser->start($ARGV[0]);
defined $result or die "Parse error";
print $result;


