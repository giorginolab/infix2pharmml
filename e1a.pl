use strict;
use warnings;

use Parse::RecDescent;

sub e {
    my $tag=shift;
    my $c="@_";
    return "<$tag>$c</$tag>\n";
}


 $::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
 $::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
 $::RD_HINT   = 1; # Give out hints to help fix problems.


# http://www.adp-gmbh.ch/perl/rec_descent.html

my $grammar = q {

start:        expression /^\Z/ {$item [1]}

statement:      variable '=' statement   {$item [1] . "=" . $item [3]}
              | expression               {$item [1]}

expression:     term '+' expression      {main::e("plus",$item [1], $item [3])}
              | term '-' expression      {main::e("minus",$item [1] , $item [3])}
              | term                     

term:           factor '*' term          {main::e("times",$item [1] , $item [3])}
              | factor '/' term          {main::e("divide",$item [1] , $item [3])}
              | factor

factor:         number
              | '+' factor               {$item [2]}
              | '-' factor               {main::e("neg",$item [2])}
              | '(' expression ')'       {$item [2]}
              | uniop '(' expression ')' {main::e("uniop:".$item[1],$item[3])}
              | binop '(' expression ',' expression ')' 
                                         {main::e("binop:".$item[1],$item[3],$item[5])}
              | variable                 {main::e("var",$item[1])}

uniop:        'sin' | 'cos' | 'tan' | 'ln'

binop:        'atan2' | 'log'

number:         /\d+/                    {main::e("int",$item[1])}

variable:       /[a-z]+/i


};

my $parser=Parse::RecDescent->new($grammar);

my $result = $parser->start($ARGV[0]);
defined $result or die "Parse error";
print $result;


