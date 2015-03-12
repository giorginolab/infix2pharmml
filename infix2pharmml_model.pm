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
  [ 'assignment_12' => 'assignment', [ 'par', 'parameterlist' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'common_19' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'common_20' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'common_21' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-6' ], 0 ],
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
  [ 'expr_36' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_37' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_38' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_39' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_40' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_41' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_42' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_43' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_44' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_45' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_46' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_47' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parameterlist_48' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_49' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  'expr_38' => 38,
  'constant_39' => 39,
  'constant_40' => 40,
  'constant_41' => 41,
  'constant_42' => 42,
  'argpairlist_43' => 43,
  'argpairlist_44' => 44,
  'macroargpairlist_45' => 45,
  'macroargpairlist_46' => 46,
  'macroargpairlist_47' => 47,
  'parameterlist_48' => 48,
  'parameterlist_49' => 49,
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
			"par" => 9,
			'MACRO' => 8,
			'VAR' => 7,
			"diff(" => 6,
			'COMMENT' => 4
		},
		GOTOS => {
			'assignment' => 1,
			'model' => 2,
			'common' => 3,
			'line' => 10,
			'PLUS-1' => 5
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
			'' => 13
		}
	},
	{#State 3
		DEFAULT => -10
	},
	{#State 4
		DEFAULT => -8
	},
	{#State 5
		ACTIONS => {
			'MACRO' => 8,
			"par" => 9,
			'VAR' => 7,
			"diff(" => 6,
			'COMMENT' => 4
		},
		DEFAULT => -3,
		GOTOS => {
			'assignment' => 1,
			'common' => 3,
			'line' => 14
		}
	},
	{#State 6
		ACTIONS => {
			'VAR' => 15
		}
	},
	{#State 7
		ACTIONS => {
			":=" => 16
		}
	},
	{#State 8
		ACTIONS => {
			"(" => 17
		}
	},
	{#State 9
		ACTIONS => {
			'VAR' => 19
		},
		GOTOS => {
			'parameterlist' => 18
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -4
	},
	{#State 12
		ACTIONS => {
			'COMMENT' => 20
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 21
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
			"," => 22
		}
	},
	{#State 16
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'equation' => 29,
			'constant' => 28
		}
	},
	{#State 17
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			"delay" => 26,
			'UNIOP' => 27,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 40,
			'PI' => 36,
			'BINOP' => 37
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 38,
			'macroargpairlist' => 39
		}
	},
	{#State 18
		ACTIONS => {
			"," => 41
		},
		DEFAULT => -12
	},
	{#State 19
		ACTIONS => {
			"=" => 42
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		DEFAULT => -9
	},
	{#State 22
		ACTIONS => {
			'VAR' => 43
		}
	},
	{#State 23
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 28
		}
	},
	{#State 24
		DEFAULT => -39
	},
	{#State 25
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 45,
			'constant' => 28
		}
	},
	{#State 26
		ACTIONS => {
			"(" => 46
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 47
		}
	},
	{#State 28
		DEFAULT => -29
	},
	{#State 29
		ACTIONS => {
			'DESCRIPTION' => 48
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 49
		}
	},
	{#State 30
		DEFAULT => -41
	},
	{#State 31
		DEFAULT => -28
	},
	{#State 32
		DEFAULT => -42
	},
	{#State 33
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 50,
			'constant' => 28
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 51,
			"+" => 52,
			"!" => 53,
			"^" => 54,
			"*" => 55,
			"/" => 56
		},
		DEFAULT => -22
	},
	{#State 35
		ACTIONS => {
			"(" => 57
		},
		DEFAULT => -38
	},
	{#State 36
		DEFAULT => -40
	},
	{#State 37
		ACTIONS => {
			"(" => 58
		}
	},
	{#State 38
		DEFAULT => -46
	},
	{#State 39
		ACTIONS => {
			"," => 59,
			")" => 60
		}
	},
	{#State 40
		ACTIONS => {
			"=" => 61,
			"(" => 57
		},
		DEFAULT => -38
	},
	{#State 41
		ACTIONS => {
			'VAR' => 19
		},
		GOTOS => {
			'parameterlist' => 62
		}
	},
	{#State 42
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 63
		}
	},
	{#State 43
		ACTIONS => {
			"):=" => 64,
			")=" => 65
		}
	},
	{#State 44
		DEFAULT => -32
	},
	{#State 45
		ACTIONS => {
			"!" => 53,
			"^" => 54,
			"*" => 55,
			"/" => 56
		},
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			'VAR' => 66
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 67,
			'constant' => 28
		}
	},
	{#State 48
		DEFAULT => -13
	},
	{#State 49
		DEFAULT => -19
	},
	{#State 50
		ACTIONS => {
			"-" => 51,
			"^" => 54,
			"!" => 53,
			"*" => 55,
			"+" => 52,
			"/" => 56,
			")" => 68
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 69,
			'constant' => 28
		}
	},
	{#State 52
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 70,
			'constant' => 28
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 28
		}
	},
	{#State 55
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 72,
			'constant' => 28
		}
	},
	{#State 56
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 73,
			'constant' => 28
		}
	},
	{#State 57
		ACTIONS => {
			'VAR' => 75
		},
		GOTOS => {
			'argpairlist' => 74
		}
	},
	{#State 58
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 76,
			'constant' => 28
		}
	},
	{#State 59
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 40,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 38,
			'macroargpairlist' => 77
		}
	},
	{#State 60
		DEFAULT => -11
	},
	{#State 61
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 78
		}
	},
	{#State 62
		DEFAULT => -48
	},
	{#State 63
		DEFAULT => -49
	},
	{#State 64
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 79
		}
	},
	{#State 65
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 80
		}
	},
	{#State 66
		ACTIONS => {
			"," => 81
		}
	},
	{#State 67
		ACTIONS => {
			"-" => 51,
			"^" => 54,
			"!" => 53,
			"*" => 55,
			"+" => 52,
			"/" => 56,
			")" => 82
		}
	},
	{#State 68
		DEFAULT => -33
	},
	{#State 69
		ACTIONS => {
			"!" => 53,
			"^" => 54,
			"*" => 55,
			"/" => 56
		},
		DEFAULT => -24
	},
	{#State 70
		ACTIONS => {
			"!" => 53,
			"^" => 54,
			"*" => 55,
			"/" => 56
		},
		DEFAULT => -23
	},
	{#State 71
		ACTIONS => {
			"!" => 53,
			"^" => 54
		},
		DEFAULT => -27
	},
	{#State 72
		ACTIONS => {
			"!" => 53,
			"^" => 54
		},
		DEFAULT => -25
	},
	{#State 73
		ACTIONS => {
			"!" => 53,
			"^" => 54
		},
		DEFAULT => -26
	},
	{#State 74
		ACTIONS => {
			"," => 83,
			")" => 84
		}
	},
	{#State 75
		ACTIONS => {
			"=" => 85
		}
	},
	{#State 76
		ACTIONS => {
			"-" => 51,
			"^" => 54,
			"!" => 53,
			"*" => 55,
			"+" => 52,
			"/" => 56,
			"," => 86
		}
	},
	{#State 77
		DEFAULT => -45
	},
	{#State 78
		DEFAULT => -47
	},
	{#State 79
		ACTIONS => {
			'DESCRIPTION' => 88
		},
		DEFAULT => -18,
		GOTOS => {
			'OPTIONAL-6' => 87
		}
	},
	{#State 80
		ACTIONS => {
			'DESCRIPTION' => 89
		},
		DEFAULT => -16,
		GOTOS => {
			'OPTIONAL-5' => 90
		}
	},
	{#State 81
		ACTIONS => {
			'VAR' => 91
		}
	},
	{#State 82
		DEFAULT => -34
	},
	{#State 83
		ACTIONS => {
			'VAR' => 75
		},
		GOTOS => {
			'argpairlist' => 92
		}
	},
	{#State 84
		DEFAULT => -37
	},
	{#State 85
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 34,
			'constant' => 28,
			'equation' => 93
		}
	},
	{#State 86
		ACTIONS => {
			"-" => 23,
			'NAN' => 24,
			"+" => 25,
			'UNIOP' => 27,
			"delay" => 26,
			'EULER' => 30,
			'NUM' => 31,
			"(" => 33,
			'INF' => 32,
			'VAR' => 35,
			'BINOP' => 37,
			'PI' => 36
		},
		GOTOS => {
			'expr' => 94,
			'constant' => 28
		}
	},
	{#State 87
		DEFAULT => -21
	},
	{#State 88
		DEFAULT => -17
	},
	{#State 89
		DEFAULT => -15
	},
	{#State 90
		DEFAULT => -20
	},
	{#State 91
		ACTIONS => {
			")" => 95
		}
	},
	{#State 92
		DEFAULT => -43
	},
	{#State 93
		DEFAULT => -44
	},
	{#State 94
		ACTIONS => {
			"-" => 51,
			"^" => 54,
			"!" => 53,
			"*" => 55,
			"+" => 52,
			"/" => 56,
			")" => 96
		}
	},
	{#State 95
		DEFAULT => -36
	},
	{#State 96
		DEFAULT => -35
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1068 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1075 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1082 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1089 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1096 ./infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1100 ./infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1104 ./infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1108 ./infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1115 ./infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1119 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1126 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 63 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1133 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1140 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1147 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1154 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1161 ./infix2pharmml_model.pm
	],
	[#Rule common_19
		 'common', 4,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1168 ./infix2pharmml_model.pm
	],
	[#Rule common_20
		 'common', 7,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1175 ./infix2pharmml_model.pm
	],
	[#Rule common_21
		 'common', 7,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1182 ./infix2pharmml_model.pm
	],
	[#Rule equation_22
		 'equation', 1,
sub {
#line 73 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1189 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1196 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1203 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1210 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1217 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1224 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1231 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1238 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1245 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 85 "infix2pharmml_model.eyp"
$_[2]}
#line 1252 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1259 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
$_[2]}
#line 1266 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1273 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 6,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1280 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 6,
sub {
#line 90 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1287 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1294 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 1,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1301 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 100 "infix2pharmml_model.eyp"
"notanumber"}
#line 1308 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"pi"}
#line 1315 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1322 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"infinity"}
#line 1329 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 107 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1336 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_44
		 'argpairlist', 3,
sub {
#line 108 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1343 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_45
		 'macroargpairlist', 3,
sub {
#line 118 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1350 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_46
		 'macroargpairlist', 1,
sub {
#line 119 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1357 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_47
		 'macroargpairlist', 3,
sub {
#line 120 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1364 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_48
		 'parameterlist', 3,
sub {
#line 125 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1371 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_49
		 'parameterlist', 3,
sub {
#line 126 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1378 ./infix2pharmml_model.pm
	]
],
#line 1381 ./infix2pharmml_model.pm
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
         'expr_38', 
         'constant_39', 
         'constant_40', 
         'constant_41', 
         'constant_42', 
         'argpairlist_43', 
         'argpairlist_44', 
         'macroargpairlist_45', 
         'macroargpairlist_46', 
         'macroargpairlist_47', 
         'parameterlist_48', 
         'parameterlist_49', );
  $self;
}

#line 130 "infix2pharmml_model.eyp"



=for None

=cut


#line 1457 ./infix2pharmml_model.pm



1;
