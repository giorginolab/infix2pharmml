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

      m{\G(diff\(|delay|\)\:\=|\)\=|\:\=|\=|\;|\*|\)|\!|\-|\/|\(|\+|\,|\^)}gc and return ($1, $1);

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
  [ 'macroargpairlist_14' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_15' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parameterlist_16' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_17' => 'parameterlist', [ 'VAR', '=', 'NUM' ], 0 ],
  [ 'parameterlist_18' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'common_25' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'common_26' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'common_27' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-6' ], 0 ],
  [ 'equation_28' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_30' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_31' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_32' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_33' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_34' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_35' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_36' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_37' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_38' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_39' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_40' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_41' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_42' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_43' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_44' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_45' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_46' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_47' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_48' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_49' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  'equation_28' => 28,
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
  'expr_43' => 43,
  'constant_44' => 44,
  'constant_45' => 45,
  'constant_46' => 46,
  'constant_47' => 47,
  'argpairlist_48' => 48,
  'argpairlist_49' => 49,
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
			'COMMENT' => 7,
			'VAR' => 9,
			'MACRO' => 4,
			'PAR' => 3,
			"diff(" => 8
		},
		GOTOS => {
			'PLUS-1' => 2,
			'line' => 6,
			'assignment' => 1,
			'common' => 5,
			'model' => 10
		}
	},
	{#State 1
		ACTIONS => {
			";" => 11
		},
		DEFAULT => -5,
		GOTOS => {
			'OPTIONAL-2' => 12
		}
	},
	{#State 2
		ACTIONS => {
			'COMMENT' => 7,
			'PAR' => 3,
			"diff(" => 8,
			'VAR' => 9,
			'MACRO' => 4
		},
		DEFAULT => -3,
		GOTOS => {
			'common' => 5,
			'assignment' => 1,
			'line' => 13
		}
	},
	{#State 3
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 14
		}
	},
	{#State 4
		ACTIONS => {
			"(" => 16
		}
	},
	{#State 5
		DEFAULT => -10
	},
	{#State 6
		DEFAULT => -2
	},
	{#State 7
		DEFAULT => -8
	},
	{#State 8
		ACTIONS => {
			'VAR' => 17
		}
	},
	{#State 9
		ACTIONS => {
			":=" => 18
		}
	},
	{#State 10
		ACTIONS => {
			'' => 19
		}
	},
	{#State 11
		DEFAULT => -4
	},
	{#State 12
		ACTIONS => {
			'COMMENT' => 21
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 20
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"," => 22
		},
		DEFAULT => -12
	},
	{#State 15
		ACTIONS => {
			"=" => 23
		}
	},
	{#State 16
		ACTIONS => {
			'PI' => 33,
			'INF' => 36,
			"delay" => 35,
			'UNIOP' => 31,
			"-" => 32,
			"(" => 29,
			'NUM' => 30,
			'EULER' => 27,
			'VAR' => 26,
			'NAN' => 25,
			'BINOP' => 24
		},
		GOTOS => {
			'macroargpairlist' => 38,
			'equation' => 28,
			'expr' => 37,
			'constant' => 34
		}
	},
	{#State 17
		ACTIONS => {
			"," => 39
		}
	},
	{#State 18
		ACTIONS => {
			'NAN' => 25,
			'BINOP' => 24,
			'EULER' => 27,
			'VAR' => 41,
			"(" => 29,
			'NUM' => 30,
			"-" => 32,
			'UNIOP' => 31,
			"delay" => 35,
			'INF' => 36,
			'PI' => 33
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 37,
			'equation' => 40
		}
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -9
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 42
		}
	},
	{#State 23
		ACTIONS => {
			'UNIOP' => 31,
			"-" => 32,
			"(" => 29,
			'NUM' => 43,
			'EULER' => 27,
			'VAR' => 41,
			'BINOP' => 24,
			'NAN' => 25,
			'PI' => 33,
			'INF' => 36,
			"delay" => 35
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 37,
			'equation' => 44
		}
	},
	{#State 24
		ACTIONS => {
			"(" => 45
		}
	},
	{#State 25
		DEFAULT => -44
	},
	{#State 26
		ACTIONS => {
			"=" => 47,
			"(" => 46
		},
		DEFAULT => -43
	},
	{#State 27
		DEFAULT => -46
	},
	{#State 28
		DEFAULT => -14
	},
	{#State 29
		ACTIONS => {
			'INF' => 36,
			"delay" => 35,
			'PI' => 33,
			'EULER' => 27,
			'VAR' => 41,
			'BINOP' => 24,
			'NAN' => 25,
			"-" => 32,
			'UNIOP' => 31,
			"(" => 29,
			'NUM' => 30
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 48
		}
	},
	{#State 30
		DEFAULT => -34
	},
	{#State 31
		ACTIONS => {
			"(" => 49
		}
	},
	{#State 32
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 27,
			'BINOP' => 24,
			'NAN' => 25,
			'UNIOP' => 31,
			"-" => 32,
			'NUM' => 30,
			"(" => 29,
			'PI' => 33,
			'INF' => 36,
			"delay" => 35
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 50
		}
	},
	{#State 33
		DEFAULT => -45
	},
	{#State 34
		DEFAULT => -35
	},
	{#State 35
		ACTIONS => {
			"(" => 51
		}
	},
	{#State 36
		DEFAULT => -47
	},
	{#State 37
		ACTIONS => {
			"-" => 57,
			"!" => 56,
			"/" => 55,
			"^" => 53,
			"+" => 54,
			"*" => 52
		},
		DEFAULT => -28
	},
	{#State 38
		ACTIONS => {
			"," => 59,
			")" => 58
		}
	},
	{#State 39
		ACTIONS => {
			'VAR' => 60
		}
	},
	{#State 40
		ACTIONS => {
			'DESCRIPTION' => 61
		},
		DEFAULT => -20,
		GOTOS => {
			'OPTIONAL-4' => 62
		}
	},
	{#State 41
		ACTIONS => {
			"(" => 46
		},
		DEFAULT => -43
	},
	{#State 42
		DEFAULT => -16
	},
	{#State 43
		ACTIONS => {
			"-" => -34,
			"!" => -34,
			"/" => -34,
			"+" => -34,
			"^" => -34,
			"*" => -34
		},
		DEFAULT => -17
	},
	{#State 44
		DEFAULT => -18
	},
	{#State 45
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 27,
			'NAN' => 25,
			'BINOP' => 24,
			'UNIOP' => 31,
			"-" => 32,
			'NUM' => 30,
			"(" => 29,
			'PI' => 33,
			'INF' => 36,
			"delay" => 35
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 34
		}
	},
	{#State 46
		ACTIONS => {
			'VAR' => 65
		},
		GOTOS => {
			'argpairlist' => 64
		}
	},
	{#State 47
		ACTIONS => {
			'PI' => 33,
			'INF' => 36,
			"delay" => 35,
			'UNIOP' => 31,
			"-" => 32,
			'NUM' => 30,
			"(" => 29,
			'VAR' => 41,
			'EULER' => 27,
			'NAN' => 25,
			'BINOP' => 24
		},
		GOTOS => {
			'equation' => 66,
			'expr' => 37,
			'constant' => 34
		}
	},
	{#State 48
		ACTIONS => {
			"*" => 52,
			"-" => 57,
			"!" => 56,
			"^" => 53,
			"/" => 55,
			")" => 67,
			"+" => 54
		}
	},
	{#State 49
		ACTIONS => {
			'PI' => 33,
			"delay" => 35,
			'INF' => 36,
			'BINOP' => 24,
			'NAN' => 25,
			'EULER' => 27,
			'VAR' => 41,
			"(" => 29,
			'NUM' => 30,
			"-" => 32,
			'UNIOP' => 31
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 68
		}
	},
	{#State 50
		DEFAULT => -37
	},
	{#State 51
		ACTIONS => {
			'VAR' => 69
		}
	},
	{#State 52
		ACTIONS => {
			'PI' => 33,
			"delay" => 35,
			'INF' => 36,
			"(" => 29,
			'NUM' => 30,
			"-" => 32,
			'UNIOP' => 31,
			'BINOP' => 24,
			'NAN' => 25,
			'EULER' => 27,
			'VAR' => 41
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 70
		}
	},
	{#State 53
		ACTIONS => {
			'INF' => 36,
			"delay" => 35,
			'PI' => 33,
			'UNIOP' => 31,
			"-" => 32,
			'NUM' => 30,
			"(" => 29,
			'EULER' => 27,
			'VAR' => 41,
			'NAN' => 25,
			'BINOP' => 24
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 34
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 32,
			'UNIOP' => 31,
			"(" => 29,
			'NUM' => 30,
			'VAR' => 41,
			'EULER' => 27,
			'NAN' => 25,
			'BINOP' => 24,
			'PI' => 33,
			'INF' => 36,
			"delay" => 35
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 72
		}
	},
	{#State 55
		ACTIONS => {
			'INF' => 36,
			"delay" => 35,
			'PI' => 33,
			'EULER' => 27,
			'VAR' => 41,
			'BINOP' => 24,
			'NAN' => 25,
			'UNIOP' => 31,
			"-" => 32,
			"(" => 29,
			'NUM' => 30
		},
		GOTOS => {
			'expr' => 73,
			'constant' => 34
		}
	},
	{#State 56
		DEFAULT => -36
	},
	{#State 57
		ACTIONS => {
			'PI' => 33,
			"delay" => 35,
			'INF' => 36,
			"(" => 29,
			'NUM' => 30,
			'UNIOP' => 31,
			"-" => 32,
			'BINOP' => 24,
			'NAN' => 25,
			'VAR' => 41,
			'EULER' => 27
		},
		GOTOS => {
			'expr' => 74,
			'constant' => 34
		}
	},
	{#State 58
		DEFAULT => -11
	},
	{#State 59
		ACTIONS => {
			"delay" => 35,
			'INF' => 36,
			'PI' => 33,
			"(" => 29,
			'NUM' => 30,
			'UNIOP' => 31,
			"-" => 32,
			'BINOP' => 24,
			'NAN' => 25,
			'EULER' => 27,
			'VAR' => 26
		},
		GOTOS => {
			'macroargpairlist' => 75,
			'expr' => 37,
			'equation' => 28,
			'constant' => 34
		}
	},
	{#State 60
		ACTIONS => {
			"):=" => 77,
			")=" => 76
		}
	},
	{#State 61
		DEFAULT => -19
	},
	{#State 62
		DEFAULT => -25
	},
	{#State 63
		ACTIONS => {
			"*" => 52,
			"-" => 57,
			"!" => 56,
			"^" => 53,
			"/" => 55,
			"," => 78,
			"+" => 54
		}
	},
	{#State 64
		ACTIONS => {
			"," => 79,
			")" => 80
		}
	},
	{#State 65
		ACTIONS => {
			"=" => 81
		}
	},
	{#State 66
		DEFAULT => -15
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			"+" => 54,
			")" => 82,
			"*" => 52,
			"^" => 53,
			"-" => 57,
			"!" => 56,
			"/" => 55
		}
	},
	{#State 69
		ACTIONS => {
			"," => 83
		}
	},
	{#State 70
		ACTIONS => {
			"^" => 53,
			"!" => 56
		},
		DEFAULT => -31
	},
	{#State 71
		ACTIONS => {
			"^" => 53,
			"!" => 56
		},
		DEFAULT => -33
	},
	{#State 72
		ACTIONS => {
			"*" => 52,
			"^" => 53,
			"/" => 55,
			"!" => 56
		},
		DEFAULT => -29
	},
	{#State 73
		ACTIONS => {
			"^" => 53,
			"!" => 56
		},
		DEFAULT => -32
	},
	{#State 74
		ACTIONS => {
			"*" => 52,
			"/" => 55,
			"!" => 56,
			"^" => 53
		},
		DEFAULT => -30
	},
	{#State 75
		DEFAULT => -13
	},
	{#State 76
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 27,
			'BINOP' => 24,
			'NAN' => 25,
			'UNIOP' => 31,
			"-" => 32,
			"(" => 29,
			'NUM' => 30,
			'INF' => 36,
			"delay" => 35,
			'PI' => 33
		},
		GOTOS => {
			'constant' => 34,
			'equation' => 84,
			'expr' => 37
		}
	},
	{#State 77
		ACTIONS => {
			'INF' => 36,
			"delay" => 35,
			'PI' => 33,
			'UNIOP' => 31,
			"-" => 32,
			'NUM' => 30,
			"(" => 29,
			'VAR' => 41,
			'EULER' => 27,
			'NAN' => 25,
			'BINOP' => 24
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 37,
			'equation' => 85
		}
	},
	{#State 78
		ACTIONS => {
			"(" => 29,
			'NUM' => 30,
			'UNIOP' => 31,
			"-" => 32,
			'BINOP' => 24,
			'NAN' => 25,
			'EULER' => 27,
			'VAR' => 41,
			'PI' => 33,
			"delay" => 35,
			'INF' => 36
		},
		GOTOS => {
			'expr' => 86,
			'constant' => 34
		}
	},
	{#State 79
		ACTIONS => {
			'VAR' => 65
		},
		GOTOS => {
			'argpairlist' => 87
		}
	},
	{#State 80
		DEFAULT => -42
	},
	{#State 81
		ACTIONS => {
			'INF' => 36,
			"delay" => 35,
			'PI' => 33,
			'EULER' => 27,
			'VAR' => 41,
			'NAN' => 25,
			'BINOP' => 24,
			"-" => 32,
			'UNIOP' => 31,
			'NUM' => 30,
			"(" => 29
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 37,
			'equation' => 88
		}
	},
	{#State 82
		DEFAULT => -39
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
		DEFAULT => -22,
		GOTOS => {
			'OPTIONAL-5' => 91
		}
	},
	{#State 85
		ACTIONS => {
			'DESCRIPTION' => 93
		},
		DEFAULT => -24,
		GOTOS => {
			'OPTIONAL-6' => 92
		}
	},
	{#State 86
		ACTIONS => {
			")" => 94,
			"+" => 54,
			"*" => 52,
			"-" => 57,
			"^" => 53,
			"/" => 55,
			"!" => 56
		}
	},
	{#State 87
		DEFAULT => -48
	},
	{#State 88
		DEFAULT => -49
	},
	{#State 89
		ACTIONS => {
			")" => 95
		}
	},
	{#State 90
		DEFAULT => -21
	},
	{#State 91
		DEFAULT => -26
	},
	{#State 92
		DEFAULT => -27
	},
	{#State 93
		DEFAULT => -23
	},
	{#State 94
		DEFAULT => -40
	},
	{#State 95
		DEFAULT => -41
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
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1040 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1047 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1054 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
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
#line 52 "infix2pharmml_base.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1080 infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1084 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_13
		 'macroargpairlist', 3,
sub {
#line 58 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1091 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_14
		 'macroargpairlist', 1,
sub {
#line 59 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1098 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_15
		 'macroargpairlist', 3,
sub {
#line 60 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1105 infix2pharmml_model.pm
	],
	[#Rule parameterlist_16
		 'parameterlist', 3,
sub {
#line 66 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1112 infix2pharmml_model.pm
	],
	[#Rule parameterlist_17
		 'parameterlist', 3,
sub {
#line 67 "infix2pharmml_base.eyp"
infix2pharmml::par_n($_[1],$_[3])}
#line 1119 infix2pharmml_model.pm
	],
	[#Rule parameterlist_18
		 'parameterlist', 3,
sub {
#line 68 "infix2pharmml_base.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1126 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1133 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1140 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1147 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1154 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1161 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1168 infix2pharmml_model.pm
	],
	[#Rule common_25
		 'common', 4,
sub {
#line 93 "infix2pharmml_base.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1175 infix2pharmml_model.pm
	],
	[#Rule common_26
		 'common', 7,
sub {
#line 95 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1182 infix2pharmml_model.pm
	],
	[#Rule common_27
		 'common', 7,
sub {
#line 97 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1189 infix2pharmml_model.pm
	],
	[#Rule equation_28
		 'equation', 1,
sub {
#line 102 "infix2pharmml_base.eyp"
infix2pharmml::eqn($_[1])}
#line 1196 infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 106 "infix2pharmml_base.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1203 infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 107 "infix2pharmml_base.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1210 infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 3,
sub {
#line 108 "infix2pharmml_base.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1217 infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 3,
sub {
#line 109 "infix2pharmml_base.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1224 infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 3,
sub {
#line 110 "infix2pharmml_base.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1231 infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 1,
sub {
#line 111 "infix2pharmml_base.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1238 infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 1,
sub {
#line 112 "infix2pharmml_base.eyp"
infix2pharmml::const($_[1])}
#line 1245 infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 2,
sub {
#line 113 "infix2pharmml_base.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1252 infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 2,
sub {
#line 114 "infix2pharmml_base.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1259 infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 3,
sub {
#line 115 "infix2pharmml_base.eyp"
$_[2]}
#line 1266 infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 4,
sub {
#line 116 "infix2pharmml_base.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1273 infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 6,
sub {
#line 117 "infix2pharmml_base.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1280 infix2pharmml_model.pm
	],
	[#Rule expr_41
		 'expr', 6,
sub {
#line 118 "infix2pharmml_base.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 1287 infix2pharmml_model.pm
	],
	[#Rule expr_42
		 'expr', 4,
sub {
#line 119 "infix2pharmml_base.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1294 infix2pharmml_model.pm
	],
	[#Rule expr_43
		 'expr', 1,
sub {
#line 120 "infix2pharmml_base.eyp"
infix2pharmml::symbref($_[1])}
#line 1301 infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 128 "infix2pharmml_base.eyp"
"notanumber"}
#line 1308 infix2pharmml_model.pm
	],
	[#Rule constant_45
		 'constant', 1,
sub {
#line 129 "infix2pharmml_base.eyp"
"pi"}
#line 1315 infix2pharmml_model.pm
	],
	[#Rule constant_46
		 'constant', 1,
sub {
#line 130 "infix2pharmml_base.eyp"
"exponentiale"}
#line 1322 infix2pharmml_model.pm
	],
	[#Rule constant_47
		 'constant', 1,
sub {
#line 131 "infix2pharmml_base.eyp"
"infinity"}
#line 1329 infix2pharmml_model.pm
	],
	[#Rule argpairlist_48
		 'argpairlist', 3,
sub {
#line 135 "infix2pharmml_base.eyp"
 $_[1].$_[3] }
#line 1336 infix2pharmml_model.pm
	],
	[#Rule argpairlist_49
		 'argpairlist', 3,
sub {
#line 136 "infix2pharmml_base.eyp"
infix2pharmml::fa($_[1],$_[3]) }
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
         'equation_28', 
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
         'expr_43', 
         'constant_44', 
         'constant_45', 
         'constant_46', 
         'constant_47', 
         'argpairlist_48', 
         'argpairlist_49', );
  $self;
}

#line 143 "infix2pharmml_base.eyp"



=for None

=cut


#line 1422 infix2pharmml_model.pm



1;
