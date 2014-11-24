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

      m{\G(diff\(|\)\:\=|par|\)\=|\:\=|\-|\+|\;|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
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
  [ '_OPTIONAL' => 'OPTIONAL-5', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-1' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_15' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_16' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')', 'OPTIONAL-4' ], 0 ],
  [ 'structuralstmt_17' => 'structuralstmt', [ 'par', 'VAR', '=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'macroargpairlist_18' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_19' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_20' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_21' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_27' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_28' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_29' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_30' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_32' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_33' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_34' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_35' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_36' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_37' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_38' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_39' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_40' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_41' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_42' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  '_OPTIONAL' => 11,
  '_OPTIONAL' => 12,
  'structuralstmt_13' => 13,
  'structuralstmt_14' => 14,
  'structuralstmt_15' => 15,
  'structuralstmt_16' => 16,
  'structuralstmt_17' => 17,
  'macroargpairlist_18' => 18,
  'macroargpairlist_19' => 19,
  'macroargpairlist_20' => 20,
  'equation_21' => 21,
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
  'expr_34' => 34,
  'expr_35' => 35,
  'expr_36' => 36,
  'constant_37' => 37,
  'constant_38' => 38,
  'constant_39' => 39,
  'constant_40' => 40,
  'argpairlist_41' => 41,
  'argpairlist_42' => 42,
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
	'par' => { ISSEMANTIC => 0 },
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
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 1,
			'model' => 6
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			'VAR' => 7
		}
	},
	{#State 3
		ACTIONS => {
			"(" => 8
		}
	},
	{#State 4
		ACTIONS => {
			'VAR' => 9
		}
	},
	{#State 5
		ACTIONS => {
			":=" => 10
		}
	},
	{#State 6
		ACTIONS => {
			'' => 12,
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 11
		}
	},
	{#State 7
		ACTIONS => {
			"=" => 13
		}
	},
	{#State 8
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 25,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 19,
			'constant' => 18,
			'macroargpairlist' => 28
		}
	},
	{#State 9
		ACTIONS => {
			"," => 29
		}
	},
	{#State 10
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 30,
			'constant' => 18
		}
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 32,
			'constant' => 18
		}
	},
	{#State 14
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 33,
			'constant' => 18
		}
	},
	{#State 15
		DEFAULT => -37
	},
	{#State 16
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 18
		}
	},
	{#State 17
		ACTIONS => {
			"(" => 35
		}
	},
	{#State 18
		DEFAULT => -28
	},
	{#State 19
		DEFAULT => -19
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		DEFAULT => -27
	},
	{#State 22
		DEFAULT => -40
	},
	{#State 23
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 36,
			'constant' => 18
		}
	},
	{#State 24
		ACTIONS => {
			"-" => 37,
			"+" => 38,
			"/" => 39,
			"!" => 40,
			"^" => 41,
			"*" => 42
		},
		DEFAULT => -21
	},
	{#State 25
		ACTIONS => {
			"=" => 43,
			"(" => 44
		},
		DEFAULT => -36
	},
	{#State 26
		DEFAULT => -38
	},
	{#State 27
		ACTIONS => {
			"(" => 45
		}
	},
	{#State 28
		ACTIONS => {
			"," => 46,
			")" => 47
		}
	},
	{#State 29
		ACTIONS => {
			'VAR' => 48
		}
	},
	{#State 30
		ACTIONS => {
			";" => 49
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 50
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 44
		},
		DEFAULT => -36
	},
	{#State 32
		ACTIONS => {
			";" => 51
		},
		DEFAULT => -12,
		GOTOS => {
			'OPTIONAL-5' => 52
		}
	},
	{#State 33
		DEFAULT => -31
	},
	{#State 34
		ACTIONS => {
			"/" => 39,
			"!" => 40,
			"^" => 41,
			"*" => 42
		},
		DEFAULT => -30
	},
	{#State 35
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 53,
			'constant' => 18
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 37,
			"^" => 41,
			"!" => 40,
			"*" => 42,
			"+" => 38,
			"/" => 39,
			")" => 54
		}
	},
	{#State 37
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 55,
			'constant' => 18
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 56,
			'constant' => 18
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 57,
			'constant' => 18
		}
	},
	{#State 40
		DEFAULT => -29
	},
	{#State 41
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 58,
			'constant' => 18
		}
	},
	{#State 42
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 59,
			'constant' => 18
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 60,
			'constant' => 18
		}
	},
	{#State 44
		ACTIONS => {
			'VAR' => 61
		},
		GOTOS => {
			'argpairlist' => 62
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 18
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 25,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 19,
			'constant' => 18,
			'macroargpairlist' => 64
		}
	},
	{#State 47
		ACTIONS => {
			";" => 65
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 66
		}
	},
	{#State 48
		ACTIONS => {
			"):=" => 67,
			")=" => 68
		}
	},
	{#State 49
		DEFAULT => -3
	},
	{#State 50
		DEFAULT => -13
	},
	{#State 51
		DEFAULT => -11
	},
	{#State 52
		DEFAULT => -17
	},
	{#State 53
		ACTIONS => {
			"-" => 37,
			"^" => 41,
			"!" => 40,
			"*" => 42,
			"+" => 38,
			"/" => 39,
			")" => 69
		}
	},
	{#State 54
		DEFAULT => -32
	},
	{#State 55
		ACTIONS => {
			"/" => 39,
			"!" => 40,
			"^" => 41,
			"*" => 42
		},
		DEFAULT => -23
	},
	{#State 56
		ACTIONS => {
			"/" => 39,
			"!" => 40,
			"^" => 41,
			"*" => 42
		},
		DEFAULT => -22
	},
	{#State 57
		ACTIONS => {
			"!" => 40,
			"^" => 41
		},
		DEFAULT => -25
	},
	{#State 58
		ACTIONS => {
			"!" => 40,
			"^" => 41
		},
		DEFAULT => -26
	},
	{#State 59
		ACTIONS => {
			"!" => 40,
			"^" => 41
		},
		DEFAULT => -24
	},
	{#State 60
		DEFAULT => -20
	},
	{#State 61
		ACTIONS => {
			"=" => 70
		}
	},
	{#State 62
		ACTIONS => {
			"," => 71,
			")" => 72
		}
	},
	{#State 63
		ACTIONS => {
			"-" => 37,
			"^" => 41,
			"!" => 40,
			"*" => 42,
			"+" => 38,
			"," => 73,
			"/" => 39
		}
	},
	{#State 64
		DEFAULT => -18
	},
	{#State 65
		DEFAULT => -9
	},
	{#State 66
		DEFAULT => -16
	},
	{#State 67
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 74,
			'constant' => 18
		}
	},
	{#State 68
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 75,
			'constant' => 18
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 24,
			'equation' => 76,
			'constant' => 18
		}
	},
	{#State 71
		ACTIONS => {
			'VAR' => 61
		},
		GOTOS => {
			'argpairlist' => 77
		}
	},
	{#State 72
		DEFAULT => -35
	},
	{#State 73
		ACTIONS => {
			"-" => 14,
			'NAN' => 15,
			"+" => 16,
			'UNIOP' => 17,
			'EULER' => 20,
			'NUM' => 21,
			'INF' => 22,
			"(" => 23,
			'VAR' => 31,
			'BINOP' => 27,
			'PI' => 26
		},
		GOTOS => {
			'expr' => 78,
			'constant' => 18
		}
	},
	{#State 74
		ACTIONS => {
			";" => 79
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 80
		}
	},
	{#State 75
		ACTIONS => {
			";" => 81
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 82
		}
	},
	{#State 76
		DEFAULT => -42
	},
	{#State 77
		DEFAULT => -41
	},
	{#State 78
		ACTIONS => {
			"-" => 37,
			"^" => 41,
			"!" => 40,
			"*" => 42,
			"+" => 38,
			"/" => 39,
			")" => 83
		}
	},
	{#State 79
		DEFAULT => -7
	},
	{#State 80
		DEFAULT => -15
	},
	{#State 81
		DEFAULT => -5
	},
	{#State 82
		DEFAULT => -14
	},
	{#State 83
		DEFAULT => -34
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 943 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 947 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 951 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 958 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 965 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 972 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 979 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 986 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 993 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1000 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1007 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 43 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1014 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 43 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1021 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 4,
sub {
#line 36 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3])}
#line 1028 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 7,
sub {
#line 38 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 1035 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 7,
sub {
#line 40 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 1042 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 5,
sub {
#line 42 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1049 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_17
		 'structuralstmt', 5,
sub {
#line 44 "infix2pharmml_model.eyp"
infix2pharmml::par($_[2],$_[4])}
#line 1056 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_18
		 'macroargpairlist', 3,
sub {
#line 47 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1063 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_19
		 'macroargpairlist', 1,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1070 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_20
		 'macroargpairlist', 3,
sub {
#line 49 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1077 ./infix2pharmml_model.pm
	],
	[#Rule equation_21
		 'equation', 1,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1084 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1091 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 70 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1098 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 71 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1105 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 72 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1112 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1119 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 1,
sub {
#line 74 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1126 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 1,
sub {
#line 75 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1133 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 2,
sub {
#line 76 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1140 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 77 "infix2pharmml_model.eyp"
$_[2]}
#line 1147 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1154 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
$_[2]}
#line 1161 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 4,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1168 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 6,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1175 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 4,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1182 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1189 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 91 "infix2pharmml_model.eyp"
"notanumber"}
#line 1196 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
"pi"}
#line 1203 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 93 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1210 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 94 "infix2pharmml_model.eyp"
"infinity"}
#line 1217 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_41
		 'argpairlist', 3,
sub {
#line 98 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1224 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_42
		 'argpairlist', 3,
sub {
#line 99 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1231 ./infix2pharmml_model.pm
	]
],
#line 1234 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'structuralstmt_13', 
         'structuralstmt_14', 
         'structuralstmt_15', 
         'structuralstmt_16', 
         'structuralstmt_17', 
         'macroargpairlist_18', 
         'macroargpairlist_19', 
         'macroargpairlist_20', 
         'equation_21', 
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
         'expr_34', 
         'expr_35', 
         'expr_36', 
         'constant_37', 
         'constant_38', 
         'constant_39', 
         'constant_40', 
         'argpairlist_41', 
         'argpairlist_42', );
  $self;
}

#line 107 "infix2pharmml_model.eyp"



=for None

=cut


#line 1303 ./infix2pharmml_model.pm



1;
