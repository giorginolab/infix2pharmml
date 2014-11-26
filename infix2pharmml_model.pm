########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'infix2pharmml_model.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package infix2pharmml_model;
use strict;

push @infix2pharmml_model::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }



# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(diff\(|delay|\)\:\=|par|\)\=|\:\=|\-|\;|\+|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
      /\G{(.+?)}/gc and return ('DESCRIPTION', $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 71 ./infix2pharmml_model.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@infix2pharmml_model::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'model', '$end' ], 0 ],
  [ 'model_1' => 'model', [ 'model', 'line' ], 0 ],
  [ 'model_2' => 'model', [ 'line' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [  ], 0 ],
  [ 'line_5' => 'line', [ 'structuralstmt', 'OPTIONAL-1' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'structuralstmt_12' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'structuralstmt_15' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'structuralstmt_16' => 'structuralstmt', [ 'par', 'parlist' ], 0 ],
  [ 'macroargpairlist_17' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_18' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_19' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parlist_20' => 'parlist', [ 'parlist', ',', 'parlist' ], 0 ],
  [ 'parlist_21' => 'parlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_22' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_27' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_29' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_30' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_31' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_32' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_33' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_34' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_35' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_36' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_39' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_40' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_41' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_42' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_43' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_44' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'model_1' => 1,
  'model_2' => 2,
  '_OPTIONAL' => 3,
  '_OPTIONAL' => 4,
  'line_5' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_OPTIONAL' => 8,
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  '_OPTIONAL' => 11,
  'structuralstmt_12' => 12,
  'structuralstmt_13' => 13,
  'structuralstmt_14' => 14,
  'structuralstmt_15' => 15,
  'structuralstmt_16' => 16,
  'macroargpairlist_17' => 17,
  'macroargpairlist_18' => 18,
  'macroargpairlist_19' => 19,
  'parlist_20' => 20,
  'parlist_21' => 21,
  'equation_22' => 22,
  'expr_23' => 23,
  'expr_24' => 24,
  'expr_25' => 25,
  'expr_26' => 26,
  'expr_27' => 27,
  'expr_28' => 28,
  'expr_29' => 29,
  'expr_30' => 30,
  'expr_31' => 31,
  'expr_32' => 32,
  'expr_33' => 33,
  'expr_34' => 34,
  'expr_35' => 35,
  'expr_36' => 36,
  'expr_37' => 37,
  'expr_38' => 38,
  'constant_39' => 39,
  'constant_40' => 40,
  'constant_41' => 41,
  'constant_42' => 42,
  'argpairlist_43' => 43,
  'argpairlist_44' => 44,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'!' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'):=' => { ISSEMANTIC => 0 },
	')=' => { ISSEMANTIC => 0 },
	'*' => { ISSEMANTIC => 0 },
	'+' => { ISSEMANTIC => 0 },
	',' => { ISSEMANTIC => 0 },
	'-' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	':=' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'^' => { ISSEMANTIC => 0 },
	'delay' => { ISSEMANTIC => 0 },
	'diff(' => { ISSEMANTIC => 0 },
	'par' => { ISSEMANTIC => 0 },
	BINOP => { ISSEMANTIC => 1 },
	DESCRIPTION => { ISSEMANTIC => 1 },
	EULER => { ISSEMANTIC => 1 },
	INF => { ISSEMANTIC => 1 },
	MACRO => { ISSEMANTIC => 1 },
	NAN => { ISSEMANTIC => 1 },
	NEG => { ISSEMANTIC => 1 },
	NUM => { ISSEMANTIC => 1 },
	PI => { ISSEMANTIC => 1 },
	UNIOP => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'infix2pharmml_model.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 1,
			'model' => 6,
			'line' => 7
		}
	},
	{#State 1
		ACTIONS => {
			";" => 8
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 9
		}
	},
	{#State 2
		ACTIONS => {
			'VAR' => 10
		},
		GOTOS => {
			'parlist' => 11
		}
	},
	{#State 3
		ACTIONS => {
			"(" => 12
		}
	},
	{#State 4
		ACTIONS => {
			'VAR' => 13
		}
	},
	{#State 5
		ACTIONS => {
			":=" => 14
		}
	},
	{#State 6
		ACTIONS => {
			'' => 15,
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 1,
			'line' => 16
		}
	},
	{#State 7
		DEFAULT => -2
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => -5
	},
	{#State 10
		ACTIONS => {
			"=" => 17
		}
	},
	{#State 11
		ACTIONS => {
			"," => 18
		},
		DEFAULT => -16
	},
	{#State 12
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			"delay" => 28,
			'UNIOP' => 27,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 32,
			'PI' => 34,
			'BINOP' => 33
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 22,
			'macroargpairlist' => 26
		}
	},
	{#State 13
		ACTIONS => {
			"," => 35
		}
	},
	{#State 14
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 36
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 38
		}
	},
	{#State 18
		ACTIONS => {
			'VAR' => 10
		},
		GOTOS => {
			'parlist' => 39
		}
	},
	{#State 19
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 40,
			'constant' => 29
		}
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 29
		}
	},
	{#State 22
		DEFAULT => -18
	},
	{#State 23
		DEFAULT => -28
	},
	{#State 24
		DEFAULT => -42
	},
	{#State 25
		ACTIONS => {
			"-" => 42,
			"+" => 43,
			"!" => 44,
			"^" => 45,
			"*" => 46,
			"/" => 47
		},
		DEFAULT => -22
	},
	{#State 26
		ACTIONS => {
			"," => 48,
			")" => 49
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 51
		}
	},
	{#State 29
		DEFAULT => -29
	},
	{#State 30
		DEFAULT => -41
	},
	{#State 31
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 52,
			'constant' => 29
		}
	},
	{#State 32
		ACTIONS => {
			"=" => 53,
			"(" => 54
		},
		DEFAULT => -38
	},
	{#State 33
		ACTIONS => {
			"(" => 55
		}
	},
	{#State 34
		DEFAULT => -40
	},
	{#State 35
		ACTIONS => {
			'VAR' => 56
		}
	},
	{#State 36
		ACTIONS => {
			'DESCRIPTION' => 58
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-2' => 57
		}
	},
	{#State 37
		ACTIONS => {
			"(" => 54
		},
		DEFAULT => -38
	},
	{#State 38
		DEFAULT => -21
	},
	{#State 39
		DEFAULT => -20
	},
	{#State 40
		DEFAULT => -32
	},
	{#State 41
		ACTIONS => {
			"!" => 44,
			"^" => 45,
			"*" => 46,
			"/" => 47
		},
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 59,
			'constant' => 29
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 60,
			'constant' => 29
		}
	},
	{#State 44
		DEFAULT => -30
	},
	{#State 45
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 61,
			'constant' => 29
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 29
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 29
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 32,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 22,
			'macroargpairlist' => 64
		}
	},
	{#State 49
		DEFAULT => -15
	},
	{#State 50
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 65,
			'constant' => 29
		}
	},
	{#State 51
		ACTIONS => {
			'VAR' => 66
		}
	},
	{#State 52
		ACTIONS => {
			"-" => 42,
			"^" => 45,
			"!" => 44,
			"*" => 46,
			"+" => 43,
			"/" => 47,
			")" => 67
		}
	},
	{#State 53
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 68
		}
	},
	{#State 54
		ACTIONS => {
			'VAR' => 70
		},
		GOTOS => {
			'argpairlist' => 69
		}
	},
	{#State 55
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 29
		}
	},
	{#State 56
		ACTIONS => {
			"):=" => 72,
			")=" => 73
		}
	},
	{#State 57
		DEFAULT => -12
	},
	{#State 58
		DEFAULT => -6
	},
	{#State 59
		ACTIONS => {
			"!" => 44,
			"^" => 45,
			"*" => 46,
			"/" => 47
		},
		DEFAULT => -24
	},
	{#State 60
		ACTIONS => {
			"!" => 44,
			"^" => 45,
			"*" => 46,
			"/" => 47
		},
		DEFAULT => -23
	},
	{#State 61
		ACTIONS => {
			"!" => 44,
			"^" => 45
		},
		DEFAULT => -27
	},
	{#State 62
		ACTIONS => {
			"!" => 44,
			"^" => 45
		},
		DEFAULT => -25
	},
	{#State 63
		ACTIONS => {
			"!" => 44,
			"^" => 45
		},
		DEFAULT => -26
	},
	{#State 64
		DEFAULT => -17
	},
	{#State 65
		ACTIONS => {
			"-" => 42,
			"^" => 45,
			"!" => 44,
			"*" => 46,
			"+" => 43,
			"/" => 47,
			")" => 74
		}
	},
	{#State 66
		ACTIONS => {
			"," => 75
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		DEFAULT => -19
	},
	{#State 69
		ACTIONS => {
			"," => 76,
			")" => 77
		}
	},
	{#State 70
		ACTIONS => {
			"=" => 78
		}
	},
	{#State 71
		ACTIONS => {
			"-" => 42,
			"^" => 45,
			"!" => 44,
			"*" => 46,
			"+" => 43,
			"/" => 47,
			"," => 79
		}
	},
	{#State 72
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 80
		}
	},
	{#State 73
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 81
		}
	},
	{#State 74
		DEFAULT => -34
	},
	{#State 75
		ACTIONS => {
			'VAR' => 82
		}
	},
	{#State 76
		ACTIONS => {
			'VAR' => 70
		},
		GOTOS => {
			'argpairlist' => 83
		}
	},
	{#State 77
		DEFAULT => -37
	},
	{#State 78
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 29,
			'equation' => 84
		}
	},
	{#State 79
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 27,
			"delay" => 28,
			'EULER' => 30,
			'NUM' => 23,
			"(" => 31,
			'INF' => 24,
			'VAR' => 37,
			'BINOP' => 33,
			'PI' => 34
		},
		GOTOS => {
			'expr' => 85,
			'constant' => 29
		}
	},
	{#State 80
		ACTIONS => {
			'DESCRIPTION' => 86
		},
		DEFAULT => -11,
		GOTOS => {
			'OPTIONAL-4' => 87
		}
	},
	{#State 81
		ACTIONS => {
			'DESCRIPTION' => 88
		},
		DEFAULT => -9,
		GOTOS => {
			'OPTIONAL-3' => 89
		}
	},
	{#State 82
		ACTIONS => {
			")" => 90
		}
	},
	{#State 83
		DEFAULT => -43
	},
	{#State 84
		DEFAULT => -44
	},
	{#State 85
		ACTIONS => {
			"-" => 42,
			"^" => 45,
			"!" => 44,
			"*" => 46,
			"+" => 43,
			"/" => 47,
			")" => 91
		}
	},
	{#State 86
		DEFAULT => -10
	},
	{#State 87
		DEFAULT => -14
	},
	{#State 88
		DEFAULT => -8
	},
	{#State 89
		DEFAULT => -13
	},
	{#State 90
		DEFAULT => -36
	},
	{#State 91
		DEFAULT => -35
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1010 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 1014 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 1018 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1025 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1032 ./infix2pharmml_model.pm
	],
	[#Rule line_5
		 'line', 2, undef
#line 1036 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 46 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 46 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 48 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 48 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1078 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_12
		 'structuralstmt', 4,
sub {
#line 45 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1085 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 7,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1092 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 7,
sub {
#line 49 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1099 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 4,
sub {
#line 51 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1106 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 2, undef
#line 1110 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_17
		 'macroargpairlist', 3,
sub {
#line 59 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1117 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_18
		 'macroargpairlist', 1,
sub {
#line 60 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1124 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_19
		 'macroargpairlist', 3,
sub {
#line 61 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1131 ./infix2pharmml_model.pm
	],
	[#Rule parlist_20
		 'parlist', 3,
sub {
#line 66 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1138 ./infix2pharmml_model.pm
	],
	[#Rule parlist_21
		 'parlist', 3,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1145 ./infix2pharmml_model.pm
	],
	[#Rule equation_22
		 'equation', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1152 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1159 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1166 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1173 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1180 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1187 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 1,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1194 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1201 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1208 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 94 "infix2pharmml_model.eyp"
$_[2]}
#line 1215 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 95 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1222 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 3,
sub {
#line 96 "infix2pharmml_model.eyp"
$_[2]}
#line 1229 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 97 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1236 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 6,
sub {
#line 98 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1243 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 6,
sub {
#line 99 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1250 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 100 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1257 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1264 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 109 "infix2pharmml_model.eyp"
"notanumber"}
#line 1271 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 110 "infix2pharmml_model.eyp"
"pi"}
#line 1278 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 111 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1285 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 112 "infix2pharmml_model.eyp"
"infinity"}
#line 1292 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 116 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1299 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_44
		 'argpairlist', 3,
sub {
#line 117 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1306 ./infix2pharmml_model.pm
	]
],
#line 1309 ./infix2pharmml_model.pm
    yybypass       => 0,
    yybuildingtree => 0,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         'model_1', 
         'model_2', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'line_5', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'structuralstmt_12', 
         'structuralstmt_13', 
         'structuralstmt_14', 
         'structuralstmt_15', 
         'structuralstmt_16', 
         'macroargpairlist_17', 
         'macroargpairlist_18', 
         'macroargpairlist_19', 
         'parlist_20', 
         'parlist_21', 
         'equation_22', 
         'expr_23', 
         'expr_24', 
         'expr_25', 
         'expr_26', 
         'expr_27', 
         'expr_28', 
         'expr_29', 
         'expr_30', 
         'expr_31', 
         'expr_32', 
         'expr_33', 
         'expr_34', 
         'expr_35', 
         'expr_36', 
         'expr_37', 
         'expr_38', 
         'constant_39', 
         'constant_40', 
         'constant_41', 
         'constant_42', 
         'argpairlist_43', 
         'argpairlist_44', );
  $self;
}

#line 125 "infix2pharmml_model.eyp"



=for None

=cut


#line 1380 ./infix2pharmml_model.pm



1;
