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

      m{\G(diff\(|delay|par|\)\:\=|\)\=|\:\=|\^|\/|\,|\;|\+|\*|\)|\=|\!|\(|\-)}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt|heaviside|sign)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
      /\G#(.+?)$/gc and return ('COMMENT', $1);
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


#line 72 ./infix2pharmml_model.pm

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
  [ 'line_5' => 'line', [ 'assignment', 'OPTIONAL-1' ], 0 ],
  [ 'line_6' => 'line', [ 'COMMENT' ], 0 ],
  [ 'assignment_7' => 'assignment', [ 'common' ], 0 ],
  [ 'assignment_8' => 'assignment', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'assignment_9' => 'assignment', [ 'par', 'parameterlist' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'common_16' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'common_17' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'common_18' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'equation_19' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_20' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_21' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_26' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_27' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_28' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_31' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_32' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_33' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_34' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_35' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_36' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_37' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_38' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_39' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_40' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_41' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_42' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_43' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_44' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parameterlist_45' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_46' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'model_1' => 1,
  'model_2' => 2,
  '_OPTIONAL' => 3,
  '_OPTIONAL' => 4,
  'line_5' => 5,
  'line_6' => 6,
  'assignment_7' => 7,
  'assignment_8' => 8,
  'assignment_9' => 9,
  '_OPTIONAL' => 10,
  '_OPTIONAL' => 11,
  '_OPTIONAL' => 12,
  '_OPTIONAL' => 13,
  '_OPTIONAL' => 14,
  '_OPTIONAL' => 15,
  'common_16' => 16,
  'common_17' => 17,
  'common_18' => 18,
  'equation_19' => 19,
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
  'expr_34' => 34,
  'expr_35' => 35,
  'constant_36' => 36,
  'constant_37' => 37,
  'constant_38' => 38,
  'constant_39' => 39,
  'argpairlist_40' => 40,
  'argpairlist_41' => 41,
  'macroargpairlist_42' => 42,
  'macroargpairlist_43' => 43,
  'macroargpairlist_44' => 44,
  'parameterlist_45' => 45,
  'parameterlist_46' => 46,
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
	COMMENT => { ISSEMANTIC => 1 },
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
			'VAR' => 4,
			'COMMENT' => 1,
			"par" => 6,
			'MACRO' => 8,
			"diff(" => 9
		},
		GOTOS => {
			'assignment' => 3,
			'line' => 7,
			'model' => 5,
			'common' => 2
		}
	},
	{#State 1
		DEFAULT => -6
	},
	{#State 2
		DEFAULT => -7
	},
	{#State 3
		ACTIONS => {
			";" => 11
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 10
		}
	},
	{#State 4
		ACTIONS => {
			":=" => 12
		}
	},
	{#State 5
		ACTIONS => {
			'VAR' => 4,
			'COMMENT' => 1,
			'' => 13,
			"par" => 6,
			"diff(" => 9,
			'MACRO' => 8
		},
		GOTOS => {
			'assignment' => 3,
			'line' => 14,
			'common' => 2
		}
	},
	{#State 6
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 16
		}
	},
	{#State 7
		DEFAULT => -2
	},
	{#State 8
		ACTIONS => {
			"(" => 17
		}
	},
	{#State 9
		ACTIONS => {
			'VAR' => 18
		}
	},
	{#State 10
		DEFAULT => -5
	},
	{#State 11
		DEFAULT => -3
	},
	{#State 12
		ACTIONS => {
			'BINOP' => 33,
			'INF' => 32,
			"-" => 31,
			"delay" => 29,
			'NAN' => 28,
			"(" => 27,
			'UNIOP' => 26,
			'EULER' => 24,
			'VAR' => 22,
			"+" => 23,
			'PI' => 21,
			'NUM' => 19
		},
		GOTOS => {
			'constant' => 30,
			'equation' => 20,
			'expr' => 25
		}
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		ACTIONS => {
			"=" => 34
		}
	},
	{#State 16
		ACTIONS => {
			"," => 35
		},
		DEFAULT => -9
	},
	{#State 17
		ACTIONS => {
			'EULER' => 24,
			"+" => 23,
			'VAR' => 36,
			'PI' => 21,
			'NUM' => 19,
			'BINOP' => 33,
			"-" => 31,
			'INF' => 32,
			"delay" => 29,
			'NAN' => 28,
			'UNIOP' => 26,
			"(" => 27
		},
		GOTOS => {
			'expr' => 25,
			'equation' => 37,
			'macroargpairlist' => 38,
			'constant' => 30
		}
	},
	{#State 18
		ACTIONS => {
			"," => 39
		}
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		ACTIONS => {
			'DESCRIPTION' => 40
		},
		DEFAULT => -11,
		GOTOS => {
			'OPTIONAL-2' => 41
		}
	},
	{#State 21
		DEFAULT => -37
	},
	{#State 22
		ACTIONS => {
			"(" => 42
		},
		DEFAULT => -35
	},
	{#State 23
		ACTIONS => {
			'PI' => 21,
			"+" => 23,
			'VAR' => 22,
			'EULER' => 24,
			'NUM' => 19,
			"-" => 31,
			'INF' => 32,
			'BINOP' => 33,
			"(" => 27,
			'UNIOP' => 26,
			"delay" => 29,
			'NAN' => 28
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 30
		}
	},
	{#State 24
		DEFAULT => -38
	},
	{#State 25
		ACTIONS => {
			"!" => 46,
			"*" => 45,
			"-" => 44,
			"+" => 49,
			"^" => 48,
			"/" => 47
		},
		DEFAULT => -19
	},
	{#State 26
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 27
		ACTIONS => {
			"delay" => 29,
			'NAN' => 28,
			'UNIOP' => 26,
			"(" => 27,
			'BINOP' => 33,
			"-" => 31,
			'INF' => 32,
			'NUM' => 19,
			'EULER' => 24,
			'PI' => 21,
			"+" => 23,
			'VAR' => 22
		},
		GOTOS => {
			'expr' => 51,
			'constant' => 30
		}
	},
	{#State 28
		DEFAULT => -36
	},
	{#State 29
		ACTIONS => {
			"(" => 52
		}
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			'PI' => 21,
			"+" => 23,
			'VAR' => 22,
			'EULER' => 24,
			'NUM' => 19,
			"-" => 31,
			'INF' => 32,
			'BINOP' => 33,
			"(" => 27,
			'UNIOP' => 26,
			"delay" => 29,
			'NAN' => 28
		},
		GOTOS => {
			'constant' => 30,
			'expr' => 53
		}
	},
	{#State 32
		DEFAULT => -39
	},
	{#State 33
		ACTIONS => {
			"(" => 54
		}
	},
	{#State 34
		ACTIONS => {
			'NUM' => 19,
			'PI' => 21,
			'VAR' => 22,
			"+" => 23,
			'EULER' => 24,
			'UNIOP' => 26,
			"(" => 27,
			"delay" => 29,
			'NAN' => 28,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 30,
			'equation' => 55
		}
	},
	{#State 35
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 56
		}
	},
	{#State 36
		ACTIONS => {
			"=" => 57,
			"(" => 42
		},
		DEFAULT => -35
	},
	{#State 37
		DEFAULT => -43
	},
	{#State 38
		ACTIONS => {
			"," => 58,
			")" => 59
		}
	},
	{#State 39
		ACTIONS => {
			'VAR' => 60
		}
	},
	{#State 40
		DEFAULT => -10
	},
	{#State 41
		DEFAULT => -16
	},
	{#State 42
		ACTIONS => {
			'VAR' => 61
		},
		GOTOS => {
			'argpairlist' => 62
		}
	},
	{#State 43
		ACTIONS => {
			"/" => 47,
			"^" => 48,
			"*" => 45,
			"!" => 46
		},
		DEFAULT => -28
	},
	{#State 44
		ACTIONS => {
			'NAN' => 28,
			"delay" => 29,
			"(" => 27,
			'UNIOP' => 26,
			'BINOP' => 33,
			"-" => 31,
			'INF' => 32,
			'NUM' => 19,
			'EULER' => 24,
			'PI' => 21,
			"+" => 23,
			'VAR' => 22
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 30
		}
	},
	{#State 45
		ACTIONS => {
			'PI' => 21,
			'VAR' => 22,
			"+" => 23,
			'EULER' => 24,
			'NUM' => 19,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			"(" => 27,
			'UNIOP' => 26,
			"delay" => 29,
			'NAN' => 28
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 30
		}
	},
	{#State 46
		DEFAULT => -27
	},
	{#State 47
		ACTIONS => {
			'UNIOP' => 26,
			"(" => 27,
			"delay" => 29,
			'NAN' => 28,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			'NUM' => 19,
			"+" => 23,
			'VAR' => 22,
			'PI' => 21,
			'EULER' => 24
		},
		GOTOS => {
			'expr' => 65,
			'constant' => 30
		}
	},
	{#State 48
		ACTIONS => {
			'NUM' => 19,
			'EULER' => 24,
			"+" => 23,
			'VAR' => 22,
			'PI' => 21,
			"delay" => 29,
			'NAN' => 28,
			'UNIOP' => 26,
			"(" => 27,
			'BINOP' => 33,
			'INF' => 32,
			"-" => 31
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 30
		}
	},
	{#State 49
		ACTIONS => {
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			'UNIOP' => 26,
			"(" => 27,
			"delay" => 29,
			'NAN' => 28,
			'PI' => 21,
			"+" => 23,
			'VAR' => 22,
			'EULER' => 24,
			'NUM' => 19
		},
		GOTOS => {
			'constant' => 30,
			'expr' => 67
		}
	},
	{#State 50
		ACTIONS => {
			'EULER' => 24,
			'PI' => 21,
			"+" => 23,
			'VAR' => 22,
			'NUM' => 19,
			'BINOP' => 33,
			"-" => 31,
			'INF' => 32,
			"delay" => 29,
			'NAN' => 28,
			"(" => 27,
			'UNIOP' => 26
		},
		GOTOS => {
			'expr' => 68,
			'constant' => 30
		}
	},
	{#State 51
		ACTIONS => {
			"!" => 46,
			"-" => 44,
			"+" => 49,
			"*" => 45,
			"^" => 48,
			"/" => 47,
			")" => 69
		}
	},
	{#State 52
		ACTIONS => {
			'VAR' => 70
		}
	},
	{#State 53
		DEFAULT => -29
	},
	{#State 54
		ACTIONS => {
			"(" => 27,
			'UNIOP' => 26,
			'NAN' => 28,
			"delay" => 29,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			'NUM' => 19,
			'PI' => 21,
			'VAR' => 22,
			"+" => 23,
			'EULER' => 24
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 30
		}
	},
	{#State 55
		DEFAULT => -46
	},
	{#State 56
		DEFAULT => -45
	},
	{#State 57
		ACTIONS => {
			'NUM' => 19,
			'VAR' => 22,
			"+" => 23,
			'PI' => 21,
			'EULER' => 24,
			"(" => 27,
			'UNIOP' => 26,
			"delay" => 29,
			'NAN' => 28,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33
		},
		GOTOS => {
			'equation' => 72,
			'constant' => 30,
			'expr' => 25
		}
	},
	{#State 58
		ACTIONS => {
			'BINOP' => 33,
			'INF' => 32,
			"-" => 31,
			'NAN' => 28,
			"delay" => 29,
			"(" => 27,
			'UNIOP' => 26,
			'EULER' => 24,
			'PI' => 21,
			'VAR' => 36,
			"+" => 23,
			'NUM' => 19
		},
		GOTOS => {
			'constant' => 30,
			'macroargpairlist' => 73,
			'equation' => 37,
			'expr' => 25
		}
	},
	{#State 59
		DEFAULT => -8
	},
	{#State 60
		ACTIONS => {
			")=" => 74,
			"):=" => 75
		}
	},
	{#State 61
		ACTIONS => {
			"=" => 76
		}
	},
	{#State 62
		ACTIONS => {
			"," => 77,
			")" => 78
		}
	},
	{#State 63
		ACTIONS => {
			"^" => 48,
			"/" => 47,
			"!" => 46,
			"*" => 45
		},
		DEFAULT => -21
	},
	{#State 64
		ACTIONS => {
			"^" => 48,
			"!" => 46
		},
		DEFAULT => -22
	},
	{#State 65
		ACTIONS => {
			"!" => 46,
			"^" => 48
		},
		DEFAULT => -23
	},
	{#State 66
		ACTIONS => {
			"^" => 48,
			"!" => 46
		},
		DEFAULT => -24
	},
	{#State 67
		ACTIONS => {
			"!" => 46,
			"*" => 45,
			"^" => 48,
			"/" => 47
		},
		DEFAULT => -20
	},
	{#State 68
		ACTIONS => {
			"+" => 49,
			"-" => 44,
			"!" => 46,
			")" => 79,
			"/" => 47,
			"^" => 48,
			"*" => 45
		}
	},
	{#State 69
		DEFAULT => -30
	},
	{#State 70
		ACTIONS => {
			"," => 80
		}
	},
	{#State 71
		ACTIONS => {
			"!" => 46,
			"," => 81,
			"+" => 49,
			"-" => 44,
			"^" => 48,
			"*" => 45,
			"/" => 47
		}
	},
	{#State 72
		DEFAULT => -44
	},
	{#State 73
		DEFAULT => -42
	},
	{#State 74
		ACTIONS => {
			"+" => 23,
			'VAR' => 22,
			'PI' => 21,
			'EULER' => 24,
			'NUM' => 19,
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			"(" => 27,
			'UNIOP' => 26,
			'NAN' => 28,
			"delay" => 29
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 30,
			'equation' => 82
		}
	},
	{#State 75
		ACTIONS => {
			'BINOP' => 33,
			'INF' => 32,
			"-" => 31,
			'NAN' => 28,
			"delay" => 29,
			'UNIOP' => 26,
			"(" => 27,
			'EULER' => 24,
			'PI' => 21,
			"+" => 23,
			'VAR' => 22,
			'NUM' => 19
		},
		GOTOS => {
			'equation' => 83,
			'constant' => 30,
			'expr' => 25
		}
	},
	{#State 76
		ACTIONS => {
			'INF' => 32,
			"-" => 31,
			'BINOP' => 33,
			"(" => 27,
			'UNIOP' => 26,
			"delay" => 29,
			'NAN' => 28,
			'VAR' => 22,
			"+" => 23,
			'PI' => 21,
			'EULER' => 24,
			'NUM' => 19
		},
		GOTOS => {
			'constant' => 30,
			'equation' => 84,
			'expr' => 25
		}
	},
	{#State 77
		ACTIONS => {
			'VAR' => 61
		},
		GOTOS => {
			'argpairlist' => 85
		}
	},
	{#State 78
		DEFAULT => -34
	},
	{#State 79
		DEFAULT => -31
	},
	{#State 80
		ACTIONS => {
			'VAR' => 86
		}
	},
	{#State 81
		ACTIONS => {
			"-" => 31,
			'INF' => 32,
			'BINOP' => 33,
			'UNIOP' => 26,
			"(" => 27,
			'NAN' => 28,
			"delay" => 29,
			'PI' => 21,
			'VAR' => 22,
			"+" => 23,
			'EULER' => 24,
			'NUM' => 19
		},
		GOTOS => {
			'constant' => 30,
			'expr' => 87
		}
	},
	{#State 82
		ACTIONS => {
			'DESCRIPTION' => 88
		},
		DEFAULT => -13,
		GOTOS => {
			'OPTIONAL-3' => 89
		}
	},
	{#State 83
		ACTIONS => {
			'DESCRIPTION' => 90
		},
		DEFAULT => -15,
		GOTOS => {
			'OPTIONAL-4' => 91
		}
	},
	{#State 84
		DEFAULT => -41
	},
	{#State 85
		DEFAULT => -40
	},
	{#State 86
		ACTIONS => {
			")" => 92
		}
	},
	{#State 87
		ACTIONS => {
			"!" => 46,
			"+" => 49,
			"-" => 44,
			"*" => 45,
			"^" => 48,
			")" => 93,
			"/" => 47
		}
	},
	{#State 88
		DEFAULT => -12
	},
	{#State 89
		DEFAULT => -17
	},
	{#State 90
		DEFAULT => -14
	},
	{#State 91
		DEFAULT => -18
	},
	{#State 92
		DEFAULT => -33
	},
	{#State 93
		DEFAULT => -32
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1026 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 1030 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 1034 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1041 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 40 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1048 ./infix2pharmml_model.pm
	],
	[#Rule line_5
		 'line', 2, undef
#line 1052 ./infix2pharmml_model.pm
	],
	[#Rule line_6
		 'line', 1,
sub {
#line 41 "infix2pharmml_model.eyp"
  infix2pharmml::comment($_[1]); }
#line 1059 ./infix2pharmml_model.pm
	],
	[#Rule assignment_7
		 'assignment', 1, undef
#line 1063 ./infix2pharmml_model.pm
	],
	[#Rule assignment_8
		 'assignment', 4,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1070 ./infix2pharmml_model.pm
	],
	[#Rule assignment_9
		 'assignment', 2, undef
#line 1074 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1081 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1088 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1095 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1102 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1109 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1116 ./infix2pharmml_model.pm
	],
	[#Rule common_16
		 'common', 4,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1123 ./infix2pharmml_model.pm
	],
	[#Rule common_17
		 'common', 7,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1130 ./infix2pharmml_model.pm
	],
	[#Rule common_18
		 'common', 7,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1137 ./infix2pharmml_model.pm
	],
	[#Rule equation_19
		 'equation', 1,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1144 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1151 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1158 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1165 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1172 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1179 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1186 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1193 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 2,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1200 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 85 "infix2pharmml_model.eyp"
$_[2]}
#line 1207 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1214 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
$_[2]}
#line 1221 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 4,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1228 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 6,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1235 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 6,
sub {
#line 90 "infix2pharmml_model.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 1242 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1249 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1256 ./infix2pharmml_model.pm
	],
	[#Rule constant_36
		 'constant', 1,
sub {
#line 100 "infix2pharmml_model.eyp"
"notanumber"}
#line 1263 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"pi"}
#line 1270 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1277 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"infinity"}
#line 1284 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_40
		 'argpairlist', 3,
sub {
#line 107 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1291 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_41
		 'argpairlist', 3,
sub {
#line 108 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1298 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_42
		 'macroargpairlist', 3,
sub {
#line 118 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1305 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_43
		 'macroargpairlist', 1,
sub {
#line 119 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1312 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_44
		 'macroargpairlist', 3,
sub {
#line 120 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1319 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_45
		 'parameterlist', 3,
sub {
#line 125 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1326 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_46
		 'parameterlist', 3,
sub {
#line 126 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1333 ./infix2pharmml_model.pm
	]
],
#line 1336 ./infix2pharmml_model.pm
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
         'line_6', 
         'assignment_7', 
         'assignment_8', 
         'assignment_9', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_16', 
         'common_17', 
         'common_18', 
         'equation_19', 
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
         'expr_34', 
         'expr_35', 
         'constant_36', 
         'constant_37', 
         'constant_38', 
         'constant_39', 
         'argpairlist_40', 
         'argpairlist_41', 
         'macroargpairlist_42', 
         'macroargpairlist_43', 
         'macroargpairlist_44', 
         'parameterlist_45', 
         'parameterlist_46', );
  $self;
}

#line 130 "infix2pharmml_model.eyp"



=for None

=cut


#line 1409 ./infix2pharmml_model.pm



1;
