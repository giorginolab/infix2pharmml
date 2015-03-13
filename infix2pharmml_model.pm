########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'infix2pharmml_base.eyp' instead.
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

      m{\G(delay|diff\(|\)\:\=|\)\=|\:\=|\)|\;|\-|\!|\(|\=|\+|\/|\,|\^|\*)}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt|heaviside|sign)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G\b(par)\b/gc and return ('PAR', $1);
      /\G([+-]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
      /\G#(.*)/gc and return ('COMMENT', $1);
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


#line 73 infix2pharmml_model.pm

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
  [ '_PLUS_LIST' => 'PLUS-1', [ 'PLUS-1', 'line' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-1', [ 'line' ], 0 ],
  [ 'model_3' => 'model', [ 'PLUS-1' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'COMMENT' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ 'line_8' => 'line', [ 'COMMENT' ], 0 ],
  [ 'line_9' => 'line', [ 'assignment', 'OPTIONAL-2', 'OPTIONAL-3' ], 0 ],
  [ 'assignment_10' => 'assignment', [ 'common' ], 0 ],
  [ 'assignment_11' => 'assignment', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'assignment_12' => 'assignment', [ 'PAR', 'parameterlist' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'common_19' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'common_20' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'common_21' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-6' ], 0 ],
  [ 'parameterlist_22' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_23' => 'parameterlist', [ 'VAR', '=', 'NUM' ], 0 ],
  [ 'parameterlist_24' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'equation_25' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_27' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_32' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_33' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_34' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_35' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_36' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_39' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_40' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_41' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_42' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_43' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_44' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_45' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_46' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_47' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_48' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_49' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PLUS_LIST' => 1,
  '_PLUS_LIST' => 2,
  'model_3' => 3,
  '_OPTIONAL' => 4,
  '_OPTIONAL' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  'line_8' => 8,
  'line_9' => 9,
  'assignment_10' => 10,
  'assignment_11' => 11,
  'assignment_12' => 12,
  '_OPTIONAL' => 13,
  '_OPTIONAL' => 14,
  '_OPTIONAL' => 15,
  '_OPTIONAL' => 16,
  '_OPTIONAL' => 17,
  '_OPTIONAL' => 18,
  'common_19' => 19,
  'common_20' => 20,
  'common_21' => 21,
  'parameterlist_22' => 22,
  'parameterlist_23' => 23,
  'parameterlist_24' => 24,
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
  'macroargpairlist_47' => 47,
  'macroargpairlist_48' => 48,
  'macroargpairlist_49' => 49,
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
	BINOP => { ISSEMANTIC => 1 },
	COMMENT => { ISSEMANTIC => 1 },
	DESCRIPTION => { ISSEMANTIC => 1 },
	EULER => { ISSEMANTIC => 1 },
	INF => { ISSEMANTIC => 1 },
	MACRO => { ISSEMANTIC => 1 },
	NAN => { ISSEMANTIC => 1 },
	NEG => { ISSEMANTIC => 1 },
	NUM => { ISSEMANTIC => 1 },
	PAR => { ISSEMANTIC => 1 },
	PI => { ISSEMANTIC => 1 },
	UNIOP => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'infix2pharmml_base.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"diff(" => 10,
			'PAR' => 4,
			'VAR' => 2,
			'MACRO' => 7,
			'COMMENT' => 6
		},
		GOTOS => {
			'model' => 8,
			'PLUS-1' => 1,
			'line' => 5,
			'assignment' => 3,
			'common' => 9
		}
	},
	{#State 1
		ACTIONS => {
			'COMMENT' => 6,
			'MACRO' => 7,
			'VAR' => 2,
			'PAR' => 4,
			"diff(" => 10
		},
		DEFAULT => -3,
		GOTOS => {
			'line' => 11,
			'assignment' => 3,
			'common' => 9
		}
	},
	{#State 2
		ACTIONS => {
			":=" => 12
		}
	},
	{#State 3
		ACTIONS => {
			";" => 14
		},
		DEFAULT => -5,
		GOTOS => {
			'OPTIONAL-2' => 13
		}
	},
	{#State 4
		ACTIONS => {
			'VAR' => 16
		},
		GOTOS => {
			'parameterlist' => 15
		}
	},
	{#State 5
		DEFAULT => -2
	},
	{#State 6
		DEFAULT => -8
	},
	{#State 7
		ACTIONS => {
			"(" => 17
		}
	},
	{#State 8
		ACTIONS => {
			'' => 18
		}
	},
	{#State 9
		DEFAULT => -10
	},
	{#State 10
		ACTIONS => {
			'VAR' => 19
		}
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		ACTIONS => {
			"(" => 32,
			"delay" => 31,
			'EULER' => 33,
			'UNIOP' => 27,
			'VAR' => 29,
			'INF' => 28,
			"-" => 30,
			'PI' => 22,
			'NUM' => 25,
			'NAN' => 24,
			'BINOP' => 20
		},
		GOTOS => {
			'equation' => 21,
			'expr' => 23,
			'constant' => 26
		}
	},
	{#State 13
		ACTIONS => {
			'COMMENT' => 34
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 35
		}
	},
	{#State 14
		DEFAULT => -4
	},
	{#State 15
		ACTIONS => {
			"," => 36
		},
		DEFAULT => -12
	},
	{#State 16
		ACTIONS => {
			"=" => 37
		}
	},
	{#State 17
		ACTIONS => {
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22,
			'BINOP' => 20,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			'INF' => 28,
			'VAR' => 38,
			"-" => 30,
			'UNIOP' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 23,
			'macroargpairlist' => 40,
			'equation' => 39
		}
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			"," => 41
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 42
		}
	},
	{#State 21
		ACTIONS => {
			'DESCRIPTION' => 43
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 44
		}
	},
	{#State 22
		DEFAULT => -42
	},
	{#State 23
		ACTIONS => {
			"-" => 45,
			"!" => 48,
			"+" => 46,
			"*" => 47,
			"/" => 50,
			"^" => 49
		},
		DEFAULT => -25
	},
	{#State 24
		DEFAULT => -41
	},
	{#State 25
		DEFAULT => -31
	},
	{#State 26
		DEFAULT => -32
	},
	{#State 27
		ACTIONS => {
			"(" => 51
		}
	},
	{#State 28
		DEFAULT => -44
	},
	{#State 29
		ACTIONS => {
			"(" => 52
		},
		DEFAULT => -40
	},
	{#State 30
		ACTIONS => {
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22,
			'BINOP' => 20,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			'INF' => 28,
			'VAR' => 29,
			"-" => 30,
			'UNIOP' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 53
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 54
		}
	},
	{#State 32
		ACTIONS => {
			"-" => 30,
			'VAR' => 29,
			'INF' => 28,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32,
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 55,
			'constant' => 26
		}
	},
	{#State 33
		DEFAULT => -43
	},
	{#State 34
		DEFAULT => -6
	},
	{#State 35
		DEFAULT => -9
	},
	{#State 36
		ACTIONS => {
			'VAR' => 16
		},
		GOTOS => {
			'parameterlist' => 56
		}
	},
	{#State 37
		ACTIONS => {
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 58,
			'PI' => 22,
			'VAR' => 29,
			'INF' => 28,
			"-" => 30,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 23,
			'equation' => 57
		}
	},
	{#State 38
		ACTIONS => {
			"(" => 52,
			"=" => 59
		},
		DEFAULT => -40
	},
	{#State 39
		DEFAULT => -48
	},
	{#State 40
		ACTIONS => {
			"," => 60,
			")" => 61
		}
	},
	{#State 41
		ACTIONS => {
			'VAR' => 62
		}
	},
	{#State 42
		ACTIONS => {
			'UNIOP' => 27,
			'INF' => 28,
			"-" => 30,
			'VAR' => 29,
			"(" => 32,
			"delay" => 31,
			'EULER' => 33,
			'BINOP' => 20,
			'PI' => 22,
			'NUM' => 25,
			'NAN' => 24
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 26
		}
	},
	{#State 43
		DEFAULT => -13
	},
	{#State 44
		DEFAULT => -19
	},
	{#State 45
		ACTIONS => {
			'EULER' => 33,
			"delay" => 31,
			"(" => 32,
			'INF' => 28,
			"-" => 30,
			'VAR' => 29,
			'UNIOP' => 27,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22,
			'BINOP' => 20
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 26
		}
	},
	{#State 46
		ACTIONS => {
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22,
			'INF' => 28,
			"-" => 30,
			'VAR' => 29,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32
		},
		GOTOS => {
			'expr' => 65,
			'constant' => 26
		}
	},
	{#State 47
		ACTIONS => {
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22,
			'BINOP' => 20,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			'VAR' => 29,
			"-" => 30,
			'INF' => 28,
			'UNIOP' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 66
		}
	},
	{#State 48
		DEFAULT => -33
	},
	{#State 49
		ACTIONS => {
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22,
			'BINOP' => 20,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			"-" => 30,
			'VAR' => 29,
			'INF' => 28,
			'UNIOP' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 67
		}
	},
	{#State 50
		ACTIONS => {
			'INF' => 28,
			"-" => 30,
			'VAR' => 29,
			'UNIOP' => 27,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			'BINOP' => 20,
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 68,
			'constant' => 26
		}
	},
	{#State 51
		ACTIONS => {
			"(" => 32,
			"delay" => 31,
			'EULER' => 33,
			'UNIOP' => 27,
			"-" => 30,
			'INF' => 28,
			'VAR' => 29,
			'PI' => 22,
			'NUM' => 25,
			'NAN' => 24,
			'BINOP' => 20
		},
		GOTOS => {
			'expr' => 69,
			'constant' => 26
		}
	},
	{#State 52
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 70
		}
	},
	{#State 53
		DEFAULT => -34
	},
	{#State 54
		ACTIONS => {
			'VAR' => 72
		}
	},
	{#State 55
		ACTIONS => {
			"^" => 49,
			"/" => 50,
			")" => 73,
			"-" => 45,
			"*" => 47,
			"!" => 48,
			"+" => 46
		}
	},
	{#State 56
		DEFAULT => -22
	},
	{#State 57
		DEFAULT => -24
	},
	{#State 58
		ACTIONS => {
			"^" => -31,
			"/" => -31,
			"!" => -31,
			"*" => -31,
			"+" => -31,
			"-" => -31
		},
		DEFAULT => -23
	},
	{#State 59
		ACTIONS => {
			'VAR' => 29,
			'INF' => 28,
			"-" => 30,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32,
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22
		},
		GOTOS => {
			'equation' => 74,
			'expr' => 23,
			'constant' => 26
		}
	},
	{#State 60
		ACTIONS => {
			'PI' => 22,
			'NUM' => 25,
			'NAN' => 24,
			'BINOP' => 20,
			"(" => 32,
			"delay" => 31,
			'EULER' => 33,
			'UNIOP' => 27,
			'VAR' => 38,
			"-" => 30,
			'INF' => 28
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 23,
			'equation' => 39,
			'macroargpairlist' => 75
		}
	},
	{#State 61
		DEFAULT => -11
	},
	{#State 62
		ACTIONS => {
			")=" => 77,
			"):=" => 76
		}
	},
	{#State 63
		ACTIONS => {
			"," => 78,
			"/" => 50,
			"^" => 49,
			"!" => 48,
			"+" => 46,
			"-" => 45,
			"*" => 47
		}
	},
	{#State 64
		ACTIONS => {
			"!" => 48,
			"^" => 49,
			"/" => 50,
			"*" => 47
		},
		DEFAULT => -27
	},
	{#State 65
		ACTIONS => {
			"*" => 47,
			"/" => 50,
			"^" => 49,
			"!" => 48
		},
		DEFAULT => -26
	},
	{#State 66
		ACTIONS => {
			"^" => 49,
			"!" => 48
		},
		DEFAULT => -28
	},
	{#State 67
		ACTIONS => {
			"^" => 49,
			"!" => 48
		},
		DEFAULT => -30
	},
	{#State 68
		ACTIONS => {
			"!" => 48,
			"^" => 49
		},
		DEFAULT => -29
	},
	{#State 69
		ACTIONS => {
			"!" => 48,
			"+" => 46,
			"-" => 45,
			"*" => 47,
			"/" => 50,
			"^" => 49,
			")" => 79
		}
	},
	{#State 70
		ACTIONS => {
			")" => 81,
			"," => 80
		}
	},
	{#State 71
		ACTIONS => {
			"=" => 82
		}
	},
	{#State 72
		ACTIONS => {
			"," => 83
		}
	},
	{#State 73
		DEFAULT => -35
	},
	{#State 74
		DEFAULT => -49
	},
	{#State 75
		DEFAULT => -47
	},
	{#State 76
		ACTIONS => {
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22,
			'INF' => 28,
			"-" => 30,
			'VAR' => 29,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32
		},
		GOTOS => {
			'constant' => 26,
			'equation' => 84,
			'expr' => 23
		}
	},
	{#State 77
		ACTIONS => {
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22,
			'BINOP' => 20,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32,
			'VAR' => 29,
			'INF' => 28,
			"-" => 30,
			'UNIOP' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 23,
			'equation' => 85
		}
	},
	{#State 78
		ACTIONS => {
			'INF' => 28,
			'VAR' => 29,
			"-" => 30,
			'UNIOP' => 27,
			'EULER' => 33,
			"(" => 32,
			"delay" => 31,
			'BINOP' => 20,
			'NUM' => 25,
			'NAN' => 24,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 86,
			'constant' => 26
		}
	},
	{#State 79
		DEFAULT => -36
	},
	{#State 80
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 87
		}
	},
	{#State 81
		DEFAULT => -39
	},
	{#State 82
		ACTIONS => {
			'VAR' => 29,
			"-" => 30,
			'INF' => 28,
			'UNIOP' => 27,
			'EULER' => 33,
			"delay" => 31,
			"(" => 32,
			'BINOP' => 20,
			'NAN' => 24,
			'NUM' => 25,
			'PI' => 22
		},
		GOTOS => {
			'constant' => 26,
			'equation' => 88,
			'expr' => 23
		}
	},
	{#State 83
		ACTIONS => {
			'VAR' => 89
		}
	},
	{#State 84
		ACTIONS => {
			'DESCRIPTION' => 90
		},
		DEFAULT => -18,
		GOTOS => {
			'OPTIONAL-6' => 91
		}
	},
	{#State 85
		ACTIONS => {
			'DESCRIPTION' => 93
		},
		DEFAULT => -16,
		GOTOS => {
			'OPTIONAL-5' => 92
		}
	},
	{#State 86
		ACTIONS => {
			"+" => 46,
			"!" => 48,
			"*" => 47,
			"-" => 45,
			")" => 94,
			"/" => 50,
			"^" => 49
		}
	},
	{#State 87
		DEFAULT => -45
	},
	{#State 88
		DEFAULT => -46
	},
	{#State 89
		ACTIONS => {
			")" => 95
		}
	},
	{#State 90
		DEFAULT => -17
	},
	{#State 91
		DEFAULT => -21
	},
	{#State 92
		DEFAULT => -20
	},
	{#State 93
		DEFAULT => -15
	},
	{#State 94
		DEFAULT => -37
	},
	{#State 95
		DEFAULT => -38
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1015 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1022 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1029 infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1033 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 44 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1040 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 44 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1047 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 44 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1054 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 44 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1061 infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1065 infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1069 infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1073 infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 50 "infix2pharmml_base.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1080 infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1084 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 65 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1091 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 65 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1098 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 66 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1105 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 66 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1112 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 68 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1119 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 68 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1126 infix2pharmml_model.pm
	],
	[#Rule common_19
		 'common', 4,
sub {
#line 65 "infix2pharmml_base.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1133 infix2pharmml_model.pm
	],
	[#Rule common_20
		 'common', 7,
sub {
#line 67 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1140 infix2pharmml_model.pm
	],
	[#Rule common_21
		 'common', 7,
sub {
#line 69 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1147 infix2pharmml_model.pm
	],
	[#Rule parameterlist_22
		 'parameterlist', 3,
sub {
#line 75 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1154 infix2pharmml_model.pm
	],
	[#Rule parameterlist_23
		 'parameterlist', 3,
sub {
#line 76 "infix2pharmml_base.eyp"
infix2pharmml::par_n($_[1],$_[3])}
#line 1161 infix2pharmml_model.pm
	],
	[#Rule parameterlist_24
		 'parameterlist', 3,
sub {
#line 77 "infix2pharmml_base.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1168 infix2pharmml_model.pm
	],
	[#Rule equation_25
		 'equation', 1,
sub {
#line 82 "infix2pharmml_base.eyp"
infix2pharmml::eqn($_[1])}
#line 1175 infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 86 "infix2pharmml_base.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1182 infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 87 "infix2pharmml_base.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1189 infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 88 "infix2pharmml_base.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1196 infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 89 "infix2pharmml_base.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1203 infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 90 "infix2pharmml_base.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1210 infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 1,
sub {
#line 91 "infix2pharmml_base.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1217 infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 1,
sub {
#line 92 "infix2pharmml_base.eyp"
infix2pharmml::const($_[1])}
#line 1224 infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 2,
sub {
#line 93 "infix2pharmml_base.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1231 infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 2,
sub {
#line 94 "infix2pharmml_base.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1238 infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 3,
sub {
#line 95 "infix2pharmml_base.eyp"
$_[2]}
#line 1245 infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 4,
sub {
#line 96 "infix2pharmml_base.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1252 infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 6,
sub {
#line 97 "infix2pharmml_base.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1259 infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 6,
sub {
#line 98 "infix2pharmml_base.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1266 infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 4,
sub {
#line 99 "infix2pharmml_base.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1273 infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 1,
sub {
#line 100 "infix2pharmml_base.eyp"
infix2pharmml::symbref($_[1])}
#line 1280 infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 108 "infix2pharmml_base.eyp"
"notanumber"}
#line 1287 infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 109 "infix2pharmml_base.eyp"
"pi"}
#line 1294 infix2pharmml_model.pm
	],
	[#Rule constant_43
		 'constant', 1,
sub {
#line 110 "infix2pharmml_base.eyp"
"exponentiale"}
#line 1301 infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 111 "infix2pharmml_base.eyp"
"infinity"}
#line 1308 infix2pharmml_model.pm
	],
	[#Rule argpairlist_45
		 'argpairlist', 3,
sub {
#line 115 "infix2pharmml_base.eyp"
 $_[1].$_[3] }
#line 1315 infix2pharmml_model.pm
	],
	[#Rule argpairlist_46
		 'argpairlist', 3,
sub {
#line 116 "infix2pharmml_base.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1322 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_47
		 'macroargpairlist', 3,
sub {
#line 126 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1329 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_48
		 'macroargpairlist', 1,
sub {
#line 127 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1336 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_49
		 'macroargpairlist', 3,
sub {
#line 128 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1343 infix2pharmml_model.pm
	]
],
#line 1346 infix2pharmml_model.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'model_3', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'line_8', 
         'line_9', 
         'assignment_10', 
         'assignment_11', 
         'assignment_12', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_19', 
         'common_20', 
         'common_21', 
         'parameterlist_22', 
         'parameterlist_23', 
         'parameterlist_24', 
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
         'argpairlist_46', 
         'macroargpairlist_47', 
         'macroargpairlist_48', 
         'macroargpairlist_49', );
  $self;
}

#line 133 "infix2pharmml_base.eyp"



=for None

=cut


#line 1422 infix2pharmml_model.pm



1;
