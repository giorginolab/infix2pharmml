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

      m{\G(diff\(|\)\:\=|par|\)\=|\:\=|\-|\;|\+|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
      /\G{(.+?)}/gc and return ('TXT', $1);


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
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'description' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'description' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'description' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'structuralstmt_11' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_12' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'structuralstmt_15' => 'structuralstmt', [ 'par', 'parlist' ], 0 ],
  [ 'structuralstmt_16' => 'structuralstmt', [  ], 0 ],
  [ 'description_17' => 'description', [ 'TXT' ], 0 ],
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
  'description_17' => 17,
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
	TXT => { ISSEMANTIC => 1 },
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
		DEFAULT => -39
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
		DEFAULT => -30
	},
	{#State 22
		DEFAULT => -19
	},
	{#State 23
		DEFAULT => -41
	},
	{#State 24
		DEFAULT => -29
	},
	{#State 25
		DEFAULT => -42
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
		DEFAULT => -23
	},
	{#State 28
		ACTIONS => {
			"=" => 48,
			"(" => 49
		},
		DEFAULT => -38
	},
	{#State 29
		DEFAULT => -40
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
			'TXT' => 54
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 56,
			'description' => 55
		}
	},
	{#State 34
		ACTIONS => {
			"(" => 49
		},
		DEFAULT => -38
	},
	{#State 35
		DEFAULT => -3
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
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -32
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
			'expr' => 57,
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
			")" => 58
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
			'expr' => 59,
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
			'expr' => 60,
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
			'expr' => 61,
			'constant' => 21
		}
	},
	{#State 45
		DEFAULT => -31
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
			'expr' => 62,
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
			'expr' => 63,
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
			'equation' => 64,
			'constant' => 21
		}
	},
	{#State 49
		ACTIONS => {
			'VAR' => 65
		},
		GOTOS => {
			'argpairlist' => 66
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
			'expr' => 67,
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
			'macroargpairlist' => 68
		}
	},
	{#State 52
		DEFAULT => -14
	},
	{#State 53
		ACTIONS => {
			"):=" => 69,
			")=" => 70
		}
	},
	{#State 54
		DEFAULT => -17
	},
	{#State 55
		DEFAULT => -5
	},
	{#State 56
		DEFAULT => -11
	},
	{#State 57
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 71
		}
	},
	{#State 58
		DEFAULT => -34
	},
	{#State 59
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -25
	},
	{#State 60
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 44
		},
		DEFAULT => -24
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
		DEFAULT => -28
	},
	{#State 63
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -26
	},
	{#State 64
		DEFAULT => -20
	},
	{#State 65
		ACTIONS => {
			"=" => 72
		}
	},
	{#State 66
		ACTIONS => {
			"," => 73,
			")" => 74
		}
	},
	{#State 67
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"," => 75,
			"/" => 44
		}
	},
	{#State 68
		DEFAULT => -18
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
	{#State 71
		DEFAULT => -35
	},
	{#State 72
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
			'equation' => 78,
			'constant' => 21
		}
	},
	{#State 73
		ACTIONS => {
			'VAR' => 65
		},
		GOTOS => {
			'argpairlist' => 79
		}
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
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
			'expr' => 80,
			'constant' => 21
		}
	},
	{#State 76
		ACTIONS => {
			'TXT' => 54
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 82,
			'description' => 81
		}
	},
	{#State 77
		ACTIONS => {
			'TXT' => 54
		},
		DEFAULT => -8,
		GOTOS => {
			'description' => 83,
			'OPTIONAL-3' => 84
		}
	},
	{#State 78
		DEFAULT => -44
	},
	{#State 79
		DEFAULT => -43
	},
	{#State 80
		ACTIONS => {
			"-" => 42,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 43,
			"/" => 44,
			")" => 85
		}
	},
	{#State 81
		DEFAULT => -9
	},
	{#State 82
		DEFAULT => -13
	},
	{#State 83
		DEFAULT => -7
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		DEFAULT => -36
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 965 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 972 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 979 ./infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 3, undef
#line 983 ./infix2pharmml_model.pm
	],
	[#Rule model_4
		 'model', 1, undef
#line 987 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 994 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1001 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1008 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1015 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1022 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1029 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_11
		 'structuralstmt', 4,
sub {
#line 41 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1036 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_12
		 'structuralstmt', 7,
sub {
#line 43 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 7,
sub {
#line 45 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 4,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 2, undef
#line 1061 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 0, undef
#line 1065 ./infix2pharmml_model.pm
	],
	[#Rule description_17
		 'description', 1,
sub {
#line 54 "infix2pharmml_model.eyp"
 $_[1] }
#line 1072 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_18
		 'macroargpairlist', 3,
sub {
#line 59 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1079 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_19
		 'macroargpairlist', 1,
sub {
#line 60 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1086 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_20
		 'macroargpairlist', 3,
sub {
#line 61 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1093 ./infix2pharmml_model.pm
	],
	[#Rule parlist_21
		 'parlist', 3,
sub {
#line 66 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1100 ./infix2pharmml_model.pm
	],
	[#Rule parlist_22
		 'parlist', 3,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1107 ./infix2pharmml_model.pm
	],
	[#Rule equation_23
		 'equation', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1114 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1121 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1128 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1135 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1142 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1149 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1156 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1163 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1170 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 94 "infix2pharmml_model.eyp"
$_[2]}
#line 1177 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 2,
sub {
#line 95 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1184 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 3,
sub {
#line 96 "infix2pharmml_model.eyp"
$_[2]}
#line 1191 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 4,
sub {
#line 97 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1198 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 6,
sub {
#line 98 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1205 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 99 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1212 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 1,
sub {
#line 100 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1219 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 108 "infix2pharmml_model.eyp"
"notanumber"}
#line 1226 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 109 "infix2pharmml_model.eyp"
"pi"}
#line 1233 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 110 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1240 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 111 "infix2pharmml_model.eyp"
"infinity"}
#line 1247 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 115 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1254 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_44
		 'argpairlist', 3,
sub {
#line 116 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1261 ./infix2pharmml_model.pm
	]
],
#line 1264 ./infix2pharmml_model.pm
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
         'description_17', 
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

#line 124 "infix2pharmml_model.eyp"



=for None

=cut


#line 1335 ./infix2pharmml_model.pm



1;
