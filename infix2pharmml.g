
start:        expression /^\Z/ {$item [1]}

statement:      variable '=' statement   {$item [1] . "=" . $item [3]}
              | expression               {$item [1]}

expression:     term '+' expression      {infix2pharmml::b("plus", $item[1], $item[3])}
              | term '-' expression      {infix2pharmml::b("minus",$item[1], $item[3])}
              | term                     

term:           power '*' term          {infix2pharmml::b("times", $item[1], $item[3])}
              | power '/' term          {infix2pharmml::b("divide",$item[1], $item[3])}
              | power

power:          factor '^' factor     {infix2pharmml::b("power", $item[1], $item[3])}
              | factor '!'               {infix2pharmml::u("factorial",$item[1])}
              | factor

factor:         number
              | '+' factor               {$item [2]}
              | '-' factor               {infix2pharmml::u("minus",$item [2])}
              | '(' expression ')'       {$item [2]}
              | uniop '(' expression ')' {infix2pharmml::u($item[1],$item[3])}
              | binop '(' expression ',' expression ')' 
                                         {infix2pharmml::b($item[1],$item[3],$item[5])}
              | variable '(' argpairlist ')' 
                                         {infix2pharmml::fc($item[1],$item[3])}
              | variable                 {infix2pharmml::symbref($item[1])}


uniop:          'sinh' | 'cosh' | 'asinh' | 'acosh' | 'asin' | 'acos' | 'atan'
              | 'acot' | 'sin'  | 'cos'   | 'tan'   | 'cot'  | 'exp'  | 'sqrt' 
              | 'factorial' | 'gammaln' | 'ln'


binop:          'atan2' | 'log' | 'min' | 'max'

number:         /([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?/
                                         {infix2pharmml::e("ct:Real",$item[1])}

argpair:        variable '=' expression { infix2pharmml::fa($item[1],$item[3]) } 
                                       

argpairlist:    argpair ',' argpairlist { $item[1].$item[3] }
              | argpair

variable:       /[a-z]+/i

