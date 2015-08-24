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

      m{\G(diff\(|delay|\)\:\=|\:\=|\)\=|\-|\;|\*|\(|\)|\+|\,|\=|\/|\!|\^)}gc and return ($1, $1);

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
  [ 'macroargpairlist_13' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_14' => 'macroargpairlist', [ 'expr' ], 0 ],
  [ 'macroargpairlist_15' => 'macroargpairlist', [ 'VAR', '=', 'expr' ], 0 ],
  [ 'parameterlist_16' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_17' => 'parameterlist', [ 'VAR', '=', 'NUM' ], 0 ],
  [ 'parameterlist_18' => 'parameterlist', [ 'VAR', '=', 'expr' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'common_25' => 'common', [ 'VAR', ':=', 'expr', 'OPTIONAL-4' ], 0 ],
  [ 'common_26' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'expr', 'OPTIONAL-5' ], 0 ],
  [ 'common_27' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'expr', 'OPTIONAL-6' ], 0 ],
  [ 'expr_28' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_32' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_33' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_34' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_35' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_36' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_37' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_39' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_40' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_41' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_42' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_43' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_44' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_45' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_46' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_47' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_48' => 'argpairlist', [ 'VAR', '=', 'expr' ], 0 ],
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
  'macroargpairlist_13' => 13,
  'macroargpairlist_14' => 14,
  'macroargpairlist_15' => 15,
  'parameterlist_16' => 16,
  'parameterlist_17' => 17,
  'parameterlist_18' => 18,
  '_OPTIONAL' => 19,
  '_OPTIONAL' => 20,
  '_OPTIONAL' => 21,
  '_OPTIONAL' => 22,
  '_OPTIONAL' => 23,
  '_OPTIONAL' => 24,
  'common_25' => 25,
  'common_26' => 26,
  'common_27' => 27,
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
  'expr_41' => 41,
  'expr_42' => 42,
  'constant_43' => 43,
  'constant_44' => 44,
  'constant_45' => 45,
  'constant_46' => 46,
  'argpairlist_47' => 47,
  'argpairlist_48' => 48,
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
			'COMMENT' => 5,
			"diff(" => 9,
			'VAR' => 4,
			'PAR' => 3,
			'MACRO' => 6
		},
		GOTOS => {
			'line' => 10,
			'assignment' => 8,
			'model' => 7,
			'PLUS-1' => 2,
			'common' => 1
		}
	},
	{#State 1
		DEFAULT => -10
	},
	{#State 2
		ACTIONS => {
			"diff(" => 9,
			'PAR' => 3,
			'VAR' => 4,
			'COMMENT' => 5,
			'MACRO' => 6
		},
		DEFAULT => -3,
		GOTOS => {
			'common' => 1,
			'line' => 11,
			'assignment' => 8
		}
	},
	{#State 3
		ACTIONS => {
			'VAR' => 13
		},
		GOTOS => {
			'parameterlist' => 12
		}
	},
	{#State 4
		ACTIONS => {
			":=" => 14
		}
	},
	{#State 5
		DEFAULT => -8
	},
	{#State 6
		ACTIONS => {
			"(" => 15
		}
	},
	{#State 7
		ACTIONS => {
			'' => 16
		}
	},
	{#State 8
		ACTIONS => {
			";" => 18
		},
		DEFAULT => -5,
		GOTOS => {
			'OPTIONAL-2' => 17
		}
	},
	{#State 9
		ACTIONS => {
			'VAR' => 19
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		ACTIONS => {
			"," => 20
		},
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			"=" => 21
		}
	},
	{#State 14
		ACTIONS => {
			'BINOP' => 31,
			'NUM' => 32,
			'UNIOP' => 30,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29,
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23,
			"-" => 26,
			'NAN' => 27
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 25
		}
	},
	{#State 15
		ACTIONS => {
			"-" => 26,
			'NAN' => 27,
			'EULER' => 22,
			"(" => 23,
			'VAR' => 36,
			'PI' => 28,
			'INF' => 29,
			'BINOP' => 31,
			'NUM' => 32,
			'UNIOP' => 30,
			"delay" => 33
		},
		GOTOS => {
			'macroargpairlist' => 35,
			'constant' => 34,
			'expr' => 37
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			'COMMENT' => 38
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 39
		}
	},
	{#State 18
		DEFAULT => -4
	},
	{#State 19
		ACTIONS => {
			"," => 40
		}
	},
	{#State 20
		ACTIONS => {
			'VAR' => 13
		},
		GOTOS => {
			'parameterlist' => 41
		}
	},
	{#State 21
		ACTIONS => {
			'BINOP' => 31,
			'NUM' => 42,
			'UNIOP' => 30,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29,
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23,
			"-" => 26,
			'NAN' => 27
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 34
		}
	},
	{#State 22
		DEFAULT => -45
	},
	{#State 23
		ACTIONS => {
			'NAN' => 27,
			"-" => 26,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'BINOP' => 31,
			'NUM' => 32,
			'UNIOP' => 30
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 34
		}
	},
	{#State 24
		ACTIONS => {
			"(" => 45
		},
		DEFAULT => -42
	},
	{#State 25
		ACTIONS => {
			'DESCRIPTION' => 51,
			"+" => 52,
			"^" => 53,
			"-" => 47,
			"!" => 48,
			"*" => 49,
			"/" => 50
		},
		DEFAULT => -20,
		GOTOS => {
			'OPTIONAL-4' => 46
		}
	},
	{#State 26
		ACTIONS => {
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'UNIOP' => 30,
			'BINOP' => 31,
			'NUM' => 32,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'NAN' => 27,
			"-" => 26
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 54
		}
	},
	{#State 27
		DEFAULT => -43
	},
	{#State 28
		DEFAULT => -44
	},
	{#State 29
		DEFAULT => -46
	},
	{#State 30
		ACTIONS => {
			"(" => 55
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 56
		}
	},
	{#State 32
		DEFAULT => -33
	},
	{#State 33
		ACTIONS => {
			"(" => 57
		}
	},
	{#State 34
		DEFAULT => -34
	},
	{#State 35
		ACTIONS => {
			")" => 58,
			"," => 59
		}
	},
	{#State 36
		ACTIONS => {
			"(" => 45,
			"=" => 60
		},
		DEFAULT => -42
	},
	{#State 37
		ACTIONS => {
			"+" => 52,
			"^" => 53,
			"!" => 48,
			"/" => 50,
			"*" => 49,
			"-" => 47
		},
		DEFAULT => -14
	},
	{#State 38
		DEFAULT => -6
	},
	{#State 39
		DEFAULT => -9
	},
	{#State 40
		ACTIONS => {
			'VAR' => 61
		}
	},
	{#State 41
		DEFAULT => -16
	},
	{#State 42
		ACTIONS => {
			"-" => -33,
			"*" => -33,
			"/" => -33,
			"!" => -33,
			"^" => -33,
			"+" => -33
		},
		DEFAULT => -17
	},
	{#State 43
		ACTIONS => {
			"-" => 47,
			"/" => 50,
			"*" => 49,
			"!" => 48,
			"^" => 53,
			"+" => 52
		},
		DEFAULT => -18
	},
	{#State 44
		ACTIONS => {
			"-" => 47,
			")" => 62,
			"/" => 50,
			"*" => 49,
			"^" => 53,
			"!" => 48,
			"+" => 52
		}
	},
	{#State 45
		ACTIONS => {
			'VAR' => 64
		},
		GOTOS => {
			'argpairlist' => 63
		}
	},
	{#State 46
		DEFAULT => -25
	},
	{#State 47
		ACTIONS => {
			'EULER' => 22,
			"(" => 23,
			'VAR' => 24,
			"-" => 26,
			'NAN' => 27,
			'PI' => 28,
			'INF' => 29,
			'BINOP' => 31,
			'UNIOP' => 30,
			'NUM' => 32,
			"delay" => 33
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 65
		}
	},
	{#State 48
		DEFAULT => -35
	},
	{#State 49
		ACTIONS => {
			"delay" => 33,
			'NUM' => 32,
			'BINOP' => 31,
			'UNIOP' => 30,
			'INF' => 29,
			'PI' => 28,
			'NAN' => 27,
			"-" => 26,
			'VAR' => 24,
			"(" => 23,
			'EULER' => 22
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 66
		}
	},
	{#State 50
		ACTIONS => {
			'NAN' => 27,
			"-" => 26,
			'VAR' => 24,
			"(" => 23,
			'EULER' => 22,
			"delay" => 33,
			'BINOP' => 31,
			'UNIOP' => 30,
			'NUM' => 32,
			'INF' => 29,
			'PI' => 28
		},
		GOTOS => {
			'expr' => 67,
			'constant' => 34
		}
	},
	{#State 51
		DEFAULT => -19
	},
	{#State 52
		ACTIONS => {
			'NAN' => 27,
			"-" => 26,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'NUM' => 32,
			'BINOP' => 31,
			'UNIOP' => 30
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 68
		}
	},
	{#State 53
		ACTIONS => {
			'NAN' => 27,
			"-" => 26,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'BINOP' => 31,
			'UNIOP' => 30,
			'NUM' => 32
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 69
		}
	},
	{#State 54
		DEFAULT => -36
	},
	{#State 55
		ACTIONS => {
			'NAN' => 27,
			"-" => 26,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'NUM' => 32,
			'BINOP' => 31,
			'UNIOP' => 30
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 70
		}
	},
	{#State 56
		ACTIONS => {
			'NUM' => 32,
			'BINOP' => 31,
			'UNIOP' => 30,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29,
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23,
			"-" => 26,
			'NAN' => 27
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 34
		}
	},
	{#State 57
		ACTIONS => {
			'VAR' => 72
		}
	},
	{#State 58
		DEFAULT => -11
	},
	{#State 59
		ACTIONS => {
			'UNIOP' => 30,
			'BINOP' => 31,
			'NUM' => 32,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29,
			"-" => 26,
			'NAN' => 27,
			'VAR' => 36,
			'EULER' => 22,
			"(" => 23
		},
		GOTOS => {
			'expr' => 37,
			'constant' => 34,
			'macroargpairlist' => 73
		}
	},
	{#State 60
		ACTIONS => {
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'NUM' => 32,
			'UNIOP' => 30,
			'BINOP' => 31,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24,
			'NAN' => 27,
			"-" => 26
		},
		GOTOS => {
			'expr' => 74,
			'constant' => 34
		}
	},
	{#State 61
		ACTIONS => {
			")=" => 75,
			"):=" => 76
		}
	},
	{#State 62
		DEFAULT => -37
	},
	{#State 63
		ACTIONS => {
			")" => 77,
			"," => 78
		}
	},
	{#State 64
		ACTIONS => {
			"=" => 79
		}
	},
	{#State 65
		ACTIONS => {
			"*" => 49,
			"^" => 53,
			"/" => 50,
			"!" => 48
		},
		DEFAULT => -29
	},
	{#State 66
		ACTIONS => {
			"!" => 48,
			"^" => 53
		},
		DEFAULT => -30
	},
	{#State 67
		ACTIONS => {
			"^" => 53,
			"!" => 48
		},
		DEFAULT => -31
	},
	{#State 68
		ACTIONS => {
			"*" => 49,
			"!" => 48,
			"/" => 50,
			"^" => 53
		},
		DEFAULT => -28
	},
	{#State 69
		ACTIONS => {
			"^" => 53,
			"!" => 48
		},
		DEFAULT => -32
	},
	{#State 70
		ACTIONS => {
			"-" => 47,
			")" => 80,
			"/" => 50,
			"^" => 53,
			"*" => 49,
			"!" => 48,
			"+" => 52
		}
	},
	{#State 71
		ACTIONS => {
			"*" => 49,
			"^" => 53,
			"/" => 50,
			"+" => 52,
			"!" => 48,
			"," => 81,
			"-" => 47
		}
	},
	{#State 72
		ACTIONS => {
			"," => 82
		}
	},
	{#State 73
		DEFAULT => -13
	},
	{#State 74
		ACTIONS => {
			"!" => 48,
			"*" => 49,
			"/" => 50,
			"-" => 47,
			"+" => 52,
			"^" => 53
		},
		DEFAULT => -15
	},
	{#State 75
		ACTIONS => {
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23,
			"-" => 26,
			'NAN' => 27,
			'UNIOP' => 30,
			'NUM' => 32,
			'BINOP' => 31,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29
		},
		GOTOS => {
			'expr' => 83,
			'constant' => 34
		}
	},
	{#State 76
		ACTIONS => {
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23,
			"-" => 26,
			'NAN' => 27,
			'UNIOP' => 30,
			'NUM' => 32,
			'BINOP' => 31,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29
		},
		GOTOS => {
			'expr' => 84,
			'constant' => 34
		}
	},
	{#State 77
		DEFAULT => -41
	},
	{#State 78
		ACTIONS => {
			'VAR' => 64
		},
		GOTOS => {
			'argpairlist' => 85
		}
	},
	{#State 79
		ACTIONS => {
			'UNIOP' => 30,
			'NUM' => 32,
			'BINOP' => 31,
			"delay" => 33,
			'PI' => 28,
			'INF' => 29,
			"-" => 26,
			'NAN' => 27,
			'VAR' => 24,
			'EULER' => 22,
			"(" => 23
		},
		GOTOS => {
			'expr' => 86,
			'constant' => 34
		}
	},
	{#State 80
		DEFAULT => -38
	},
	{#State 81
		ACTIONS => {
			'INF' => 29,
			'PI' => 28,
			"delay" => 33,
			'UNIOP' => 30,
			'BINOP' => 31,
			'NUM' => 32,
			'NAN' => 27,
			"-" => 26,
			"(" => 23,
			'EULER' => 22,
			'VAR' => 24
		},
		GOTOS => {
			'expr' => 87,
			'constant' => 34
		}
	},
	{#State 82
		ACTIONS => {
			'VAR' => 88
		}
	},
	{#State 83
		ACTIONS => {
			"!" => 48,
			"/" => 50,
			"*" => 49,
			"-" => 47,
			"+" => 52,
			"^" => 53,
			'DESCRIPTION' => 89
		},
		DEFAULT => -22,
		GOTOS => {
			'OPTIONAL-5' => 90
		}
	},
	{#State 84
		ACTIONS => {
			"!" => 48,
			"*" => 49,
			"/" => 50,
			"-" => 47,
			"+" => 52,
			"^" => 53,
			'DESCRIPTION' => 92
		},
		DEFAULT => -24,
		GOTOS => {
			'OPTIONAL-6' => 91
		}
	},
	{#State 85
		DEFAULT => -47
	},
	{#State 86
		ACTIONS => {
			"-" => 47,
			"!" => 48,
			"*" => 49,
			"/" => 50,
			"+" => 52,
			"^" => 53
		},
		DEFAULT => -48
	},
	{#State 87
		ACTIONS => {
			")" => 93,
			"-" => 47,
			"+" => 52,
			"!" => 48,
			"*" => 49,
			"^" => 53,
			"/" => 50
		}
	},
	{#State 88
		ACTIONS => {
			")" => 94
		}
	},
	{#State 89
		DEFAULT => -21
	},
	{#State 90
		DEFAULT => -26
	},
	{#State 91
		DEFAULT => -27
	},
	{#State 92
		DEFAULT => -23
	},
	{#State 93
		DEFAULT => -39
	},
	{#State 94
		DEFAULT => -40
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1044 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1051 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1058 infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1062 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1069 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1076 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1083 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1090 infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1094 infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1098 infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1102 infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 52 "infix2pharmml_base.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1109 infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1113 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_13
		 'macroargpairlist', 3,
sub {
#line 58 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1120 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_14
		 'macroargpairlist', 1,
sub {
#line 59 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1127 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_15
		 'macroargpairlist', 3,
sub {
#line 60 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1134 infix2pharmml_model.pm
	],
	[#Rule parameterlist_16
		 'parameterlist', 3,
sub {
#line 66 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1141 infix2pharmml_model.pm
	],
	[#Rule parameterlist_17
		 'parameterlist', 3,
sub {
#line 67 "infix2pharmml_base.eyp"
infix2pharmml::par_n($_[1],$_[3])}
#line 1148 infix2pharmml_model.pm
	],
	[#Rule parameterlist_18
		 'parameterlist', 3,
sub {
#line 68 "infix2pharmml_base.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1155 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1162 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1169 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1176 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1183 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1190 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1197 infix2pharmml_model.pm
	],
	[#Rule common_25
		 'common', 4,
sub {
#line 93 "infix2pharmml_base.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1204 infix2pharmml_model.pm
	],
	[#Rule common_26
		 'common', 7,
sub {
#line 95 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1211 infix2pharmml_model.pm
	],
	[#Rule common_27
		 'common', 7,
sub {
#line 97 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1218 infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 105 "infix2pharmml_base.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1225 infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 106 "infix2pharmml_base.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1232 infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 107 "infix2pharmml_base.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1239 infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 3,
sub {
#line 108 "infix2pharmml_base.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1246 infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 3,
sub {
#line 109 "infix2pharmml_base.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1253 infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 1,
sub {
#line 110 "infix2pharmml_base.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1260 infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 1,
sub {
#line 111 "infix2pharmml_base.eyp"
infix2pharmml::const($_[1])}
#line 1267 infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 2,
sub {
#line 112 "infix2pharmml_base.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1274 infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 2,
sub {
#line 113 "infix2pharmml_base.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1281 infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 3,
sub {
#line 114 "infix2pharmml_base.eyp"
$_[2]}
#line 1288 infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 4,
sub {
#line 115 "infix2pharmml_base.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1295 infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 6,
sub {
#line 116 "infix2pharmml_base.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1302 infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 6,
sub {
#line 117 "infix2pharmml_base.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 1309 infix2pharmml_model.pm
	],
	[#Rule expr_41
		 'expr', 4,
sub {
#line 118 "infix2pharmml_base.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1316 infix2pharmml_model.pm
	],
	[#Rule expr_42
		 'expr', 1,
sub {
#line 119 "infix2pharmml_base.eyp"
infix2pharmml::symbref($_[1])}
#line 1323 infix2pharmml_model.pm
	],
	[#Rule constant_43
		 'constant', 1,
sub {
#line 127 "infix2pharmml_base.eyp"
"notanumber"}
#line 1330 infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 128 "infix2pharmml_base.eyp"
"pi"}
#line 1337 infix2pharmml_model.pm
	],
	[#Rule constant_45
		 'constant', 1,
sub {
#line 129 "infix2pharmml_base.eyp"
"exponentiale"}
#line 1344 infix2pharmml_model.pm
	],
	[#Rule constant_46
		 'constant', 1,
sub {
#line 130 "infix2pharmml_base.eyp"
"infinity"}
#line 1351 infix2pharmml_model.pm
	],
	[#Rule argpairlist_47
		 'argpairlist', 3,
sub {
#line 134 "infix2pharmml_base.eyp"
 $_[1].$_[3] }
#line 1358 infix2pharmml_model.pm
	],
	[#Rule argpairlist_48
		 'argpairlist', 3,
sub {
#line 135 "infix2pharmml_base.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1365 infix2pharmml_model.pm
	]
],
#line 1368 infix2pharmml_model.pm
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
         'macroargpairlist_13', 
         'macroargpairlist_14', 
         'macroargpairlist_15', 
         'parameterlist_16', 
         'parameterlist_17', 
         'parameterlist_18', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_25', 
         'common_26', 
         'common_27', 
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
         'expr_41', 
         'expr_42', 
         'constant_43', 
         'constant_44', 
         'constant_45', 
         'constant_46', 
         'argpairlist_47', 
         'argpairlist_48', );
  $self;
}

#line 142 "infix2pharmml_base.eyp"



=for None

=cut


#line 1443 infix2pharmml_model.pm



1;
