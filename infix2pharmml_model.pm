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

      m{\G(delay|diff\(|\)\:\=|par|\)\=|\:\=|\;|\#|\-|\(|\+|\)|\,|\^|\!|\*|\/|\=)}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt|heaviside|sign)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
      /\G(.+?)/gc and return ('COMMENT', $1);
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
  [ 'assignment_6' => 'assignment', [ 'common' ], 0 ],
  [ 'assignment_7' => 'assignment', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'assignment_8' => 'assignment', [ '#', 'COMMENT' ], 0 ],
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
  'assignment_6' => 6,
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
	'#' => { ISSEMANTIC => 0 },
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
			'VAR' => 1,
			'MACRO' => 4,
			"diff(" => 5,
			"par" => 8,
			"#" => 9
		},
		GOTOS => {
			'assignment' => 7,
			'line' => 6,
			'common' => 2,
			'model' => 3
		}
	},
	{#State 1
		ACTIONS => {
			":=" => 10
		}
	},
	{#State 2
		DEFAULT => -6
	},
	{#State 3
		ACTIONS => {
			"#" => 9,
			"par" => 8,
			'' => 12,
			'VAR' => 1,
			'MACRO' => 4,
			"diff(" => 5
		},
		GOTOS => {
			'common' => 2,
			'line' => 11,
			'assignment' => 7
		}
	},
	{#State 4
		ACTIONS => {
			"(" => 13
		}
	},
	{#State 5
		ACTIONS => {
			'VAR' => 14
		}
	},
	{#State 6
		DEFAULT => -2
	},
	{#State 7
		ACTIONS => {
			";" => 16
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 15
		}
	},
	{#State 8
		ACTIONS => {
			'VAR' => 18
		},
		GOTOS => {
			'parameterlist' => 17
		}
	},
	{#State 9
		ACTIONS => {
			'COMMENT' => 19
		}
	},
	{#State 10
		ACTIONS => {
			'EULER' => 33,
			'NUM' => 31,
			'PI' => 32,
			"-" => 30,
			'UNIOP' => 29,
			"delay" => 25,
			"(" => 27,
			"+" => 26,
			'NAN' => 28,
			'INF' => 22,
			'VAR' => 24,
			'BINOP' => 20
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 21,
			'equation' => 34
		}
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'NAN' => 28,
			'INF' => 22,
			'VAR' => 37,
			'BINOP' => 20,
			'EULER' => 33,
			'NUM' => 31,
			'PI' => 32,
			"-" => 30,
			'UNIOP' => 29
		},
		GOTOS => {
			'macroargpairlist' => 35,
			'equation' => 36,
			'expr' => 21,
			'constant' => 23
		}
	},
	{#State 14
		ACTIONS => {
			"," => 38
		}
	},
	{#State 15
		DEFAULT => -5
	},
	{#State 16
		DEFAULT => -3
	},
	{#State 17
		ACTIONS => {
			"," => 39
		},
		DEFAULT => -9
	},
	{#State 18
		ACTIONS => {
			"=" => 40
		}
	},
	{#State 19
		DEFAULT => -8
	},
	{#State 20
		ACTIONS => {
			"(" => 41
		}
	},
	{#State 21
		ACTIONS => {
			"/" => 46,
			"*" => 45,
			"!" => 44,
			"^" => 47,
			"-" => 42,
			"+" => 43
		},
		DEFAULT => -19
	},
	{#State 22
		DEFAULT => -39
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		ACTIONS => {
			"(" => 48
		},
		DEFAULT => -35
	},
	{#State 25
		ACTIONS => {
			"(" => 49
		}
	},
	{#State 26
		ACTIONS => {
			"-" => 30,
			'UNIOP' => 29,
			'PI' => 32,
			'NUM' => 31,
			'EULER' => 33,
			'BINOP' => 20,
			'VAR' => 24,
			'INF' => 22,
			'NAN' => 28,
			"delay" => 25,
			"+" => 26,
			"(" => 27
		},
		GOTOS => {
			'expr' => 50,
			'constant' => 23
		}
	},
	{#State 27
		ACTIONS => {
			'EULER' => 33,
			'NUM' => 31,
			'PI' => 32,
			"-" => 30,
			'UNIOP' => 29,
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'NAN' => 28,
			'INF' => 22,
			'VAR' => 24,
			'BINOP' => 20
		},
		GOTOS => {
			'expr' => 51,
			'constant' => 23
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
		ACTIONS => {
			"-" => 30,
			'UNIOP' => 29,
			'PI' => 32,
			'NUM' => 31,
			'EULER' => 33,
			'BINOP' => 20,
			'VAR' => 24,
			'INF' => 22,
			'NAN' => 28,
			"+" => 26,
			"delay" => 25,
			"(" => 27
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 53
		}
	},
	{#State 31
		DEFAULT => -25
	},
	{#State 32
		DEFAULT => -37
	},
	{#State 33
		DEFAULT => -38
	},
	{#State 34
		ACTIONS => {
			'DESCRIPTION' => 54
		},
		DEFAULT => -11,
		GOTOS => {
			'OPTIONAL-2' => 55
		}
	},
	{#State 35
		ACTIONS => {
			"," => 57,
			")" => 56
		}
	},
	{#State 36
		DEFAULT => -43
	},
	{#State 37
		ACTIONS => {
			"=" => 58,
			"(" => 48
		},
		DEFAULT => -35
	},
	{#State 38
		ACTIONS => {
			'VAR' => 59
		}
	},
	{#State 39
		ACTIONS => {
			'VAR' => 18
		},
		GOTOS => {
			'parameterlist' => 60
		}
	},
	{#State 40
		ACTIONS => {
			'INF' => 22,
			'VAR' => 24,
			"delay" => 25,
			"(" => 27,
			"+" => 26,
			'NAN' => 28,
			'BINOP' => 20,
			'NUM' => 31,
			'PI' => 32,
			'EULER' => 33,
			'UNIOP' => 29,
			"-" => 30
		},
		GOTOS => {
			'equation' => 61,
			'expr' => 21,
			'constant' => 23
		}
	},
	{#State 41
		ACTIONS => {
			'UNIOP' => 29,
			"-" => 30,
			'NUM' => 31,
			'PI' => 32,
			'EULER' => 33,
			'BINOP' => 20,
			'INF' => 22,
			'VAR' => 24,
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'NAN' => 28
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 62
		}
	},
	{#State 42
		ACTIONS => {
			'INF' => 22,
			'VAR' => 24,
			"delay" => 25,
			"(" => 27,
			"+" => 26,
			'NAN' => 28,
			'BINOP' => 20,
			'NUM' => 31,
			'PI' => 32,
			'EULER' => 33,
			'UNIOP' => 29,
			"-" => 30
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 63
		}
	},
	{#State 43
		ACTIONS => {
			'BINOP' => 20,
			'INF' => 22,
			'VAR' => 24,
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'NAN' => 28,
			"-" => 30,
			'UNIOP' => 29,
			'NUM' => 31,
			'PI' => 32,
			'EULER' => 33
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 64
		}
	},
	{#State 44
		DEFAULT => -27
	},
	{#State 45
		ACTIONS => {
			'VAR' => 24,
			'INF' => 22,
			'NAN' => 28,
			"delay" => 25,
			"+" => 26,
			"(" => 27,
			'BINOP' => 20,
			'PI' => 32,
			'NUM' => 31,
			'EULER' => 33,
			"-" => 30,
			'UNIOP' => 29
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 65
		}
	},
	{#State 46
		ACTIONS => {
			'EULER' => 33,
			'PI' => 32,
			'NUM' => 31,
			'UNIOP' => 29,
			"-" => 30,
			'NAN' => 28,
			"+" => 26,
			"(" => 27,
			"delay" => 25,
			'VAR' => 24,
			'INF' => 22,
			'BINOP' => 20
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 66
		}
	},
	{#State 47
		ACTIONS => {
			'UNIOP' => 29,
			"-" => 30,
			'EULER' => 33,
			'PI' => 32,
			'NUM' => 31,
			'BINOP' => 20,
			'NAN' => 28,
			"delay" => 25,
			"(" => 27,
			"+" => 26,
			'VAR' => 24,
			'INF' => 22
		},
		GOTOS => {
			'expr' => 67,
			'constant' => 23
		}
	},
	{#State 48
		ACTIONS => {
			'VAR' => 68
		},
		GOTOS => {
			'argpairlist' => 69
		}
	},
	{#State 49
		ACTIONS => {
			'VAR' => 70
		}
	},
	{#State 50
		ACTIONS => {
			"!" => 44,
			"/" => 46,
			"*" => 45,
			"^" => 47
		},
		DEFAULT => -28
	},
	{#State 51
		ACTIONS => {
			"!" => 44,
			"/" => 46,
			"-" => 42,
			"*" => 45,
			"+" => 43,
			")" => 71,
			"^" => 47
		}
	},
	{#State 52
		ACTIONS => {
			'VAR' => 24,
			'INF' => 22,
			'NAN' => 28,
			"delay" => 25,
			"+" => 26,
			"(" => 27,
			'BINOP' => 20,
			'PI' => 32,
			'NUM' => 31,
			'EULER' => 33,
			"-" => 30,
			'UNIOP' => 29
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 72
		}
	},
	{#State 53
		DEFAULT => -29
	},
	{#State 54
		DEFAULT => -10
	},
	{#State 55
		DEFAULT => -16
	},
	{#State 56
		DEFAULT => -7
	},
	{#State 57
		ACTIONS => {
			"delay" => 25,
			"+" => 26,
			"(" => 27,
			'NAN' => 28,
			'INF' => 22,
			'VAR' => 37,
			'BINOP' => 20,
			'EULER' => 33,
			'NUM' => 31,
			'PI' => 32,
			"-" => 30,
			'UNIOP' => 29
		},
		GOTOS => {
			'expr' => 21,
			'constant' => 23,
			'equation' => 36,
			'macroargpairlist' => 73
		}
	},
	{#State 58
		ACTIONS => {
			'BINOP' => 20,
			'NAN' => 28,
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'VAR' => 24,
			'INF' => 22,
			"-" => 30,
			'UNIOP' => 29,
			'EULER' => 33,
			'PI' => 32,
			'NUM' => 31
		},
		GOTOS => {
			'expr' => 21,
			'constant' => 23,
			'equation' => 74
		}
	},
	{#State 59
		ACTIONS => {
			")=" => 76,
			"):=" => 75
		}
	},
	{#State 60
		DEFAULT => -45
	},
	{#State 61
		DEFAULT => -46
	},
	{#State 62
		ACTIONS => {
			"*" => 45,
			"-" => 42,
			"/" => 46,
			"!" => 44,
			"^" => 47,
			"," => 77,
			"+" => 43
		}
	},
	{#State 63
		ACTIONS => {
			"!" => 44,
			"*" => 45,
			"/" => 46,
			"^" => 47
		},
		DEFAULT => -21
	},
	{#State 64
		ACTIONS => {
			"^" => 47,
			"*" => 45,
			"/" => 46,
			"!" => 44
		},
		DEFAULT => -20
	},
	{#State 65
		ACTIONS => {
			"!" => 44,
			"^" => 47
		},
		DEFAULT => -22
	},
	{#State 66
		ACTIONS => {
			"!" => 44,
			"^" => 47
		},
		DEFAULT => -23
	},
	{#State 67
		ACTIONS => {
			"^" => 47,
			"!" => 44
		},
		DEFAULT => -24
	},
	{#State 68
		ACTIONS => {
			"=" => 78
		}
	},
	{#State 69
		ACTIONS => {
			"," => 80,
			")" => 79
		}
	},
	{#State 70
		ACTIONS => {
			"," => 81
		}
	},
	{#State 71
		DEFAULT => -30
	},
	{#State 72
		ACTIONS => {
			"*" => 45,
			"-" => 42,
			"/" => 46,
			"!" => 44,
			"^" => 47,
			")" => 82,
			"+" => 43
		}
	},
	{#State 73
		DEFAULT => -42
	},
	{#State 74
		DEFAULT => -44
	},
	{#State 75
		ACTIONS => {
			'UNIOP' => 29,
			"-" => 30,
			'EULER' => 33,
			'PI' => 32,
			'NUM' => 31,
			'BINOP' => 20,
			'NAN' => 28,
			"+" => 26,
			"(" => 27,
			"delay" => 25,
			'VAR' => 24,
			'INF' => 22
		},
		GOTOS => {
			'expr' => 21,
			'constant' => 23,
			'equation' => 83
		}
	},
	{#State 76
		ACTIONS => {
			'EULER' => 33,
			'PI' => 32,
			'NUM' => 31,
			"-" => 30,
			'UNIOP' => 29,
			'NAN' => 28,
			"(" => 27,
			"delay" => 25,
			"+" => 26,
			'VAR' => 24,
			'INF' => 22,
			'BINOP' => 20
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 21,
			'equation' => 84
		}
	},
	{#State 77
		ACTIONS => {
			'NUM' => 31,
			'PI' => 32,
			'EULER' => 33,
			'UNIOP' => 29,
			"-" => 30,
			'INF' => 22,
			'VAR' => 24,
			"+" => 26,
			"delay" => 25,
			"(" => 27,
			'NAN' => 28,
			'BINOP' => 20
		},
		GOTOS => {
			'constant' => 23,
			'expr' => 85
		}
	},
	{#State 78
		ACTIONS => {
			"+" => 26,
			"(" => 27,
			"delay" => 25,
			'NAN' => 28,
			'INF' => 22,
			'VAR' => 24,
			'BINOP' => 20,
			'EULER' => 33,
			'NUM' => 31,
			'PI' => 32,
			'UNIOP' => 29,
			"-" => 30
		},
		GOTOS => {
			'expr' => 21,
			'constant' => 23,
			'equation' => 86
		}
	},
	{#State 79
		DEFAULT => -34
	},
	{#State 80
		ACTIONS => {
			'VAR' => 68
		},
		GOTOS => {
			'argpairlist' => 87
		}
	},
	{#State 81
		ACTIONS => {
			'VAR' => 88
		}
	},
	{#State 82
		DEFAULT => -31
	},
	{#State 83
		ACTIONS => {
			'DESCRIPTION' => 90
		},
		DEFAULT => -15,
		GOTOS => {
			'OPTIONAL-4' => 89
		}
	},
	{#State 84
		ACTIONS => {
			'DESCRIPTION' => 92
		},
		DEFAULT => -13,
		GOTOS => {
			'OPTIONAL-3' => 91
		}
	},
	{#State 85
		ACTIONS => {
			"!" => 44,
			"*" => 45,
			"-" => 42,
			"/" => 46,
			")" => 93,
			"+" => 43,
			"^" => 47
		}
	},
	{#State 86
		DEFAULT => -41
	},
	{#State 87
		DEFAULT => -40
	},
	{#State 88
		ACTIONS => {
			")" => 94
		}
	},
	{#State 89
		DEFAULT => -18
	},
	{#State 90
		DEFAULT => -14
	},
	{#State 91
		DEFAULT => -17
	},
	{#State 92
		DEFAULT => -12
	},
	{#State 93
		DEFAULT => -32
	},
	{#State 94
		DEFAULT => -33
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1032 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 1036 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 1040 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1047 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1054 ./infix2pharmml_model.pm
	],
	[#Rule line_5
		 'line', 2, undef
#line 1058 ./infix2pharmml_model.pm
	],
	[#Rule assignment_6
		 'assignment', 1, undef
#line 1062 ./infix2pharmml_model.pm
	],
	[#Rule assignment_7
		 'assignment', 4,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1069 ./infix2pharmml_model.pm
	],
	[#Rule assignment_8
		 'assignment', 2,
sub {
#line 49 "infix2pharmml_model.eyp"
infix2pharmml::comment($_[1])}
#line 1076 ./infix2pharmml_model.pm
	],
	[#Rule assignment_9
		 'assignment', 2, undef
#line 1080 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1087 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1094 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1101 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1108 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 67 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1115 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 67 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1122 ./infix2pharmml_model.pm
	],
	[#Rule common_16
		 'common', 4,
sub {
#line 64 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1129 ./infix2pharmml_model.pm
	],
	[#Rule common_17
		 'common', 7,
sub {
#line 66 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1136 ./infix2pharmml_model.pm
	],
	[#Rule common_18
		 'common', 7,
sub {
#line 68 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1143 ./infix2pharmml_model.pm
	],
	[#Rule equation_19
		 'equation', 1,
sub {
#line 74 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1150 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1157 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1164 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1171 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1178 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1185 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1192 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 1,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1199 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 2,
sub {
#line 85 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1206 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
$_[2]}
#line 1213 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 2,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1220 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
$_[2]}
#line 1227 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 4,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1234 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 6,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1241 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 6,
sub {
#line 91 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1248 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1255 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 1,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1262 ./infix2pharmml_model.pm
	],
	[#Rule constant_36
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"notanumber"}
#line 1269 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"pi"}
#line 1276 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1283 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 104 "infix2pharmml_model.eyp"
"infinity"}
#line 1290 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_40
		 'argpairlist', 3,
sub {
#line 108 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1297 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_41
		 'argpairlist', 3,
sub {
#line 109 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1304 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_42
		 'macroargpairlist', 3,
sub {
#line 119 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1311 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_43
		 'macroargpairlist', 1,
sub {
#line 120 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1318 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_44
		 'macroargpairlist', 3,
sub {
#line 121 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1325 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_45
		 'parameterlist', 3,
sub {
#line 126 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1332 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_46
		 'parameterlist', 3,
sub {
#line 127 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1339 ./infix2pharmml_model.pm
	]
],
#line 1342 ./infix2pharmml_model.pm
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
         'assignment_6', 
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

#line 131 "infix2pharmml_model.eyp"



=for None

=cut


#line 1415 ./infix2pharmml_model.pm



1;
