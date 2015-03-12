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

      m{\G(delay|diff\(|\)\:\=|\:\=|\)\=|\;|\!|\=|\)|\/|\,|\+|\^|\(|\*|\-)}gc and return ($1, $1);

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
			"diff(" => 3,
			'PAR' => 5,
			'VAR' => 4,
			'COMMENT' => 2,
			'MACRO' => 6
		},
		GOTOS => {
			'assignment' => 1,
			'common' => 7,
			'PLUS-1' => 8,
			'model' => 9,
			'line' => 10
		}
	},
	{#State 1
		ACTIONS => {
			";" => 12
		},
		DEFAULT => -5,
		GOTOS => {
			'OPTIONAL-2' => 11
		}
	},
	{#State 2
		DEFAULT => -8
	},
	{#State 3
		ACTIONS => {
			'VAR' => 13
		}
	},
	{#State 4
		ACTIONS => {
			":=" => 14
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
		ACTIONS => {
			"(" => 17
		}
	},
	{#State 7
		DEFAULT => -10
	},
	{#State 8
		ACTIONS => {
			'VAR' => 4,
			'PAR' => 5,
			"diff(" => 3,
			'MACRO' => 6,
			'COMMENT' => 2
		},
		DEFAULT => -3,
		GOTOS => {
			'line' => 18,
			'common' => 7,
			'assignment' => 1
		}
	},
	{#State 9
		ACTIONS => {
			'' => 19
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'COMMENT' => 21
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 20
		}
	},
	{#State 12
		DEFAULT => -4
	},
	{#State 13
		ACTIONS => {
			"," => 22
		}
	},
	{#State 14
		ACTIONS => {
			"-" => 24,
			'NAN' => 23,
			'INF' => 28,
			'VAR' => 27,
			"+" => 29,
			'NUM' => 30,
			'BINOP' => 33,
			"delay" => 32,
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37
		},
		GOTOS => {
			'equation' => 31,
			'constant' => 26,
			'expr' => 25
		}
	},
	{#State 15
		ACTIONS => {
			"=" => 38
		}
	},
	{#State 16
		ACTIONS => {
			"," => 39
		},
		DEFAULT => -12
	},
	{#State 17
		ACTIONS => {
			"+" => 29,
			'VAR' => 40,
			'INF' => 28,
			"-" => 24,
			'NAN' => 23,
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30
		},
		GOTOS => {
			'macroargpairlist' => 42,
			'equation' => 41,
			'expr' => 25,
			'constant' => 26
		}
	},
	{#State 18
		DEFAULT => -1
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
			'VAR' => 43
		}
	},
	{#State 23
		DEFAULT => -39
	},
	{#State 24
		ACTIONS => {
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37,
			'NUM' => 30,
			'BINOP' => 33,
			"delay" => 32,
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NAN' => 23,
			"-" => 24
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 26
		}
	},
	{#State 25
		ACTIONS => {
			"*" => 45,
			"-" => 46,
			"!" => 47,
			"/" => 48,
			"^" => 49,
			"+" => 50
		},
		DEFAULT => -22
	},
	{#State 26
		DEFAULT => -29
	},
	{#State 27
		ACTIONS => {
			"(" => 51
		},
		DEFAULT => -38
	},
	{#State 28
		DEFAULT => -42
	},
	{#State 29
		ACTIONS => {
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 30,
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NAN' => 23,
			"-" => 24
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 52
		}
	},
	{#State 30
		DEFAULT => -28
	},
	{#State 31
		ACTIONS => {
			'DESCRIPTION' => 53
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 54
		}
	},
	{#State 32
		ACTIONS => {
			"(" => 55
		}
	},
	{#State 33
		ACTIONS => {
			"(" => 56
		}
	},
	{#State 34
		DEFAULT => -40
	},
	{#State 35
		ACTIONS => {
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30,
			"+" => 29,
			'VAR' => 27,
			'INF' => 28,
			'NAN' => 23,
			"-" => 24
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 57
		}
	},
	{#State 36
		ACTIONS => {
			"(" => 58
		}
	},
	{#State 37
		DEFAULT => -41
	},
	{#State 38
		ACTIONS => {
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 30,
			"+" => 29,
			'VAR' => 27,
			'INF' => 28,
			'NAN' => 23,
			"-" => 24
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 26,
			'equation' => 59
		}
	},
	{#State 39
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 60
		}
	},
	{#State 40
		ACTIONS => {
			"=" => 61,
			"(" => 51
		},
		DEFAULT => -38
	},
	{#State 41
		DEFAULT => -46
	},
	{#State 42
		ACTIONS => {
			")" => 62,
			"," => 63
		}
	},
	{#State 43
		ACTIONS => {
			")=" => 65,
			"):=" => 64
		}
	},
	{#State 44
		DEFAULT => -32
	},
	{#State 45
		ACTIONS => {
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30,
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NAN' => 23,
			"-" => 24
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 66
		}
	},
	{#State 46
		ACTIONS => {
			'NAN' => 23,
			"-" => 24,
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NUM' => 30,
			"delay" => 32,
			'BINOP' => 33,
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 67
		}
	},
	{#State 47
		DEFAULT => -30
	},
	{#State 48
		ACTIONS => {
			'INF' => 28,
			'VAR' => 27,
			"+" => 29,
			"-" => 24,
			'NAN' => 23,
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37,
			'NUM' => 30,
			"delay" => 32,
			'BINOP' => 33
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 68
		}
	},
	{#State 49
		ACTIONS => {
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30,
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34,
			'NAN' => 23,
			"-" => 24,
			"+" => 29,
			'VAR' => 27,
			'INF' => 28
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 69
		}
	},
	{#State 50
		ACTIONS => {
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 30,
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			"-" => 24,
			'NAN' => 23,
			'VAR' => 27,
			'INF' => 28,
			"+" => 29
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 70
		}
	},
	{#State 51
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 72
		}
	},
	{#State 52
		ACTIONS => {
			"!" => 47,
			"^" => 49,
			"/" => 48,
			"*" => 45
		},
		DEFAULT => -31
	},
	{#State 53
		DEFAULT => -13
	},
	{#State 54
		DEFAULT => -19
	},
	{#State 55
		ACTIONS => {
			'VAR' => 73
		}
	},
	{#State 56
		ACTIONS => {
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30,
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34,
			'NAN' => 23,
			"-" => 24,
			"+" => 29,
			'INF' => 28,
			'VAR' => 27
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 74
		}
	},
	{#State 57
		ACTIONS => {
			"!" => 47,
			"^" => 49,
			"+" => 50,
			")" => 75,
			"*" => 45,
			"-" => 46,
			"/" => 48
		}
	},
	{#State 58
		ACTIONS => {
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NAN' => 23,
			"-" => 24,
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 30
		},
		GOTOS => {
			'constant' => 26,
			'expr' => 76
		}
	},
	{#State 59
		DEFAULT => -49
	},
	{#State 60
		DEFAULT => -48
	},
	{#State 61
		ACTIONS => {
			'VAR' => 27,
			'INF' => 28,
			"+" => 29,
			'NAN' => 23,
			"-" => 24,
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 30
		},
		GOTOS => {
			'equation' => 77,
			'constant' => 26,
			'expr' => 25
		}
	},
	{#State 62
		DEFAULT => -11
	},
	{#State 63
		ACTIONS => {
			'INF' => 28,
			'VAR' => 40,
			"+" => 29,
			'NAN' => 23,
			"-" => 24,
			'UNIOP' => 36,
			'EULER' => 37,
			'PI' => 34,
			"(" => 35,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30
		},
		GOTOS => {
			'macroargpairlist' => 78,
			'equation' => 41,
			'expr' => 25,
			'constant' => 26
		}
	},
	{#State 64
		ACTIONS => {
			'NAN' => 23,
			"-" => 24,
			"+" => 29,
			'VAR' => 27,
			'INF' => 28,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 30,
			'EULER' => 37,
			'UNIOP' => 36,
			"(" => 35,
			'PI' => 34
		},
		GOTOS => {
			'equation' => 79,
			'expr' => 25,
			'constant' => 26
		}
	},
	{#State 65
		ACTIONS => {
			'INF' => 28,
			'VAR' => 27,
			"+" => 29,
			"-" => 24,
			'NAN' => 23,
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37,
			'NUM' => 30,
			'BINOP' => 33,
			"delay" => 32
		},
		GOTOS => {
			'equation' => 80,
			'constant' => 26,
			'expr' => 25
		}
	},
	{#State 66
		ACTIONS => {
			"!" => 47,
			"^" => 49
		},
		DEFAULT => -25
	},
	{#State 67
		ACTIONS => {
			"/" => 48,
			"^" => 49,
			"!" => 47,
			"*" => 45
		},
		DEFAULT => -24
	},
	{#State 68
		ACTIONS => {
			"^" => 49,
			"!" => 47
		},
		DEFAULT => -26
	},
	{#State 69
		ACTIONS => {
			"^" => 49,
			"!" => 47
		},
		DEFAULT => -27
	},
	{#State 70
		ACTIONS => {
			"*" => 45,
			"!" => 47,
			"^" => 49,
			"/" => 48
		},
		DEFAULT => -23
	},
	{#State 71
		ACTIONS => {
			"=" => 81
		}
	},
	{#State 72
		ACTIONS => {
			")" => 83,
			"," => 82
		}
	},
	{#State 73
		ACTIONS => {
			"," => 84
		}
	},
	{#State 74
		ACTIONS => {
			"*" => 45,
			"," => 85,
			"-" => 46,
			"/" => 48,
			"!" => 47,
			"^" => 49,
			"+" => 50
		}
	},
	{#State 75
		DEFAULT => -33
	},
	{#State 76
		ACTIONS => {
			")" => 86,
			"*" => 45,
			"-" => 46,
			"/" => 48,
			"^" => 49,
			"!" => 47,
			"+" => 50
		}
	},
	{#State 77
		DEFAULT => -47
	},
	{#State 78
		DEFAULT => -45
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
			'NUM' => 30,
			'BINOP' => 33,
			"delay" => 32,
			"(" => 35,
			'PI' => 34,
			'EULER' => 37,
			'UNIOP' => 36,
			'NAN' => 23,
			"-" => 24,
			"+" => 29,
			'INF' => 28,
			'VAR' => 27
		},
		GOTOS => {
			'equation' => 91,
			'expr' => 25,
			'constant' => 26
		}
	},
	{#State 82
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 92
		}
	},
	{#State 83
		DEFAULT => -37
	},
	{#State 84
		ACTIONS => {
			'VAR' => 93
		}
	},
	{#State 85
		ACTIONS => {
			'PI' => 34,
			"(" => 35,
			'UNIOP' => 36,
			'EULER' => 37,
			'NUM' => 30,
			"delay" => 32,
			'BINOP' => 33,
			'INF' => 28,
			'VAR' => 27,
			"+" => 29,
			"-" => 24,
			'NAN' => 23
		},
		GOTOS => {
			'expr' => 94,
			'constant' => 26
		}
	},
	{#State 86
		DEFAULT => -34
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
		DEFAULT => -44
	},
	{#State 92
		DEFAULT => -43
	},
	{#State 93
		ACTIONS => {
			")" => 95
		}
	},
	{#State 94
		ACTIONS => {
			"^" => 49,
			"!" => 47,
			"+" => 50,
			"-" => 46,
			"/" => 48,
			")" => 96,
			"*" => 45
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
#line 1051 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1058 ./infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1065 ./infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1069 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1076 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1083 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1090 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 44 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1097 ./infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1101 ./infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1105 ./infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1109 ./infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 50 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1116 ./infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1120 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1127 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1134 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1141 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 66 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1148 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 68 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1155 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 68 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1162 ./infix2pharmml_model.pm
	],
	[#Rule common_19
		 'common', 4,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1169 ./infix2pharmml_model.pm
	],
	[#Rule common_20
		 'common', 7,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1176 ./infix2pharmml_model.pm
	],
	[#Rule common_21
		 'common', 7,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1183 ./infix2pharmml_model.pm
	],
	[#Rule equation_22
		 'equation', 1,
sub {
#line 75 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1190 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1197 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1204 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1211 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1218 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 3,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1225 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 1,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1232 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 1,
sub {
#line 85 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1239 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1246 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 2,
sub {
#line 87 "infix2pharmml_model.eyp"
$_[2]}
#line 1253 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 2,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1260 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 3,
sub {
#line 89 "infix2pharmml_model.eyp"
$_[2]}
#line 1267 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1274 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 6,
sub {
#line 91 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1281 ./infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 6,
sub {
#line 92 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1288 ./infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 4,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1295 ./infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 1,
sub {
#line 94 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1302 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"notanumber"}
#line 1309 ./infix2pharmml_model.pm
	],
	[#Rule constant_40
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"pi"}
#line 1316 ./infix2pharmml_model.pm
	],
	[#Rule constant_41
		 'constant', 1,
sub {
#line 104 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1323 ./infix2pharmml_model.pm
	],
	[#Rule constant_42
		 'constant', 1,
sub {
#line 105 "infix2pharmml_model.eyp"
"infinity"}
#line 1330 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_43
		 'argpairlist', 3,
sub {
#line 109 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1337 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_44
		 'argpairlist', 3,
sub {
#line 110 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1344 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_45
		 'macroargpairlist', 3,
sub {
#line 120 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1351 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_46
		 'macroargpairlist', 1,
sub {
#line 121 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1358 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_47
		 'macroargpairlist', 3,
sub {
#line 122 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1365 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_48
		 'parameterlist', 3,
sub {
#line 127 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1372 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_49
		 'parameterlist', 3,
sub {
#line 128 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1379 ./infix2pharmml_model.pm
	]
],
#line 1382 ./infix2pharmml_model.pm
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

#line 132 "infix2pharmml_model.eyp"



=for None

=cut


#line 1458 ./infix2pharmml_model.pm



1;
