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
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'COMMENT' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ 'line_7' => 'line', [ 'assignment', 'OPTIONAL-1', 'OPTIONAL-2' ], 0 ],
  [ 'assignment_8' => 'assignment', [ 'common' ], 0 ],
  [ 'assignment_9' => 'assignment', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'assignment_10' => 'assignment', [ 'par', 'parameterlist' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ 'common_17' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'common_18' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'common_19' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'equation_20' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_21' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_27' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_28' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_29' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_32' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_33' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_34' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_35' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_36' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_37' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_38' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_39' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_40' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_41' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_42' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_43' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_44' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_45' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parameterlist_46' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_47' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  'line_7' => 7,
  'assignment_8' => 8,
  'assignment_9' => 9,
  'assignment_10' => 10,
  '_OPTIONAL' => 11,
  '_OPTIONAL' => 12,
  '_OPTIONAL' => 13,
  '_OPTIONAL' => 14,
  '_OPTIONAL' => 15,
  '_OPTIONAL' => 16,
  'common_17' => 17,
  'common_18' => 18,
  'common_19' => 19,
  'equation_20' => 20,
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
  'expr_36' => 36,
  'constant_37' => 37,
  'constant_38' => 38,
  'constant_39' => 39,
  'constant_40' => 40,
  'argpairlist_41' => 41,
  'argpairlist_42' => 42,
  'macroargpairlist_43' => 43,
  'macroargpairlist_44' => 44,
  'macroargpairlist_45' => 45,
  'parameterlist_46' => 46,
  'parameterlist_47' => 47,
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
			"diff(" => 7,
			'VAR' => 6,
			"par" => 5,
			'MACRO' => 4
		},
		GOTOS => {
			'assignment' => 1,
			'model' => 2,
			'common' => 3,
			'line' => 8
		}
	},
	{#State 1
		ACTIONS => {
			";" => 9
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'' => 11,
			'MACRO' => 4,
			"par" => 5,
			'VAR' => 6,
			"diff(" => 7
		},
		GOTOS => {
			'assignment' => 1,
			'common' => 3,
			'line' => 12
		}
	},
	{#State 3
		DEFAULT => -8
	},
	{#State 4
		ACTIONS => {
			"(" => 13
		}
	},
	{#State 5
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 14
		}
	},
	{#State 6
		ACTIONS => {
			":=" => 16
		}
	},
	{#State 7
		ACTIONS => {
			'VAR' => 17
		}
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		ACTIONS => {
			'COMMENT' => 18
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 19
		}
	},
	{#State 11
		DEFAULT => 0
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			"delay" => 29,
			'UNIOP' => 28,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 33,
			'PI' => 35,
			'BINOP' => 34
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 23,
			'macroargpairlist' => 27
		}
	},
	{#State 14
		ACTIONS => {
			"," => 36
		},
		DEFAULT => -10
	},
	{#State 15
		ACTIONS => {
			"=" => 37
		}
	},
	{#State 16
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 38
		}
	},
	{#State 17
		ACTIONS => {
			"," => 40
		}
	},
	{#State 18
		DEFAULT => -5
	},
	{#State 19
		DEFAULT => -7
	},
	{#State 20
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 30
		}
	},
	{#State 21
		DEFAULT => -37
	},
	{#State 22
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 42,
			'constant' => 30
		}
	},
	{#State 23
		DEFAULT => -44
	},
	{#State 24
		DEFAULT => -26
	},
	{#State 25
		DEFAULT => -40
	},
	{#State 26
		ACTIONS => {
			"-" => 43,
			"+" => 44,
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 48
		},
		DEFAULT => -20
	},
	{#State 27
		ACTIONS => {
			"," => 49,
			")" => 50
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 51
		}
	},
	{#State 29
		ACTIONS => {
			"(" => 52
		}
	},
	{#State 30
		DEFAULT => -27
	},
	{#State 31
		DEFAULT => -39
	},
	{#State 32
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 53,
			'constant' => 30
		}
	},
	{#State 33
		ACTIONS => {
			"=" => 54,
			"(" => 55
		},
		DEFAULT => -36
	},
	{#State 34
		ACTIONS => {
			"(" => 56
		}
	},
	{#State 35
		DEFAULT => -38
	},
	{#State 36
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 57
		}
	},
	{#State 37
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 58
		}
	},
	{#State 38
		ACTIONS => {
			'DESCRIPTION' => 59
		},
		DEFAULT => -12,
		GOTOS => {
			'OPTIONAL-3' => 60
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 55
		},
		DEFAULT => -36
	},
	{#State 40
		ACTIONS => {
			'VAR' => 61
		}
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 48
		},
		DEFAULT => -29
	},
	{#State 43
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 30
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 30
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 30
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 65,
			'constant' => 30
		}
	},
	{#State 48
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 30
		}
	},
	{#State 49
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 33,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 23,
			'macroargpairlist' => 67
		}
	},
	{#State 50
		DEFAULT => -9
	},
	{#State 51
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 68,
			'constant' => 30
		}
	},
	{#State 52
		ACTIONS => {
			'VAR' => 69
		}
	},
	{#State 53
		ACTIONS => {
			"-" => 43,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 44,
			"/" => 48,
			")" => 70
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 71
		}
	},
	{#State 55
		ACTIONS => {
			'VAR' => 73
		},
		GOTOS => {
			'argpairlist' => 72
		}
	},
	{#State 56
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 74,
			'constant' => 30
		}
	},
	{#State 57
		DEFAULT => -46
	},
	{#State 58
		DEFAULT => -47
	},
	{#State 59
		DEFAULT => -11
	},
	{#State 60
		DEFAULT => -17
	},
	{#State 61
		ACTIONS => {
			"):=" => 75,
			")=" => 76
		}
	},
	{#State 62
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 48
		},
		DEFAULT => -22
	},
	{#State 63
		ACTIONS => {
			"!" => 45,
			"^" => 46,
			"*" => 47,
			"/" => 48
		},
		DEFAULT => -21
	},
	{#State 64
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -25
	},
	{#State 65
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -23
	},
	{#State 66
		ACTIONS => {
			"!" => 45,
			"^" => 46
		},
		DEFAULT => -24
	},
	{#State 67
		DEFAULT => -43
	},
	{#State 68
		ACTIONS => {
			"-" => 43,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 44,
			"/" => 48,
			")" => 77
		}
	},
	{#State 69
		ACTIONS => {
			"," => 78
		}
	},
	{#State 70
		DEFAULT => -31
	},
	{#State 71
		DEFAULT => -45
	},
	{#State 72
		ACTIONS => {
			"," => 79,
			")" => 80
		}
	},
	{#State 73
		ACTIONS => {
			"=" => 81
		}
	},
	{#State 74
		ACTIONS => {
			"-" => 43,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 44,
			"/" => 48,
			"," => 82
		}
	},
	{#State 75
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 83
		}
	},
	{#State 76
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 84
		}
	},
	{#State 77
		DEFAULT => -32
	},
	{#State 78
		ACTIONS => {
			'VAR' => 85
		}
	},
	{#State 79
		ACTIONS => {
			'VAR' => 73
		},
		GOTOS => {
			'argpairlist' => 86
		}
	},
	{#State 80
		DEFAULT => -35
	},
	{#State 81
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 30,
			'equation' => 87
		}
	},
	{#State 82
		ACTIONS => {
			"-" => 20,
			'NAN' => 21,
			"+" => 22,
			'UNIOP' => 28,
			"delay" => 29,
			'EULER' => 31,
			'NUM' => 24,
			"(" => 32,
			'INF' => 25,
			'VAR' => 39,
			'BINOP' => 34,
			'PI' => 35
		},
		GOTOS => {
			'expr' => 88,
			'constant' => 30
		}
	},
	{#State 83
		ACTIONS => {
			'DESCRIPTION' => 89
		},
		DEFAULT => -16,
		GOTOS => {
			'OPTIONAL-5' => 90
		}
	},
	{#State 84
		ACTIONS => {
			'DESCRIPTION' => 91
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 92
		}
	},
	{#State 85
		ACTIONS => {
			")" => 93
		}
	},
	{#State 86
		DEFAULT => -41
	},
	{#State 87
		DEFAULT => -42
	},
	{#State 88
		ACTIONS => {
			"-" => 43,
			"^" => 46,
			"!" => 45,
			"*" => 47,
			"+" => 44,
			"/" => 48,
			")" => 94
		}
	},
	{#State 89
		DEFAULT => -15
	},
	{#State 90
		DEFAULT => -19
	},
	{#State 91
		DEFAULT => -13
	},
	{#State 92
		DEFAULT => -18
	},
	{#State 93
		DEFAULT => -34
	},
	{#State 94
		DEFAULT => -33
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1035 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 1039 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule line_7
		 'line', 3, undef
#line 1075 ./infix2pharmml_model.pm
	],
	[#Rule assignment_8
		 'assignment', 1, undef
#line 1079 ./infix2pharmml_model.pm
	],
	[#Rule assignment_9
		 'assignment', 4,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1086 ./infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 2, undef
#line 1090 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1097 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1104 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1111 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1118 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1125 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1132 ./infix2pharmml_model.pm
	],
	[#Rule common_17
		 'common', 4,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1139 ./infix2pharmml_model.pm
	],
	[#Rule common_18
		 'common', 7,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1146 ./infix2pharmml_model.pm
	],
	[#Rule common_19
		 'common', 7,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1153 ./infix2pharmml_model.pm
	],
	[#Rule equation_20
		 'equation', 1,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1160 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1167 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1174 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1181 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1188 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1195 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1202 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1209 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1216 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 2,
sub {
#line 85 "infix2pharmml_model.eyp"
$_[2]}
#line 1223 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1230 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
$_[2]}
#line 1237 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 4,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1244 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 6,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1251 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 6,
sub {
#line 90 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1258 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 4,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1265 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1272 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 100 "infix2pharmml_model.eyp"
"notanumber"}
#line 1279 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"pi"}
#line 1286 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1293 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"infinity"}
#line 1300 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_41
		 'argpairlist', 3,
sub {
#line 107 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1307 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_42
		 'argpairlist', 3,
sub {
#line 108 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1314 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_43
		 'macroargpairlist', 3,
sub {
#line 118 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1321 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_44
		 'macroargpairlist', 1,
sub {
#line 119 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1328 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_45
		 'macroargpairlist', 3,
sub {
#line 120 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1335 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_46
		 'parameterlist', 3,
sub {
#line 125 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1342 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_47
		 'parameterlist', 3,
sub {
#line 126 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1349 ./infix2pharmml_model.pm
	]
],
#line 1352 ./infix2pharmml_model.pm
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
         'line_7', 
         'assignment_8', 
         'assignment_9', 
         'assignment_10', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_17', 
         'common_18', 
         'common_19', 
         'equation_20', 
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
         'expr_36', 
         'constant_37', 
         'constant_38', 
         'constant_39', 
         'constant_40', 
         'argpairlist_41', 
         'argpairlist_42', 
         'macroargpairlist_43', 
         'macroargpairlist_44', 
         'macroargpairlist_45', 
         'parameterlist_46', 
         'parameterlist_47', );
  $self;
}

#line 130 "infix2pharmml_model.eyp"



=for None

=cut


#line 1426 ./infix2pharmml_model.pm



1;
