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

      m{\G(diff\(|\)\:\=|\)\=|\:\=|\-|\+|\;|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(IV|Compartment|Elimination|Peripheral|Oral)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);


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


#line 70 ./infix2pharmml_model.pm

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
  [ 'model_1' => 'model', [ 'model', 'structuralstmt' ], 0 ],
  [ 'model_2' => 'model', [ 'structuralstmt' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'structuralstmt_11' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-1' ], 0 ],
  [ 'structuralstmt_12' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')', 'OPTIONAL-4' ], 0 ],
  [ 'macroargpairlist_15' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_16' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_17' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_18' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_19' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_20' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_21' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_25' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_27' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_30' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_31' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_32' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_33' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_34' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_35' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_36' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_37' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_38' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_39' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'model_1' => 1,
  'model_2' => 2,
  '_OPTIONAL' => 3,
  '_OPTIONAL' => 4,
  '_OPTIONAL' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_OPTIONAL' => 8,
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  'structuralstmt_11' => 11,
  'structuralstmt_12' => 12,
  'structuralstmt_13' => 13,
  'structuralstmt_14' => 14,
  'macroargpairlist_15' => 15,
  'macroargpairlist_16' => 16,
  'macroargpairlist_17' => 17,
  'equation_18' => 18,
  'expr_19' => 19,
  'expr_20' => 20,
  'expr_21' => 21,
  'expr_22' => 22,
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
  'constant_34' => 34,
  'constant_35' => 35,
  'constant_36' => 36,
  'constant_37' => 37,
  'argpairlist_38' => 38,
  'argpairlist_39' => 39,
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
	'diff(' => { ISSEMANTIC => 0 },
	BINOP => { ISSEMANTIC => 1 },
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
			'VAR' => 4,
			"diff(" => 3,
			'MACRO' => 2
		},
		GOTOS => {
			'structuralstmt' => 1,
			'model' => 5
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			"(" => 6
		}
	},
	{#State 3
		ACTIONS => {
			'VAR' => 7
		}
	},
	{#State 4
		ACTIONS => {
			":=" => 8
		}
	},
	{#State 5
		ACTIONS => {
			'' => 10,
			'VAR' => 4,
			"diff(" => 3,
			'MACRO' => 2
		},
		GOTOS => {
			'structuralstmt' => 9
		}
	},
	{#State 6
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 22,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 16,
			'constant' => 15,
			'macroargpairlist' => 25
		}
	},
	{#State 7
		ACTIONS => {
			"," => 26
		}
	},
	{#State 8
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 27,
			'constant' => 15
		}
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 29,
			'constant' => 15
		}
	},
	{#State 12
		DEFAULT => -34
	},
	{#State 13
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 30,
			'constant' => 15
		}
	},
	{#State 14
		ACTIONS => {
			"(" => 31
		}
	},
	{#State 15
		DEFAULT => -25
	},
	{#State 16
		DEFAULT => -16
	},
	{#State 17
		DEFAULT => -36
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		DEFAULT => -37
	},
	{#State 20
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 32,
			'constant' => 15
		}
	},
	{#State 21
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 35,
			"!" => 36,
			"^" => 37,
			"*" => 38
		},
		DEFAULT => -18
	},
	{#State 22
		ACTIONS => {
			"=" => 39,
			"(" => 40
		},
		DEFAULT => -33
	},
	{#State 23
		DEFAULT => -35
	},
	{#State 24
		ACTIONS => {
			"(" => 41
		}
	},
	{#State 25
		ACTIONS => {
			"," => 42,
			")" => 43
		}
	},
	{#State 26
		ACTIONS => {
			'VAR' => 44
		}
	},
	{#State 27
		ACTIONS => {
			";" => 45
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 46
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 40
		},
		DEFAULT => -33
	},
	{#State 29
		DEFAULT => -28
	},
	{#State 30
		ACTIONS => {
			"/" => 35,
			"!" => 36,
			"^" => 37,
			"*" => 38
		},
		DEFAULT => -27
	},
	{#State 31
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 47,
			'constant' => 15
		}
	},
	{#State 32
		ACTIONS => {
			"-" => 33,
			"^" => 37,
			"!" => 36,
			"*" => 38,
			"+" => 34,
			"/" => 35,
			")" => 48
		}
	},
	{#State 33
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 49,
			'constant' => 15
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 50,
			'constant' => 15
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 51,
			'constant' => 15
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 52,
			'constant' => 15
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 53,
			'constant' => 15
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 54,
			'constant' => 15
		}
	},
	{#State 40
		ACTIONS => {
			'VAR' => 55
		},
		GOTOS => {
			'argpairlist' => 56
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 57,
			'constant' => 15
		}
	},
	{#State 42
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 22,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 16,
			'constant' => 15,
			'macroargpairlist' => 58
		}
	},
	{#State 43
		ACTIONS => {
			";" => 59
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 60
		}
	},
	{#State 44
		ACTIONS => {
			"):=" => 61,
			")=" => 62
		}
	},
	{#State 45
		DEFAULT => -3
	},
	{#State 46
		DEFAULT => -11
	},
	{#State 47
		ACTIONS => {
			"-" => 33,
			"^" => 37,
			"!" => 36,
			"*" => 38,
			"+" => 34,
			"/" => 35,
			")" => 63
		}
	},
	{#State 48
		DEFAULT => -29
	},
	{#State 49
		ACTIONS => {
			"/" => 35,
			"!" => 36,
			"^" => 37,
			"*" => 38
		},
		DEFAULT => -20
	},
	{#State 50
		ACTIONS => {
			"/" => 35,
			"!" => 36,
			"^" => 37,
			"*" => 38
		},
		DEFAULT => -19
	},
	{#State 51
		ACTIONS => {
			"!" => 36,
			"^" => 37
		},
		DEFAULT => -22
	},
	{#State 52
		ACTIONS => {
			"!" => 36,
			"^" => 37
		},
		DEFAULT => -23
	},
	{#State 53
		ACTIONS => {
			"!" => 36,
			"^" => 37
		},
		DEFAULT => -21
	},
	{#State 54
		DEFAULT => -17
	},
	{#State 55
		ACTIONS => {
			"=" => 64
		}
	},
	{#State 56
		ACTIONS => {
			"," => 65,
			")" => 66
		}
	},
	{#State 57
		ACTIONS => {
			"-" => 33,
			"^" => 37,
			"!" => 36,
			"*" => 38,
			"+" => 34,
			"," => 67,
			"/" => 35
		}
	},
	{#State 58
		DEFAULT => -15
	},
	{#State 59
		DEFAULT => -9
	},
	{#State 60
		DEFAULT => -14
	},
	{#State 61
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 68,
			'constant' => 15
		}
	},
	{#State 62
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 69,
			'constant' => 15
		}
	},
	{#State 63
		DEFAULT => -30
	},
	{#State 64
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 21,
			'equation' => 70,
			'constant' => 15
		}
	},
	{#State 65
		ACTIONS => {
			'VAR' => 55
		},
		GOTOS => {
			'argpairlist' => 71
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		ACTIONS => {
			"-" => 11,
			'NAN' => 12,
			"+" => 13,
			'UNIOP' => 14,
			'EULER' => 17,
			'NUM' => 18,
			'INF' => 19,
			"(" => 20,
			'VAR' => 28,
			'BINOP' => 24,
			'PI' => 23
		},
		GOTOS => {
			'expr' => 72,
			'constant' => 15
		}
	},
	{#State 68
		ACTIONS => {
			";" => 73
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 74
		}
	},
	{#State 69
		ACTIONS => {
			";" => 75
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 76
		}
	},
	{#State 70
		DEFAULT => -39
	},
	{#State 71
		DEFAULT => -38
	},
	{#State 72
		ACTIONS => {
			"-" => 33,
			"^" => 37,
			"!" => 36,
			"*" => 38,
			"+" => 34,
			"/" => 35,
			")" => 77
		}
	},
	{#State 73
		DEFAULT => -7
	},
	{#State 74
		DEFAULT => -13
	},
	{#State 75
		DEFAULT => -5
	},
	{#State 76
		DEFAULT => -12
	},
	{#State 77
		DEFAULT => -31
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 889 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 893 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 897 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 904 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 911 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 918 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 925 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 932 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 939 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 946 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 953 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_11
		 'structuralstmt', 4,
sub {
#line 36 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3])}
#line 960 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_12
		 'structuralstmt', 7,
sub {
#line 38 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 967 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 7,
sub {
#line 40 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 974 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 5,
sub {
#line 42 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 981 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_15
		 'macroargpairlist', 3,
sub {
#line 45 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 988 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_16
		 'macroargpairlist', 1,
sub {
#line 46 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 995 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_17
		 'macroargpairlist', 3,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1002 ./infix2pharmml_model.pm
	],
	[#Rule equation_18
		 'equation', 1,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1009 ./infix2pharmml_model.pm
	],
	[#Rule expr_19
		 'expr', 3,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1016 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 68 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1023 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1030 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 70 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1037 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 71 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1044 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 1,
sub {
#line 72 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1051 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 1,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1058 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 2,
sub {
#line 74 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1065 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 2,
sub {
#line 75 "infix2pharmml_model.eyp"
$_[2]}
#line 1072 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 76 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1079 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
$_[2]}
#line 1086 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 4,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1093 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 6,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1100 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 4,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1107 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 1,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1114 ./infix2pharmml_model.pm
	],
	[#Rule constant_34
		 'constant', 1,
sub {
#line 89 "infix2pharmml_model.eyp"
"notanumber"}
#line 1121 ./infix2pharmml_model.pm
	],
	[#Rule constant_35
		 'constant', 1,
sub {
#line 90 "infix2pharmml_model.eyp"
"pi"}
#line 1128 ./infix2pharmml_model.pm
	],
	[#Rule constant_36
		 'constant', 1,
sub {
#line 91 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1135 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
"infinity"}
#line 1142 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_38
		 'argpairlist', 3,
sub {
#line 96 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1149 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_39
		 'argpairlist', 3,
sub {
#line 97 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1156 ./infix2pharmml_model.pm
	]
],
#line 1159 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'structuralstmt_11', 
         'structuralstmt_12', 
         'structuralstmt_13', 
         'structuralstmt_14', 
         'macroargpairlist_15', 
         'macroargpairlist_16', 
         'macroargpairlist_17', 
         'equation_18', 
         'expr_19', 
         'expr_20', 
         'expr_21', 
         'expr_22', 
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
         'constant_34', 
         'constant_35', 
         'constant_36', 
         'constant_37', 
         'argpairlist_38', 
         'argpairlist_39', );
  $self;
}

#line 105 "infix2pharmml_model.eyp"



=for None

=cut


#line 1225 ./infix2pharmml_model.pm



1;
