#    <autoaction: { "@item" } >

<autoaction: { $item[1] } >

#    <autotree>
       
# <autoaction:      {     $#item==0 ? $item[0] : join(":",@item[1..$#item])  } >


  parse: expr /^\Z/ 

  expr: addition
        { "<+ $item[1]>" }

  addition: <leftop:multiplication add_op multiplication> 

  add_op: '+'
        | '-'

  multiplication: <leftop:exp mult_op exp>

  mult_op: '*'
         | '/'


  exp: <rightop:factor '^' factor>

  factor: /(?:\+|-)*/ number
         | /(?:\+|-)*/ function
         | /(?:\+|-)*/ variable
         | /(?:\+|-)*/ '(' expr ')'

  number:        /([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?/ 
        { "<Real>$item[1]</Real>" }

  function: function_name '(' expr_list ')'

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

  variable: /[a-zA-Z][a-zA-Z0-9_]*/ /\'*/ '(' identifier_list ')'
          | /[a-zA-Z][a-zA-Z0-9_]*/ /\'*/

  identifier_list: <leftop:/[a-zA-Z][a-zA-Z0-9_]*/ ',' /[a-zA-Z][a-zA-Z0-9_]*/>
  
