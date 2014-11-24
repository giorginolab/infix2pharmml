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
  [ 'structuralstmt_17' => 'structuralstmt', [ 'par', 'parlist', 'OPTIONAL-5' ], 0 ],
  [ 'macroargpairlist_18' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_19' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_20' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parlist_21' => 'parlist', [ 'parlist', ',', 'parlist' ], 0 ],
  [ 'parlist_22' => 'parlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_23' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_27' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_30' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_31' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_32' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_33' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_34' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_35' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_36' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
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
  'parlist_21' => 21,
  'parlist_22' => 22,
  'equation_23' => 23,
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
			'' => 13,
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 12
		}
	},
	{#State 7
		ACTIONS => {
			"=" => 14
		}
	},
	{#State 8
		ACTIONS => {
			";" => 15,
			"," => 16
		},
		DEFAULT => -12,
		GOTOS => {
			'OPTIONAL-5' => 17
		}
	},
	{#State 9
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 29,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 23,
			'constant' => 22,
			'macroargpairlist' => 32
		}
	},
	{#State 10
		ACTIONS => {
			"," => 33
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 34,
			'constant' => 22
		}
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 36,
			'constant' => 22
		}
	},
	{#State 15
		DEFAULT => -11
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
		DEFAULT => -17
	},
	{#State 18
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 38,
			'constant' => 22
		}
	},
	{#State 19
		DEFAULT => -39
	},
	{#State 20
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 39,
			'constant' => 22
		}
	},
	{#State 21
		ACTIONS => {
			"(" => 40
		}
	},
	{#State 22
		DEFAULT => -30
	},
	{#State 23
		DEFAULT => -19
	},
	{#State 24
		DEFAULT => -41
	},
	{#State 25
		DEFAULT => -29
	},
	{#State 26
		DEFAULT => -42
	},
	{#State 27
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 22
		}
	},
	{#State 28
		ACTIONS => {
			"-" => 42,
			"+" => 43,
			"/" => 44,
			"!" => 45,
			"^" => 46,
			"*" => 47
		},
		DEFAULT => -23
	},
	{#State 29
		ACTIONS => {
			"=" => 48,
			"(" => 49
		},
		DEFAULT => -38
	},
	{#State 30
		DEFAULT => -40
	},
	{#State 31
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 32
		ACTIONS => {
			"," => 51,
			")" => 52
		}
	},
	{#State 33
		ACTIONS => {
			'VAR' => 53
		}
	},
	{#State 34
		ACTIONS => {
			";" => 54
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 55
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 49
		},
		DEFAULT => -38
	},
	{#State 36
		DEFAULT => -22
	},
	{#State 37
		DEFAULT => -21
	},
	{#State 38
		DEFAULT => -33
	},
	{#State 39
		ACTIONS => {
			"/" => 44,
			"!" => 45,
			"^" => 46,
			"*" => 47
		},
		DEFAULT => -32
	},
	{#State 40
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 56,
			'constant' => 22
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
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 58,
			'constant' => 22
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 59,
			'constant' => 22
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 60,
			'constant' => 22
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 61,
			'constant' => 22
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 22
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 63,
			'constant' => 22
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
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 22
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 29,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 23,
			'constant' => 22,
			'macroargpairlist' => 67
		}
	},
	{#State 52
		ACTIONS => {
			";" => 68
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 69
		}
	},
	{#State 53
		ACTIONS => {
			"):=" => 70,
			")=" => 71
		}
	},
	{#State 54
		DEFAULT => -3
	},
	{#State 55
		DEFAULT => -13
	},
	{#State 56
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 72
		}
	},
	{#State 57
		DEFAULT => -34
	},
	{#State 58
		ACTIONS => {
			"/" => 44,
			"!" => 45,
			"^" => 46,
			"*" => 47
		},
		DEFAULT => -25
	},
	{#State 59
		ACTIONS => {
			"/" => 44,
			"!" => 45,
			"^" => 46,
			"*" => 47
		},
		DEFAULT => -24
	},
	{#State 60
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -27
	},
	{#State 61
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -28
	},
	{#State 62
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -26
	},
	{#State 63
		DEFAULT => -20
	},
	{#State 64
		ACTIONS => {
			"=" => 73
		}
	},
	{#State 65
		ACTIONS => {
			"," => 74,
			")" => 75
		}
	},
	{#State 66
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"," => 76,
			"/" => 44
		}
	},
	{#State 67
		DEFAULT => -18
	},
	{#State 68
		DEFAULT => -9
	},
	{#State 69
		DEFAULT => -16
	},
	{#State 70
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 77,
			'constant' => 22
		}
	},
	{#State 71
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 78,
			'constant' => 22
		}
	},
	{#State 72
		DEFAULT => -35
	},
	{#State 73
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 28,
			'equation' => 79,
			'constant' => 22
		}
	},
	{#State 74
		ACTIONS => {
			'VAR' => 64
		},
		GOTOS => {
			'argpairlist' => 80
		}
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 21,
			'EULER' => 24,
			'NUM' => 25,
			'INF' => 26,
			"(" => 27,
			'VAR' => 35,
			'BINOP' => 31,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 81,
			'constant' => 22
		}
	},
	{#State 77
		ACTIONS => {
			";" => 82
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 83
		}
	},
	{#State 78
		ACTIONS => {
			";" => 84
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 85
		}
	},
	{#State 79
		DEFAULT => -44
	},
	{#State 80
		DEFAULT => -43
	},
	{#State 81
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 86
		}
	},
	{#State 82
		DEFAULT => -7
	},
	{#State 83
		DEFAULT => -15
	},
	{#State 84
		DEFAULT => -5
	},
	{#State 85
		DEFAULT => -14
	},
	{#State 86
		DEFAULT => -36
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 965 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 969 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 973 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 980 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 36 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 987 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 994 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1001 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1008 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1015 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1022 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 41 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1029 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 43 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1036 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 43 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 4,
sub {
#line 36 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3])}
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 7,
sub {
#line 38 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 7,
sub {
#line 40 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 5,
sub {
#line 42 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_17
		 'structuralstmt', 3, undef
#line 1075 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_18
		 'macroargpairlist', 3,
sub {
#line 46 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1082 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_19
		 'macroargpairlist', 1,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1089 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_20
		 'macroargpairlist', 3,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1096 ./infix2pharmml_model.pm
	],
	[#Rule parlist_21
		 'parlist', 3,
sub {
#line 51 "infix2pharmml_model.eyp"
 $_[1] . $_[3] }
#line 1103 ./infix2pharmml_model.pm
	],
	[#Rule parlist_22
		 'parlist', 3,
sub {
#line 52 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1110 ./infix2pharmml_model.pm
	],
	[#Rule equation_23
		 'equation', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1117 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 70 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1124 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 71 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1131 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 72 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1138 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1145 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 74 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1152 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 75 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1159 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 1,
sub {
#line 76 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1166 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1173 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 78 "infix2pharmml_model.eyp"
$_[2]}
#line 1180 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 2,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1187 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
$_[2]}
#line 1194 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 4,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1201 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 6,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1208 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1215 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 1,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1222 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
"notanumber"}
#line 1229 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 93 "infix2pharmml_model.eyp"
"pi"}
#line 1236 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 94 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1243 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 95 "infix2pharmml_model.eyp"
"infinity"}
#line 1250 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 99 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1257 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_44
		 'argpairlist', 3,
sub {
#line 100 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1264 ./infix2pharmml_model.pm
	]
],
#line 1267 ./infix2pharmml_model.pm
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
         'parlist_21', 
         'parlist_22', 
         'equation_23', 
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

#line 108 "infix2pharmml_model.eyp"



=for None

=cut


#line 1338 ./infix2pharmml_model.pm



1;
