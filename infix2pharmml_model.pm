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
  [ '_OPTIONAL' => 'OPTIONAL-1', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ 'model_7' => 'model', [ 'model', 'OPTIONAL-1', 'structuralstmt', 'OPTIONAL-2' ], 0 ],
  [ 'model_8' => 'model', [ 'structuralstmt', 'OPTIONAL-3' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'structuralstmt_15' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'structuralstmt_16' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'structuralstmt_17' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-6' ], 0 ],
  [ 'structuralstmt_18' => 'structuralstmt', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'structuralstmt_19' => 'structuralstmt', [ 'par', 'parlist' ], 0 ],
  [ 'macroargpairlist_20' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_21' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_22' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parlist_23' => 'parlist', [ 'parlist', ',', 'parlist' ], 0 ],
  [ 'parlist_24' => 'parlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_25' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_27' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_32' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_33' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_34' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_35' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_36' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_39' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_40' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_41' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_42' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_43' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_44' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_45' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_46' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_OPTIONAL' => 1,
  '_OPTIONAL' => 2,
  '_OPTIONAL' => 3,
  '_OPTIONAL' => 4,
  '_OPTIONAL' => 5,
  '_OPTIONAL' => 6,
  'model_7' => 7,
  'model_8' => 8,
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  '_OPTIONAL' => 11,
  '_OPTIONAL' => 12,
  '_OPTIONAL' => 13,
  '_OPTIONAL' => 14,
  'structuralstmt_15' => 15,
  'structuralstmt_16' => 16,
  'structuralstmt_17' => 17,
  'structuralstmt_18' => 18,
  'structuralstmt_19' => 19,
  'macroargpairlist_20' => 20,
  'macroargpairlist_21' => 21,
  'macroargpairlist_22' => 22,
  'parlist_23' => 23,
  'parlist_24' => 24,
  'equation_25' => 25,
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
  'expr_39' => 39,
  'expr_40' => 40,
  'constant_41' => 41,
  'constant_42' => 42,
  'constant_43' => 43,
  'constant_44' => 44,
  'argpairlist_45' => 45,
  'argpairlist_46' => 46,
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
			'model' => 6
		}
	},
	{#State 1
		ACTIONS => {
			";" => 7
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-3' => 8
		}
	},
	{#State 2
		ACTIONS => {
			'VAR' => 9
		},
		GOTOS => {
			'parlist' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"(" => 11
		}
	},
	{#State 4
		ACTIONS => {
			'VAR' => 12
		}
	},
	{#State 5
		ACTIONS => {
			":=" => 13
		}
	},
	{#State 6
		ACTIONS => {
			'' => 14,
			";" => 15
		},
		DEFAULT => -2,
		GOTOS => {
			'OPTIONAL-1' => 16
		}
	},
	{#State 7
		DEFAULT => -5
	},
	{#State 8
		DEFAULT => -8
	},
	{#State 9
		ACTIONS => {
			"=" => 17
		}
	},
	{#State 10
		ACTIONS => {
			"," => 18
		},
		DEFAULT => -19
	},
	{#State 11
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 30,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 24,
			'constant' => 23,
			'macroargpairlist' => 33
		}
	},
	{#State 12
		ACTIONS => {
			"," => 34
		}
	},
	{#State 13
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 35,
			'constant' => 23
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			'VAR' => 5,
			"diff(" => 4,
			'MACRO' => 3,
			"par" => 2
		},
		GOTOS => {
			'structuralstmt' => 37
		}
	},
	{#State 17
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 38,
			'constant' => 23
		}
	},
	{#State 18
		ACTIONS => {
			'VAR' => 9
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
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 40,
			'constant' => 23
		}
	},
	{#State 20
		DEFAULT => -41
	},
	{#State 21
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 23
		}
	},
	{#State 22
		ACTIONS => {
			"(" => 42
		}
	},
	{#State 23
		DEFAULT => -32
	},
	{#State 24
		DEFAULT => -21
	},
	{#State 25
		DEFAULT => -43
	},
	{#State 26
		DEFAULT => -31
	},
	{#State 27
		DEFAULT => -44
	},
	{#State 28
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 23
		}
	},
	{#State 29
		ACTIONS => {
			"-" => 44,
			"+" => 45,
			"!" => 47,
			"^" => 48,
			"*" => 49,
			"/" => 46
		},
		DEFAULT => -25
	},
	{#State 30
		ACTIONS => {
			"=" => 50,
			"(" => 51
		},
		DEFAULT => -40
	},
	{#State 31
		DEFAULT => -42
	},
	{#State 32
		ACTIONS => {
			"(" => 52
		}
	},
	{#State 33
		ACTIONS => {
			"," => 53,
			")" => 54
		}
	},
	{#State 34
		ACTIONS => {
			'VAR' => 55
		}
	},
	{#State 35
		ACTIONS => {
			'DESCRIPTION' => 56
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 57
		}
	},
	{#State 36
		ACTIONS => {
			"(" => 51
		},
		DEFAULT => -40
	},
	{#State 37
		ACTIONS => {
			";" => 58
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-2' => 59
		}
	},
	{#State 38
		DEFAULT => -24
	},
	{#State 39
		DEFAULT => -23
	},
	{#State 40
		DEFAULT => -35
	},
	{#State 41
		ACTIONS => {
			"!" => 47,
			"^" => 48,
			"*" => 49,
			"/" => 46
		},
		DEFAULT => -34
	},
	{#State 42
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 60,
			'constant' => 23
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 44,
			"^" => 48,
			"!" => 47,
			"*" => 49,
			"+" => 45,
			"/" => 46,
			")" => 61
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 23
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 23
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 23
		}
	},
	{#State 47
		DEFAULT => -33
	},
	{#State 48
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 65,
			'constant' => 23
		}
	},
	{#State 49
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 23
		}
	},
	{#State 50
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 67,
			'constant' => 23
		}
	},
	{#State 51
		ACTIONS => {
			'VAR' => 68
		},
		GOTOS => {
			'argpairlist' => 69
		}
	},
	{#State 52
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 70,
			'constant' => 23
		}
	},
	{#State 53
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 30,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 24,
			'constant' => 23,
			'macroargpairlist' => 71
		}
	},
	{#State 54
		DEFAULT => -18
	},
	{#State 55
		ACTIONS => {
			"):=" => 72,
			")=" => 73
		}
	},
	{#State 56
		DEFAULT => -9
	},
	{#State 57
		DEFAULT => -15
	},
	{#State 58
		DEFAULT => -3
	},
	{#State 59
		DEFAULT => -7
	},
	{#State 60
		ACTIONS => {
			"-" => 44,
			"^" => 48,
			"!" => 47,
			"*" => 49,
			"+" => 45,
			"/" => 46,
			")" => 74
		}
	},
	{#State 61
		DEFAULT => -36
	},
	{#State 62
		ACTIONS => {
			"!" => 47,
			"^" => 48,
			"*" => 49,
			"/" => 46
		},
		DEFAULT => -27
	},
	{#State 63
		ACTIONS => {
			"!" => 47,
			"^" => 48,
			"*" => 49,
			"/" => 46
		},
		DEFAULT => -26
	},
	{#State 64
		ACTIONS => {
			"!" => 47,
			"^" => 48
		},
		DEFAULT => -29
	},
	{#State 65
		ACTIONS => {
			"!" => 47,
			"^" => 48
		},
		DEFAULT => -30
	},
	{#State 66
		ACTIONS => {
			"!" => 47,
			"^" => 48
		},
		DEFAULT => -28
	},
	{#State 67
		DEFAULT => -22
	},
	{#State 68
		ACTIONS => {
			"=" => 75
		}
	},
	{#State 69
		ACTIONS => {
			"," => 76,
			")" => 77
		}
	},
	{#State 70
		ACTIONS => {
			"-" => 44,
			"^" => 48,
			"!" => 47,
			"*" => 49,
			"+" => 45,
			"," => 78,
			"/" => 46
		}
	},
	{#State 71
		DEFAULT => -20
	},
	{#State 72
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 79,
			'constant' => 23
		}
	},
	{#State 73
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 80,
			'constant' => 23
		}
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 29,
			'equation' => 81,
			'constant' => 23
		}
	},
	{#State 76
		ACTIONS => {
			'VAR' => 68
		},
		GOTOS => {
			'argpairlist' => 82
		}
	},
	{#State 77
		DEFAULT => -39
	},
	{#State 78
		ACTIONS => {
			"-" => 19,
			'NAN' => 20,
			"+" => 21,
			'UNIOP' => 22,
			'EULER' => 25,
			'NUM' => 26,
			'INF' => 27,
			"(" => 28,
			'VAR' => 36,
			'BINOP' => 32,
			'PI' => 31
		},
		GOTOS => {
			'expr' => 83,
			'constant' => 23
		}
	},
	{#State 79
		ACTIONS => {
			'DESCRIPTION' => 85
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-6' => 84
		}
	},
	{#State 80
		ACTIONS => {
			'DESCRIPTION' => 86
		},
		DEFAULT => -12,
		GOTOS => {
			'OPTIONAL-5' => 87
		}
	},
	{#State 81
		DEFAULT => -46
	},
	{#State 82
		DEFAULT => -45
	},
	{#State 83
		ACTIONS => {
			"-" => 44,
			"^" => 48,
			"!" => 47,
			"*" => 49,
			"+" => 45,
			"/" => 46,
			")" => 88
		}
	},
	{#State 84
		DEFAULT => -17
	},
	{#State 85
		DEFAULT => -13
	},
	{#State 86
		DEFAULT => -11
	},
	{#State 87
		DEFAULT => -16
	},
	{#State 88
		DEFAULT => -38
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 985 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 992 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 999 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1006 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1013 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1020 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1027 ./infix2pharmml_model.pm
	],
	[#Rule model_7
		 'model', 4, undef
#line 1031 ./infix2pharmml_model.pm
	],
	[#Rule model_8
		 'model', 2, undef
#line 1035 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1042 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1049 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1056 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1063 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1070 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1077 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_15
		 'structuralstmt', 4,
sub {
#line 41 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1084 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_16
		 'structuralstmt', 7,
sub {
#line 43 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1091 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_17
		 'structuralstmt', 7,
sub {
#line 45 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1098 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_18
		 'structuralstmt', 4,
sub {
#line 47 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1105 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_19
		 'structuralstmt', 2, undef
#line 1109 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_20
		 'macroargpairlist', 3,
sub {
#line 55 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1116 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_21
		 'macroargpairlist', 1,
sub {
#line 56 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1123 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_22
		 'macroargpairlist', 3,
sub {
#line 57 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1130 ./infix2pharmml_model.pm
	],
	[#Rule parlist_23
		 'parlist', 3,
sub {
#line 62 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1137 ./infix2pharmml_model.pm
	],
	[#Rule parlist_24
		 'parlist', 3,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1144 ./infix2pharmml_model.pm
	],
	[#Rule equation_25
		 'equation', 1,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1151 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1158 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1165 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1172 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 85 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1179 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1186 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 1,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1193 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 1,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1200 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 2,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1207 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 2,
sub {
#line 90 "infix2pharmml_model.eyp"
$_[2]}
#line 1214 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 2,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1221 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 3,
sub {
#line 92 "infix2pharmml_model.eyp"
$_[2]}
#line 1228 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1235 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 6,
sub {
#line 94 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1242 ./infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 4,
sub {
#line 95 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1249 ./infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 1,
sub {
#line 96 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1256 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 104 "infix2pharmml_model.eyp"
"notanumber"}
#line 1263 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 105 "infix2pharmml_model.eyp"
"pi"}
#line 1270 ./infix2pharmml_model.pm
	],
	[#Rule constant_43
		 'constant', 1,
sub {
#line 106 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1277 ./infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 107 "infix2pharmml_model.eyp"
"infinity"}
#line 1284 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_45
		 'argpairlist', 3,
sub {
#line 111 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1291 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_46
		 'argpairlist', 3,
sub {
#line 112 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1298 ./infix2pharmml_model.pm
	]
],
#line 1301 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'model_7', 
         'model_8', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'structuralstmt_15', 
         'structuralstmt_16', 
         'structuralstmt_17', 
         'structuralstmt_18', 
         'structuralstmt_19', 
         'macroargpairlist_20', 
         'macroargpairlist_21', 
         'macroargpairlist_22', 
         'parlist_23', 
         'parlist_24', 
         'equation_25', 
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
         'expr_39', 
         'expr_40', 
         'constant_41', 
         'constant_42', 
         'constant_43', 
         'constant_44', 
         'argpairlist_45', 
         'argpairlist_46', );
  $self;
}

#line 120 "infix2pharmml_model.eyp"



=for None

=cut


#line 1374 ./infix2pharmml_model.pm



1;
