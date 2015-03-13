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

      m{\G(delay|diff\(|\)\:\=|\:\=|\)\=|\)|\=|\!|\-|\/|\*|\+|\(|\,|\;|\^)}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt|heaviside|sign)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G\b(par)\b/gc and return ('PAR', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
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


#line 73 ./infix2pharmml_model.pm

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
  [ 'expr_34' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_35' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_36' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_39' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_40' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_41' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_42' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_43' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_44' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_45' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_46' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_47' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_48' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_49' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_50' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  'expr_41' => 41,
  'constant_42' => 42,
  'constant_43' => 43,
  'constant_44' => 44,
  'constant_45' => 45,
  'argpairlist_46' => 46,
  'argpairlist_47' => 47,
  'macroargpairlist_48' => 48,
  'macroargpairlist_49' => 49,
  'macroargpairlist_50' => 50,
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
    yyFILENAME  => 'infix2pharmml_model.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'COMMENT' => 10,
			'PAR' => 5,
			'VAR' => 9,
			'MACRO' => 3,
			"diff(" => 2
		},
		GOTOS => {
			'PLUS-1' => 1,
			'line' => 8,
			'model' => 4,
			'common' => 6,
			'assignment' => 7
		}
	},
	{#State 1
		ACTIONS => {
			"diff(" => 2,
			'MACRO' => 3,
			'PAR' => 5,
			'VAR' => 9,
			'COMMENT' => 10
		},
		DEFAULT => -3,
		GOTOS => {
			'assignment' => 7,
			'common' => 6,
			'line' => 11
		}
	},
	{#State 2
		ACTIONS => {
			'VAR' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"(" => 13
		}
	},
	{#State 4
		ACTIONS => {
			'' => 14
		}
	},
	{#State 5
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 16
		}
	},
	{#State 6
		DEFAULT => -10
	},
	{#State 7
		ACTIONS => {
			";" => 18
		},
		DEFAULT => -5,
		GOTOS => {
			'OPTIONAL-2' => 17
		}
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			":=" => 19
		}
	},
	{#State 10
		DEFAULT => -8
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		ACTIONS => {
			"," => 20
		}
	},
	{#State 13
		ACTIONS => {
			"delay" => 27,
			"+" => 32,
			'NAN' => 31,
			"(" => 33,
			'BINOP' => 26,
			'NUM' => 36,
			"-" => 28,
			'VAR' => 29,
			'PI' => 30,
			'EULER' => 24,
			'INF' => 25,
			'UNIOP' => 22
		},
		GOTOS => {
			'macroargpairlist' => 21,
			'constant' => 34,
			'expr' => 35,
			'equation' => 23
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		ACTIONS => {
			"=" => 37
		}
	},
	{#State 16
		ACTIONS => {
			"," => 38
		},
		DEFAULT => -12
	},
	{#State 17
		ACTIONS => {
			'COMMENT' => 40
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
			"-" => 28,
			'NUM' => 36,
			"(" => 33,
			'NAN' => 31,
			"delay" => 27,
			"+" => 32,
			'BINOP' => 26,
			'PI' => 30,
			'EULER' => 24,
			'INF' => 25,
			'UNIOP' => 22,
			'VAR' => 41
		},
		GOTOS => {
			'equation' => 42,
			'expr' => 35,
			'constant' => 34
		}
	},
	{#State 20
		ACTIONS => {
			'VAR' => 43
		}
	},
	{#State 21
		ACTIONS => {
			")" => 45,
			"," => 44
		}
	},
	{#State 22
		ACTIONS => {
			"(" => 46
		}
	},
	{#State 23
		DEFAULT => -49
	},
	{#State 24
		DEFAULT => -44
	},
	{#State 25
		DEFAULT => -45
	},
	{#State 26
		ACTIONS => {
			"(" => 47
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 48
		}
	},
	{#State 28
		ACTIONS => {
			'UNIOP' => 22,
			'EULER' => 24,
			'PI' => 30,
			'INF' => 25,
			'VAR' => 41,
			"-" => 28,
			'NUM' => 36,
			'BINOP' => 26,
			"(" => 33,
			"+" => 32,
			"delay" => 27,
			'NAN' => 31
		},
		GOTOS => {
			'expr' => 49,
			'constant' => 34
		}
	},
	{#State 29
		ACTIONS => {
			"(" => 50,
			"=" => 51
		},
		DEFAULT => -41
	},
	{#State 30
		DEFAULT => -43
	},
	{#State 31
		DEFAULT => -42
	},
	{#State 32
		ACTIONS => {
			'UNIOP' => 22,
			'EULER' => 24,
			'INF' => 25,
			'PI' => 30,
			'VAR' => 41,
			"-" => 28,
			'NUM' => 36,
			'BINOP' => 26,
			"(" => 33,
			'NAN' => 31,
			"delay" => 27,
			"+" => 32
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 52
		}
	},
	{#State 33
		ACTIONS => {
			'UNIOP' => 22,
			'INF' => 25,
			'EULER' => 24,
			'PI' => 30,
			'VAR' => 41,
			'NUM' => 36,
			"-" => 28,
			'BINOP' => 26,
			"+" => 32,
			"delay" => 27,
			'NAN' => 31,
			"(" => 33
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 53
		}
	},
	{#State 34
		DEFAULT => -32
	},
	{#State 35
		ACTIONS => {
			"!" => 57,
			"-" => 56,
			"/" => 54,
			"*" => 55,
			"+" => 59,
			"^" => 58
		},
		DEFAULT => -25
	},
	{#State 36
		DEFAULT => -31
	},
	{#State 37
		ACTIONS => {
			'BINOP' => 26,
			'NAN' => 31,
			"delay" => 27,
			"+" => 32,
			"(" => 33,
			'NUM' => 60,
			"-" => 28,
			'VAR' => 41,
			'UNIOP' => 22,
			'EULER' => 24,
			'INF' => 25,
			'PI' => 30
		},
		GOTOS => {
			'expr' => 35,
			'equation' => 61,
			'constant' => 34
		}
	},
	{#State 38
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 62
		}
	},
	{#State 39
		DEFAULT => -9
	},
	{#State 40
		DEFAULT => -6
	},
	{#State 41
		ACTIONS => {
			"(" => 50
		},
		DEFAULT => -41
	},
	{#State 42
		ACTIONS => {
			'DESCRIPTION' => 64
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 63
		}
	},
	{#State 43
		ACTIONS => {
			"):=" => 65,
			")=" => 66
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 28,
			'NUM' => 36,
			"+" => 32,
			"delay" => 27,
			'NAN' => 31,
			"(" => 33,
			'BINOP' => 26,
			'PI' => 30,
			'INF' => 25,
			'EULER' => 24,
			'UNIOP' => 22,
			'VAR' => 29
		},
		GOTOS => {
			'equation' => 23,
			'constant' => 34,
			'expr' => 35,
			'macroargpairlist' => 67
		}
	},
	{#State 45
		DEFAULT => -11
	},
	{#State 46
		ACTIONS => {
			"-" => 28,
			'NUM' => 36,
			"(" => 33,
			"+" => 32,
			"delay" => 27,
			'NAN' => 31,
			'BINOP' => 26,
			'INF' => 25,
			'PI' => 30,
			'EULER' => 24,
			'UNIOP' => 22,
			'VAR' => 41
		},
		GOTOS => {
			'expr' => 68,
			'constant' => 34
		}
	},
	{#State 47
		ACTIONS => {
			'PI' => 30,
			'INF' => 25,
			'EULER' => 24,
			'UNIOP' => 22,
			'VAR' => 41,
			"-" => 28,
			'NUM' => 36,
			"(" => 33,
			'NAN' => 31,
			"+" => 32,
			"delay" => 27,
			'BINOP' => 26
		},
		GOTOS => {
			'expr' => 69,
			'constant' => 34
		}
	},
	{#State 48
		ACTIONS => {
			'VAR' => 70
		}
	},
	{#State 49
		DEFAULT => -35
	},
	{#State 50
		ACTIONS => {
			'VAR' => 72
		},
		GOTOS => {
			'argpairlist' => 71
		}
	},
	{#State 51
		ACTIONS => {
			'VAR' => 41,
			'UNIOP' => 22,
			'PI' => 30,
			'INF' => 25,
			'EULER' => 24,
			'BINOP' => 26,
			'NAN' => 31,
			"delay" => 27,
			"+" => 32,
			"(" => 33,
			'NUM' => 36,
			"-" => 28
		},
		GOTOS => {
			'expr' => 35,
			'equation' => 73,
			'constant' => 34
		}
	},
	{#State 52
		ACTIONS => {
			"^" => 58,
			"!" => 57,
			"*" => 55,
			"/" => 54
		},
		DEFAULT => -34
	},
	{#State 53
		ACTIONS => {
			"+" => 59,
			")" => 74,
			"/" => 54,
			"^" => 58,
			"*" => 55,
			"-" => 56,
			"!" => 57
		}
	},
	{#State 54
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 24,
			'PI' => 30,
			'INF' => 25,
			'UNIOP' => 22,
			"+" => 32,
			'NAN' => 31,
			"delay" => 27,
			"(" => 33,
			'BINOP' => 26,
			'NUM' => 36,
			"-" => 28
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 75
		}
	},
	{#State 55
		ACTIONS => {
			'INF' => 25,
			'PI' => 30,
			'EULER' => 24,
			'UNIOP' => 22,
			'VAR' => 41,
			"-" => 28,
			'NUM' => 36,
			"delay" => 27,
			'NAN' => 31,
			"+" => 32,
			"(" => 33,
			'BINOP' => 26
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 76
		}
	},
	{#State 56
		ACTIONS => {
			'NAN' => 31,
			"delay" => 27,
			"+" => 32,
			"(" => 33,
			'BINOP' => 26,
			'NUM' => 36,
			"-" => 28,
			'VAR' => 41,
			'PI' => 30,
			'INF' => 25,
			'EULER' => 24,
			'UNIOP' => 22
		},
		GOTOS => {
			'constant' => 34,
			'expr' => 77
		}
	},
	{#State 57
		DEFAULT => -33
	},
	{#State 58
		ACTIONS => {
			'NUM' => 36,
			"-" => 28,
			"delay" => 27,
			'NAN' => 31,
			"+" => 32,
			"(" => 33,
			'BINOP' => 26,
			'PI' => 30,
			'INF' => 25,
			'EULER' => 24,
			'UNIOP' => 22,
			'VAR' => 41
		},
		GOTOS => {
			'expr' => 78,
			'constant' => 34
		}
	},
	{#State 59
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 24,
			'PI' => 30,
			'INF' => 25,
			'UNIOP' => 22,
			'NAN' => 31,
			"+" => 32,
			"delay" => 27,
			"(" => 33,
			'BINOP' => 26,
			"-" => 28,
			'NUM' => 36
		},
		GOTOS => {
			'expr' => 79,
			'constant' => 34
		}
	},
	{#State 60
		ACTIONS => {
			"*" => -31,
			"/" => -31,
			"^" => -31,
			"+" => -31,
			"-" => -31,
			"!" => -31
		},
		DEFAULT => -23
	},
	{#State 61
		DEFAULT => -24
	},
	{#State 62
		DEFAULT => -22
	},
	{#State 63
		DEFAULT => -19
	},
	{#State 64
		DEFAULT => -13
	},
	{#State 65
		ACTIONS => {
			'VAR' => 41,
			'UNIOP' => 22,
			'INF' => 25,
			'EULER' => 24,
			'PI' => 30,
			'BINOP' => 26,
			"(" => 33,
			"delay" => 27,
			'NAN' => 31,
			"+" => 32,
			"-" => 28,
			'NUM' => 36
		},
		GOTOS => {
			'expr' => 35,
			'equation' => 80,
			'constant' => 34
		}
	},
	{#State 66
		ACTIONS => {
			"-" => 28,
			'NUM' => 36,
			"(" => 33,
			"delay" => 27,
			'NAN' => 31,
			"+" => 32,
			'BINOP' => 26,
			'EULER' => 24,
			'INF' => 25,
			'PI' => 30,
			'UNIOP' => 22,
			'VAR' => 41
		},
		GOTOS => {
			'equation' => 81,
			'constant' => 34,
			'expr' => 35
		}
	},
	{#State 67
		DEFAULT => -48
	},
	{#State 68
		ACTIONS => {
			")" => 82,
			"+" => 59,
			"*" => 55,
			"-" => 56,
			"!" => 57,
			"/" => 54,
			"^" => 58
		}
	},
	{#State 69
		ACTIONS => {
			"," => 83,
			"+" => 59,
			"-" => 56,
			"*" => 55,
			"!" => 57,
			"/" => 54,
			"^" => 58
		}
	},
	{#State 70
		ACTIONS => {
			"," => 84
		}
	},
	{#State 71
		ACTIONS => {
			"," => 86,
			")" => 85
		}
	},
	{#State 72
		ACTIONS => {
			"=" => 87
		}
	},
	{#State 73
		DEFAULT => -50
	},
	{#State 74
		DEFAULT => -36
	},
	{#State 75
		ACTIONS => {
			"^" => 58,
			"!" => 57
		},
		DEFAULT => -29
	},
	{#State 76
		ACTIONS => {
			"^" => 58,
			"!" => 57
		},
		DEFAULT => -28
	},
	{#State 77
		ACTIONS => {
			"/" => 54,
			"*" => 55,
			"!" => 57,
			"^" => 58
		},
		DEFAULT => -27
	},
	{#State 78
		ACTIONS => {
			"!" => 57,
			"^" => 58
		},
		DEFAULT => -30
	},
	{#State 79
		ACTIONS => {
			"^" => 58,
			"*" => 55,
			"/" => 54,
			"!" => 57
		},
		DEFAULT => -26
	},
	{#State 80
		ACTIONS => {
			'DESCRIPTION' => 88
		},
		DEFAULT => -18,
		GOTOS => {
			'OPTIONAL-6' => 89
		}
	},
	{#State 81
		ACTIONS => {
			'DESCRIPTION' => 91
		},
		DEFAULT => -16,
		GOTOS => {
			'OPTIONAL-5' => 90
		}
	},
	{#State 82
		DEFAULT => -37
	},
	{#State 83
		ACTIONS => {
			'UNIOP' => 22,
			'INF' => 25,
			'EULER' => 24,
			'PI' => 30,
			'VAR' => 41,
			'NUM' => 36,
			"-" => 28,
			'BINOP' => 26,
			"+" => 32,
			"delay" => 27,
			'NAN' => 31,
			"(" => 33
		},
		GOTOS => {
			'expr' => 92,
			'constant' => 34
		}
	},
	{#State 84
		ACTIONS => {
			'VAR' => 93
		}
	},
	{#State 85
		DEFAULT => -40
	},
	{#State 86
		ACTIONS => {
			'VAR' => 72
		},
		GOTOS => {
			'argpairlist' => 94
		}
	},
	{#State 87
		ACTIONS => {
			'VAR' => 41,
			'EULER' => 24,
			'INF' => 25,
			'PI' => 30,
			'UNIOP' => 22,
			"(" => 33,
			"delay" => 27,
			'NAN' => 31,
			"+" => 32,
			'BINOP' => 26,
			'NUM' => 36,
			"-" => 28
		},
		GOTOS => {
			'expr' => 35,
			'constant' => 34,
			'equation' => 95
		}
	},
	{#State 88
		DEFAULT => -17
	},
	{#State 89
		DEFAULT => -21
	},
	{#State 90
		DEFAULT => -20
	},
	{#State 91
		DEFAULT => -15
	},
	{#State 92
		ACTIONS => {
			"+" => 59,
			")" => 96,
			"/" => 54,
			"^" => 58,
			"-" => 56,
			"*" => 55,
			"!" => 57
		}
	},
	{#State 93
		ACTIONS => {
			")" => 97
		}
	},
	{#State 94
		DEFAULT => -46
	},
	{#State 95
		DEFAULT => -47
	},
	{#State 96
		DEFAULT => -38
	},
	{#State 97
		DEFAULT => -39
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1078 ./infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1082 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1089 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1096 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1103 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1110 ./infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1114 ./infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1118 ./infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1122 ./infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 50 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1129 ./infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1133 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1140 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1147 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1154 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1161 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 68 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1168 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 68 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1175 ./infix2pharmml_model.pm
	],
	[#Rule common_19
		 'common', 4,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1182 ./infix2pharmml_model.pm
	],
	[#Rule common_20
		 'common', 7,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1189 ./infix2pharmml_model.pm
	],
	[#Rule common_21
		 'common', 7,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1196 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_22
		 'parameterlist', 3,
sub {
#line 75 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1203 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_23
		 'parameterlist', 3,
sub {
#line 76 "infix2pharmml_model.eyp"
infix2pharmml::par_n($_[1],$_[3])}
#line 1210 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_24
		 'parameterlist', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1217 ./infix2pharmml_model.pm
	],
	[#Rule equation_25
		 'equation', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1224 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1231 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1238 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1245 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1252 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1259 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 1,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1266 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1273 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 2,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1280 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 2,
sub {
#line 94 "infix2pharmml_model.eyp"
$_[2]}
#line 1287 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 2,
sub {
#line 95 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1294 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 3,
sub {
#line 96 "infix2pharmml_model.eyp"
$_[2]}
#line 1301 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 97 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1308 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 6,
sub {
#line 98 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1315 ./infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 6,
sub {
#line 99 "infix2pharmml_model.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 1322 ./infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 4,
sub {
#line 100 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1329 ./infix2pharmml_model.pm
	],
	[#Rule expr_41
		 'expr', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1336 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 109 "infix2pharmml_model.eyp"
"notanumber"}
#line 1343 ./infix2pharmml_model.pm
	],
	[#Rule constant_43
		 'constant', 1,
sub {
#line 110 "infix2pharmml_model.eyp"
"pi"}
#line 1350 ./infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 111 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1357 ./infix2pharmml_model.pm
	],
	[#Rule constant_45
		 'constant', 1,
sub {
#line 112 "infix2pharmml_model.eyp"
"infinity"}
#line 1364 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_46
		 'argpairlist', 3,
sub {
#line 116 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1371 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_47
		 'argpairlist', 3,
sub {
#line 117 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1378 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_48
		 'macroargpairlist', 3,
sub {
#line 127 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1385 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_49
		 'macroargpairlist', 1,
sub {
#line 128 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1392 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_50
		 'macroargpairlist', 3,
sub {
#line 129 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1399 ./infix2pharmml_model.pm
	]
],
#line 1402 ./infix2pharmml_model.pm
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
         'expr_41', 
         'constant_42', 
         'constant_43', 
         'constant_44', 
         'constant_45', 
         'argpairlist_46', 
         'argpairlist_47', 
         'macroargpairlist_48', 
         'macroargpairlist_49', 
         'macroargpairlist_50', );
  $self;
}

#line 134 "infix2pharmml_model.eyp"



=for None

=cut


#line 1479 ./infix2pharmml_model.pm



1;
