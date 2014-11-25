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
      /\G%%([^\n;]*)/gc and return ('COMMENT', $1);


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
  [ '_OPTIONAL' => 'OPTIONAL-1', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [  ], 0 ],
  [ 'model_3' => 'model', [ 'model', 'OPTIONAL-1', 'structuralstmt' ], 0 ],
  [ 'model_4' => 'model', [ 'structuralstmt' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'COMMENT' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'COMMENT' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'COMMENT' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'structuralstmt_11' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_12' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'structuralstmt_15' => 'structuralstmt', [ 'par', 'parlist' ], 0 ],
  [ 'structuralstmt_16' => 'structuralstmt', [  ], 0 ],
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
  [ 'expr_36' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_38' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_39' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_40' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_41' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_42' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_43' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_OPTIONAL' => 1,
  '_OPTIONAL' => 2,
  'model_3' => 3,
  'model_4' => 4,
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
  'constant_38' => 38,
  'constant_39' => 39,
  'constant_40' => 40,
  'constant_41' => 41,
  'argpairlist_42' => 42,
  'argpairlist_43' => 43,
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
	COMMENT => { ISSEMANTIC => 1 },
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
		DEFAULT => -16,
		GOTOS => {
			'structuralstmt' => 1,
			'model' => 6
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'VAR' => 7
		},
		GOTOS => {
			'parlist' => 8
		}
	},
	{#State 3
		ACTIONS => {
			"(" => 9
		}
	},
	{#State 4
		ACTIONS => {
			'VAR' => 10
		}
	},
	{#State 5
		ACTIONS => {
			":=" => 11
		}
	},
	{#State 6
		ACTIONS => {
			'' => 12,
			";" => 13
		},
		DEFAULT => -2,
		GOTOS => {
			'OPTIONAL-1' => 14
		}
	},
	{#State 7
		ACTIONS => {
			"=" => 15
		}
	},
	{#State 8
		ACTIONS => {
			"," => 16
		},
		DEFAULT => -15
	},
	{#State 9
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 28,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 22,
			'constant' => 21,
			'macroargpairlist' => 31
		}
	},
	{#State 10
		ACTIONS => {
			"," => 32
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 33,
			'constant' => 21
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		DEFAULT => -16,
		GOTOS => {
			'structuralstmt' => 35
		}
	},
	{#State 15
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 36,
			'constant' => 21
		}
	},
	{#State 16
		ACTIONS => {
			'VAR' => 7
		},
		GOTOS => {
			'parlist' => 37
		}
	},
	{#State 17
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 38,
			'constant' => 21
		}
	},
	{#State 18
		DEFAULT => -38
	},
	{#State 19
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 39,
			'constant' => 21
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 40
		}
	},
	{#State 21
		DEFAULT => -29
	},
	{#State 22
		DEFAULT => -18
	},
	{#State 23
		DEFAULT => -40
	},
	{#State 24
		DEFAULT => -28
	},
	{#State 25
		DEFAULT => -41
	},
	{#State 26
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 21
		}
	},
	{#State 27
		ACTIONS => {
			"-" => 42,
			"+" => 43,
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -22
	},
	{#State 28
		ACTIONS => {
			"=" => 48,
			"(" => 49
		},
		DEFAULT => -37
	},
	{#State 29
		DEFAULT => -39
	},
	{#State 30
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 31
		ACTIONS => {
			"," => 51,
			")" => 52
		}
	},
	{#State 32
		ACTIONS => {
			'VAR' => 53
		}
	},
	{#State 33
		ACTIONS => {
			'COMMENT' => 54
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 55
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 49
		},
		DEFAULT => -37
	},
	{#State 35
		DEFAULT => -3
	},
	{#State 36
		DEFAULT => -21
	},
	{#State 37
		DEFAULT => -20
	},
	{#State 38
		DEFAULT => -32
	},
	{#State 39
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -31
	},
	{#State 40
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 56,
			'constant' => 21
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 57
		}
	},
	{#State 42
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 58,
			'constant' => 21
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 59,
			'constant' => 21
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 60,
			'constant' => 21
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 61,
			'constant' => 21
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 21
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 63,
			'constant' => 21
		}
	},
	{#State 49
		ACTIONS => {
			'VAR' => 64
		},
		GOTOS => {
			'argpairlist' => 65
		}
	},
	{#State 50
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 21
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 28,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 22,
			'constant' => 21,
			'macroargpairlist' => 67
		}
	},
	{#State 52
		DEFAULT => -14
	},
	{#State 53
		ACTIONS => {
			"):=" => 68,
			")=" => 69
		}
	},
	{#State 54
		DEFAULT => -5
	},
	{#State 55
		DEFAULT => -11
	},
	{#State 56
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 70
		}
	},
	{#State 57
		DEFAULT => -33
	},
	{#State 58
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -24
	},
	{#State 59
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -23
	},
	{#State 60
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -26
	},
	{#State 61
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -27
	},
	{#State 62
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -25
	},
	{#State 63
		DEFAULT => -19
	},
	{#State 64
		ACTIONS => {
			"=" => 71
		}
	},
	{#State 65
		ACTIONS => {
			"," => 72,
			")" => 73
		}
	},
	{#State 66
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"," => 74,
			"/" => 44
		}
	},
	{#State 67
		DEFAULT => -17
	},
	{#State 68
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 75,
			'constant' => 21
		}
	},
	{#State 69
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 76,
			'constant' => 21
		}
	},
	{#State 70
		DEFAULT => -34
	},
	{#State 71
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 77,
			'constant' => 21
		}
	},
	{#State 72
		ACTIONS => {
			'VAR' => 64
		},
		GOTOS => {
			'argpairlist' => 78
		}
	},
	{#State 73
		DEFAULT => -36
	},
	{#State 74
		ACTIONS => {
			"-" => 17,
			'NAN' => 18,
			"+" => 19,
			'UNIOP' => 20,
			'EULER' => 23,
			'NUM' => 24,
			'INF' => 25,
			"(" => 26,
			'VAR' => 34,
			'BINOP' => 30,
			'PI' => 29
		},
		GOTOS => {
			'expr' => 79,
			'constant' => 21
		}
	},
	{#State 75
		ACTIONS => {
			'COMMENT' => 80
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 81
		}
	},
	{#State 76
		ACTIONS => {
			'COMMENT' => 82
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 83
		}
	},
	{#State 77
		DEFAULT => -43
	},
	{#State 78
		DEFAULT => -42
	},
	{#State 79
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 84
		}
	},
	{#State 80
		DEFAULT => -9
	},
	{#State 81
		DEFAULT => -13
	},
	{#State 82
		DEFAULT => -7
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		DEFAULT => -35
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 957 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 964 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 971 ./infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 3, undef
#line 975 ./infix2pharmml_model.pm
	],
	[#Rule model_4
		 'model', 1, undef
#line 979 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 986 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 993 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1000 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1007 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1014 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1021 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_11
		 'structuralstmt', 4,
sub {
#line 41 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1028 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_12
		 'structuralstmt', 7,
sub {
#line 43 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1035 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 7,
sub {
#line 45 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1042 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 4,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1049 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 2, undef
#line 1053 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 0, undef
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_17
		 'macroargpairlist', 3,
sub {
#line 55 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_18
		 'macroargpairlist', 1,
sub {
#line 56 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_19
		 'macroargpairlist', 3,
sub {
#line 57 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1078 ./infix2pharmml_model.pm
	],
	[#Rule parlist_20
		 'parlist', 3,
sub {
#line 62 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1085 ./infix2pharmml_model.pm
	],
	[#Rule parlist_21
		 'parlist', 3,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1092 ./infix2pharmml_model.pm
	],
	[#Rule equation_22
		 'equation', 1,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1099 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1106 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1113 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1120 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 85 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1127 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1134 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 1,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1141 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1148 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1155 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 90 "infix2pharmml_model.eyp"
$_[2]}
#line 1162 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1169 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 3,
sub {
#line 92 "infix2pharmml_model.eyp"
$_[2]}
#line 1176 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1183 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 6,
sub {
#line 94 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1190 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 4,
sub {
#line 95 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1197 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 1,
sub {
#line 96 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1204 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 104 "infix2pharmml_model.eyp"
"notanumber"}
#line 1211 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 105 "infix2pharmml_model.eyp"
"pi"}
#line 1218 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 106 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1225 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 107 "infix2pharmml_model.eyp"
"infinity"}
#line 1232 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_42
		 'argpairlist', 3,
sub {
#line 111 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1239 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 112 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1246 ./infix2pharmml_model.pm
	]
],
#line 1249 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'model_3', 
         'model_4', 
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
         'constant_38', 
         'constant_39', 
         'constant_40', 
         'constant_41', 
         'argpairlist_42', 
         'argpairlist_43', );
  $self;
}

#line 120 "infix2pharmml_model.eyp"



=for None

=cut


#line 1319 ./infix2pharmml_model.pm



1;
