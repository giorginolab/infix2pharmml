  parse: expr /^\Z/
            {
              $return = $item[1]
            }
       | // {undef}

  expr: addition
            {
              #warn 'expr ' if $Math::Symbolic::Parser::DEBUG;
              $item[1]
            }

  addition: <leftop:multiplication add_op multiplication>
            {
              #warn 'addition '
              #  if $Math::Symbolic::Parser::DEBUG;
              if (@{$item[1]} == 1) {
                $item[1][0]
              }
              else {
                my @it = @{$item[1]};
                my $tree = shift @it;
                while (@it) {
                  $tree = Math::Symbolic::Operator->new(
                    shift(@it), $tree, shift(@it)
                  );
                }
                $tree;
              }
            }

  add_op: '+'
        | '-'

  multiplication: <leftop:exp mult_op exp>
            {
              #warn 'multiplication '
              #  if $Math::Symbolic::Parser::DEBUG;
              if (@{$item[1]} == 1) {
                $item[1][0]
              }
              else {
                my @it = @{$item[1]};
                my $tree = shift @it;
                while (@it) {
                  $tree = Math::Symbolic::Operator->new(
                    shift(@it), $tree, shift(@it)
                  );
                }
                $tree;
              }
            }

  mult_op: '*'
         | '/'


  exp: <rightop:factor '^' factor>
            {
              #warn 'exp ' if $Math::Symbolic::Parser::DEBUG;
              if (@{$item[1]} == 1) {
                $item[1][0]
              }
              else {
                my @it = reverse @{$item[1]};
                my $tree = shift @it;
                while (@it) {
                  $tree = Math::Symbolic::Operator->new(
                    '^', shift(@it), $tree
                  );
                }
                $tree;
              }
            }

  factor: /(?:\+|-)*/ number
            {
              #warn 'unary_n '
              #  if $Math::Symbolic::Parser::DEBUG;
              if ($item[1]) {
                my @it = split //, $item[1];
                my $ret = $item[2];
                foreach (grep {$_ eq '-'} @it) {
                  $ret = Math::Symbolic::Operator->new('neg',$ret);
                }
                $ret
              }
              else {
                $item[2]
              }
            }

         | /(?:\+|-)*/ function
            {
              #warn 'unary_f '
              #  if $Math::Symbolic::Parser::DEBUG;
              if ($item[1]) {
                my @it = split //, $item[1];
                my $ret = $item[2];
                foreach (grep {$_ eq '-'} @it) {
                  $ret = Math::Symbolic::Operator->new('neg',$ret);
                }
                $ret
              }
              else {
                $item[2]
              }
            }

         | /(?:\+|-)*/ variable
            {
              #warn 'unary_v '
              #  if $Math::Symbolic::Parser::DEBUG;
              if ($item[1]) {
                my @it = split //, $item[1];
                my $ret = $item[2];
                foreach (grep {$_ eq '-'} @it) {
                  $ret = Math::Symbolic::Operator->new('neg',$ret);
                }
                $ret
              }
              else {
                $item[2]
              }
            }

          | /(?:\+|-)*/ '(' expr ')'
            {
              #warn 'unary_expr '
              #  if $Math::Symbolic::Parser::DEBUG;
              if ($item[1]) {
                my @it = split //, $item[1];
                my $ret = $item[3];
                foreach (grep {$_ eq '-'} @it) {
                  $ret = Math::Symbolic::Operator->new('neg',$ret);
                }
                $ret
              }
              else {
                $item[3]
              }
            }

  number:        /([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?/
            {
              #warn 'number '
              #  if $Math::Symbolic::Parser::DEBUG;
              Math::Symbolic::Constant->new($item[1])
            }

  function: function_name '(' expr_list ')'
            {
              #warn 'function ' 
              #  if $Math::Symbolic::Parser::DEBUG;
              my $fname = $item[1];
              my $function;
              if (exists($Math::Symbolic::Parser::Parser_Functions{$fname})) {
                $function = $Math::Symbolic::Parser::Parser_Functions{$fname}->($fname, @{$item[3]});
                die "Invalid function '$fname'!"
                  unless defined $function;
              }
              else {
                $function = $Math::Symbolic::Operator::Op_Symbols{ $fname };
                die "Invalid function '$fname'!"
                  unless defined $function;
                $function = Math::Symbolic::Operator->new(
                  { type => $function, operands => $item[3] }
                );
              }
              $function
            }

  function_name: 'log'
               | 'partial_derivative'
               | 'total_derivative'
               | 'sinh'
               | 'cosh'
               | 'asinh'
               | 'acosh'
               | 'asin'
               | 'acos'
               | 'atan2'
               | 'atan'
               | 'acot'
               | 'sin'
               | 'cos'
               | 'tan'
               | 'cot'
               | 'exp'
               | 'sqrt'


  expr_list: <leftop:expr ',' expr>
            {
              #warn 'expr_list '
              #  if $Math::Symbolic::Parser::DEBUG;
              $item[1]
            }

  variable: /[a-zA-Z][a-zA-Z0-9_]*/ /\'*/ '(' identifier_list ')'
            {
              #warn 'variable '
              #  if $Math::Symbolic::Parser::DEBUG;
              my $varname = $item[1];
              my $ticks = $item[2];
              if ($ticks) {
                my $n = length($ticks);
                my $sig = $item[4] || ['x'];
                my $dep_var = $sig->[0];
                my $return = Math::Symbolic::Variable->new(
                  { name => $varname, signature => $sig }
                );
                foreach (1..$n) {
                  $return = Math::Symbolic::Operator->new(
                    'partial_derivative', 
                     $return, $dep_var,
                  );
                }
                $return;
              }
              else {
                Math::Symbolic::Variable->new(
                  { name => $varname, signature => $item[4] }
                );
              }
            }

          | /[a-zA-Z][a-zA-Z0-9_]*/ /\'*/
            {
              #warn 'variable '
              #  if $Math::Symbolic::Parser::DEBUG;
              my $varname = $item[1];
              my $ticks = $item[2];
              if ($ticks) {
                my $n = length($ticks);
                my $return = Math::Symbolic::Variable->new(
                  { name => $varname, signature => ['x'] }
                );
                foreach (1..$n) {
                  $return = Math::Symbolic::Operator->new(
                    'partial_derivative', 
                     $return, 'x',
                  );
                }
                $return;
              }
              else {
                Math::Symbolic::Variable->new( $varname );
              }
            }

  identifier_list: <leftop:/[a-zA-Z][a-zA-Z0-9_]*/ ',' /[a-zA-Z][a-zA-Z0-9_]*/>
            {
              #warn 'identifier_list '
              #  if $Math::Symbolic::Parser::DEBUG;
              $item[1]
            }
  
