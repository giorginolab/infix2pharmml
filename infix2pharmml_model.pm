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

      m{\G(delay|diff\(|par|\)\:\=|\)\=|\:\=|\*|\!|\(|\)|\,|\=|\^|\/|\;|\-|\+)}gc and return ($1, $1);

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
  [ 'assignment_6' => 'assignment', [ 'common' ], 0 ],
  [ 'assignment_7' => 'assignment', [ 'MACRO', '(', 'macroargpairlist', ')' ], 0 ],
  [ 'assignment_8' => 'assignment', [ 'COMMENT' ], 0 ],
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
			"diff(" => 3,
			'MACRO' => 5,
			"par" => 2,
			'VAR' => 7,
			'COMMENT' => 1
		},
		GOTOS => {
			'common' => 9,
			'line' => 4,
			'assignment' => 8,
			'model' => 6
		}
	},
	{#State 1
		DEFAULT => -8
	},
	{#State 2
		ACTIONS => {
			'VAR' => 10
		},
		GOTOS => {
			'parameterlist' => 11
		}
	},
	{#State 3
		ACTIONS => {
			'VAR' => 12
		}
	},
	{#State 4
		DEFAULT => -2
	},
	{#State 5
		ACTIONS => {
			"(" => 13
		}
	},
	{#State 6
		ACTIONS => {
			'COMMENT' => 1,
			'VAR' => 7,
			"par" => 2,
			'MACRO' => 5,
			'' => 14,
			"diff(" => 3
		},
		GOTOS => {
			'assignment' => 8,
			'common' => 9,
			'line' => 15
		}
	},
	{#State 7
		ACTIONS => {
			":=" => 16
		}
	},
	{#State 8
		ACTIONS => {
			";" => 17
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 18
		}
	},
	{#State 9
		DEFAULT => -6
	},
	{#State 10
		ACTIONS => {
			"=" => 19
		}
	},
	{#State 11
		ACTIONS => {
			"," => 20
		},
		DEFAULT => -9
	},
	{#State 12
		ACTIONS => {
			"," => 21
		}
	},
	{#State 13
		ACTIONS => {
			"-" => 22,
			"+" => 24,
			'NUM' => 33,
			"(" => 34,
			'EULER' => 26,
			'BINOP' => 35,
			'NAN' => 36,
			'UNIOP' => 28,
			'INF' => 37,
			'VAR' => 29,
			'PI' => 30,
			"delay" => 31
		},
		GOTOS => {
			'equation' => 23,
			'expr' => 27,
			'macroargpairlist' => 32,
			'constant' => 25
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
			'EULER' => 26,
			"(" => 34,
			"+" => 24,
			'NUM' => 33,
			"-" => 22,
			"delay" => 31,
			'PI' => 30,
			'VAR' => 39,
			'INF' => 37,
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36
		},
		GOTOS => {
			'equation' => 38,
			'expr' => 27,
			'constant' => 25
		}
	},
	{#State 17
		DEFAULT => -3
	},
	{#State 18
		DEFAULT => -5
	},
	{#State 19
		ACTIONS => {
			'NUM' => 33,
			"+" => 24,
			"-" => 22,
			'EULER' => 26,
			"(" => 34,
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36,
			'PI' => 30,
			"delay" => 31,
			'INF' => 37,
			'VAR' => 39
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 40,
			'constant' => 25
		}
	},
	{#State 20
		ACTIONS => {
			'VAR' => 10
		},
		GOTOS => {
			'parameterlist' => 41
		}
	},
	{#State 21
		ACTIONS => {
			'VAR' => 42
		}
	},
	{#State 22
		ACTIONS => {
			'BINOP' => 35,
			'NAN' => 36,
			'UNIOP' => 28,
			'INF' => 37,
			'VAR' => 39,
			"delay" => 31,
			'PI' => 30,
			"-" => 22,
			"+" => 24,
			'NUM' => 33,
			"(" => 34,
			'EULER' => 26
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 25
		}
	},
	{#State 23
		DEFAULT => -43
	},
	{#State 24
		ACTIONS => {
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			'VAR' => 39,
			'INF' => 37,
			"delay" => 31,
			'PI' => 30,
			"-" => 22,
			'NUM' => 33,
			"+" => 24,
			"(" => 34,
			'EULER' => 26
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 25
		}
	},
	{#State 25
		DEFAULT => -26
	},
	{#State 26
		DEFAULT => -38
	},
	{#State 27
		ACTIONS => {
			"!" => 45,
			"*" => 46,
			"/" => 49,
			"^" => 50,
			"+" => 48,
			"-" => 47
		},
		DEFAULT => -19
	},
	{#State 28
		ACTIONS => {
			"(" => 51
		}
	},
	{#State 29
		ACTIONS => {
			"(" => 52,
			"=" => 53
		},
		DEFAULT => -35
	},
	{#State 30
		DEFAULT => -37
	},
	{#State 31
		ACTIONS => {
			"(" => 54
		}
	},
	{#State 32
		ACTIONS => {
			")" => 55,
			"," => 56
		}
	},
	{#State 33
		DEFAULT => -25
	},
	{#State 34
		ACTIONS => {
			'INF' => 37,
			'VAR' => 39,
			'PI' => 30,
			"delay" => 31,
			'BINOP' => 35,
			'NAN' => 36,
			'UNIOP' => 28,
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24
		},
		GOTOS => {
			'expr' => 57,
			'constant' => 25
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 58
		}
	},
	{#State 36
		DEFAULT => -36
	},
	{#State 37
		DEFAULT => -39
	},
	{#State 38
		ACTIONS => {
			'DESCRIPTION' => 60
		},
		DEFAULT => -11,
		GOTOS => {
			'OPTIONAL-2' => 59
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 52
		},
		DEFAULT => -35
	},
	{#State 40
		DEFAULT => -46
	},
	{#State 41
		DEFAULT => -45
	},
	{#State 42
		ACTIONS => {
			"):=" => 61,
			")=" => 62
		}
	},
	{#State 43
		DEFAULT => -29
	},
	{#State 44
		ACTIONS => {
			"*" => 46,
			"!" => 45,
			"^" => 50,
			"/" => 49
		},
		DEFAULT => -28
	},
	{#State 45
		DEFAULT => -27
	},
	{#State 46
		ACTIONS => {
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24,
			'VAR' => 39,
			'INF' => 37,
			'PI' => 30,
			"delay" => 31,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 63
		}
	},
	{#State 47
		ACTIONS => {
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			'INF' => 37,
			'VAR' => 39,
			'PI' => 30,
			"delay" => 31,
			"-" => 22,
			"+" => 24,
			'NUM' => 33,
			"(" => 34,
			'EULER' => 26
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 25
		}
	},
	{#State 48
		ACTIONS => {
			'VAR' => 39,
			'INF' => 37,
			'PI' => 30,
			"delay" => 31,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			"+" => 24,
			'NUM' => 33
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 65
		}
	},
	{#State 49
		ACTIONS => {
			"-" => 22,
			"+" => 24,
			'NUM' => 33,
			"(" => 34,
			'EULER' => 26,
			'BINOP' => 35,
			'NAN' => 36,
			'UNIOP' => 28,
			'INF' => 37,
			'VAR' => 39,
			'PI' => 30,
			"delay" => 31
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 66
		}
	},
	{#State 50
		ACTIONS => {
			"delay" => 31,
			'PI' => 30,
			'INF' => 37,
			'VAR' => 39,
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36,
			'EULER' => 26,
			"(" => 34,
			'NUM' => 33,
			"+" => 24,
			"-" => 22
		},
		GOTOS => {
			'expr' => 67,
			'constant' => 25
		}
	},
	{#State 51
		ACTIONS => {
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24,
			'VAR' => 39,
			'INF' => 37,
			'PI' => 30,
			"delay" => 31,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 68
		}
	},
	{#State 52
		ACTIONS => {
			'VAR' => 70
		},
		GOTOS => {
			'argpairlist' => 69
		}
	},
	{#State 53
		ACTIONS => {
			"delay" => 31,
			'PI' => 30,
			'VAR' => 39,
			'INF' => 37,
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36,
			'EULER' => 26,
			"(" => 34,
			"+" => 24,
			'NUM' => 33,
			"-" => 22
		},
		GOTOS => {
			'equation' => 71,
			'expr' => 27,
			'constant' => 25
		}
	},
	{#State 54
		ACTIONS => {
			'VAR' => 72
		}
	},
	{#State 55
		DEFAULT => -7
	},
	{#State 56
		ACTIONS => {
			'INF' => 37,
			'VAR' => 29,
			"delay" => 31,
			'PI' => 30,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24
		},
		GOTOS => {
			'expr' => 27,
			'macroargpairlist' => 73,
			'equation' => 23,
			'constant' => 25
		}
	},
	{#State 57
		ACTIONS => {
			"^" => 50,
			"*" => 46,
			")" => 74,
			"+" => 48,
			"/" => 49,
			"-" => 47,
			"!" => 45
		}
	},
	{#State 58
		ACTIONS => {
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24,
			'INF' => 37,
			'VAR' => 39,
			"delay" => 31,
			'PI' => 30,
			'BINOP' => 35,
			'NAN' => 36,
			'UNIOP' => 28
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 75
		}
	},
	{#State 59
		DEFAULT => -16
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			'INF' => 37,
			'VAR' => 39,
			"delay" => 31,
			'PI' => 30,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24
		},
		GOTOS => {
			'expr' => 27,
			'equation' => 76,
			'constant' => 25
		}
	},
	{#State 62
		ACTIONS => {
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36,
			"delay" => 31,
			'PI' => 30,
			'VAR' => 39,
			'INF' => 37,
			"+" => 24,
			'NUM' => 33,
			"-" => 22,
			'EULER' => 26,
			"(" => 34
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 27,
			'equation' => 77
		}
	},
	{#State 63
		ACTIONS => {
			"!" => 45,
			"^" => 50
		},
		DEFAULT => -22
	},
	{#State 64
		ACTIONS => {
			"^" => 50,
			"/" => 49,
			"*" => 46,
			"!" => 45
		},
		DEFAULT => -21
	},
	{#State 65
		ACTIONS => {
			"*" => 46,
			"!" => 45,
			"^" => 50,
			"/" => 49
		},
		DEFAULT => -20
	},
	{#State 66
		ACTIONS => {
			"^" => 50,
			"!" => 45
		},
		DEFAULT => -23
	},
	{#State 67
		ACTIONS => {
			"^" => 50,
			"!" => 45
		},
		DEFAULT => -24
	},
	{#State 68
		ACTIONS => {
			"+" => 48,
			"!" => 45,
			"-" => 47,
			"/" => 49,
			"^" => 50,
			"*" => 46,
			")" => 78
		}
	},
	{#State 69
		ACTIONS => {
			")" => 79,
			"," => 80
		}
	},
	{#State 70
		ACTIONS => {
			"=" => 81
		}
	},
	{#State 71
		DEFAULT => -44
	},
	{#State 72
		ACTIONS => {
			"," => 82
		}
	},
	{#State 73
		DEFAULT => -42
	},
	{#State 74
		DEFAULT => -30
	},
	{#State 75
		ACTIONS => {
			"*" => 46,
			"^" => 50,
			"," => 83,
			"!" => 45,
			"-" => 47,
			"/" => 49,
			"+" => 48
		}
	},
	{#State 76
		ACTIONS => {
			'DESCRIPTION' => 85
		},
		DEFAULT => -15,
		GOTOS => {
			'OPTIONAL-4' => 84
		}
	},
	{#State 77
		ACTIONS => {
			'DESCRIPTION' => 87
		},
		DEFAULT => -13,
		GOTOS => {
			'OPTIONAL-3' => 86
		}
	},
	{#State 78
		DEFAULT => -31
	},
	{#State 79
		DEFAULT => -34
	},
	{#State 80
		ACTIONS => {
			'VAR' => 70
		},
		GOTOS => {
			'argpairlist' => 88
		}
	},
	{#State 81
		ACTIONS => {
			"delay" => 31,
			'PI' => 30,
			'INF' => 37,
			'VAR' => 39,
			'UNIOP' => 28,
			'BINOP' => 35,
			'NAN' => 36,
			'EULER' => 26,
			"(" => 34,
			"+" => 24,
			'NUM' => 33,
			"-" => 22
		},
		GOTOS => {
			'constant' => 25,
			'expr' => 27,
			'equation' => 89
		}
	},
	{#State 82
		ACTIONS => {
			'VAR' => 90
		}
	},
	{#State 83
		ACTIONS => {
			'VAR' => 39,
			'INF' => 37,
			"delay" => 31,
			'PI' => 30,
			'NAN' => 36,
			'BINOP' => 35,
			'UNIOP' => 28,
			"(" => 34,
			'EULER' => 26,
			"-" => 22,
			'NUM' => 33,
			"+" => 24
		},
		GOTOS => {
			'expr' => 91,
			'constant' => 25
		}
	},
	{#State 84
		DEFAULT => -18
	},
	{#State 85
		DEFAULT => -14
	},
	{#State 86
		DEFAULT => -17
	},
	{#State 87
		DEFAULT => -12
	},
	{#State 88
		DEFAULT => -40
	},
	{#State 89
		DEFAULT => -41
	},
	{#State 90
		ACTIONS => {
			")" => 92
		}
	},
	{#State 91
		ACTIONS => {
			"+" => 48,
			"!" => 45,
			"/" => 49,
			"-" => 47,
			"^" => 50,
			"*" => 46,
			")" => 93
		}
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
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1041 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 42 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1048 ./infix2pharmml_model.pm
	],
	[#Rule line_5
		 'line', 2, undef
#line 1052 ./infix2pharmml_model.pm
	],
	[#Rule assignment_6
		 'assignment', 1, undef
#line 1056 ./infix2pharmml_model.pm
	],
	[#Rule assignment_7
		 'assignment', 4,
sub {
#line 48 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1063 ./infix2pharmml_model.pm
	],
	[#Rule assignment_8
		 'assignment', 1,
sub {
#line 49 "infix2pharmml_model.eyp"
infix2pharmml::comment($_[1])}
#line 1070 ./infix2pharmml_model.pm
	],
	[#Rule assignment_9
		 'assignment', 2, undef
#line 1074 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1081 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1088 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1095 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 65 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1102 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 67 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1109 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 67 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1116 ./infix2pharmml_model.pm
	],
	[#Rule common_16
		 'common', 4,
sub {
#line 64 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1123 ./infix2pharmml_model.pm
	],
	[#Rule common_17
		 'common', 7,
sub {
#line 66 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1130 ./infix2pharmml_model.pm
	],
	[#Rule common_18
		 'common', 7,
sub {
#line 68 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1137 ./infix2pharmml_model.pm
	],
	[#Rule equation_19
		 'equation', 1,
sub {
#line 74 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1144 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1151 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1158 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1165 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1172 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 3,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1179 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1186 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 1,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1193 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 2,
sub {
#line 85 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1200 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 86 "infix2pharmml_model.eyp"
$_[2]}
#line 1207 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 2,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1214 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
$_[2]}
#line 1221 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 4,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1228 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 6,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1235 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 6,
sub {
#line 91 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1242 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 4,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1249 ./infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 1,
sub {
#line 93 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1256 ./infix2pharmml_model.pm
	],
	[#Rule constant_36
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"notanumber"}
#line 1263 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 102 "infix2pharmml_model.eyp"
"pi"}
#line 1270 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 103 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1277 ./infix2pharmml_model.pm
	],
	[#Rule constant_39
		 'constant', 1,
sub {
#line 104 "infix2pharmml_model.eyp"
"infinity"}
#line 1284 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_40
		 'argpairlist', 3,
sub {
#line 108 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1291 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_41
		 'argpairlist', 3,
sub {
#line 109 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1298 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_42
		 'macroargpairlist', 3,
sub {
#line 119 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1305 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_43
		 'macroargpairlist', 1,
sub {
#line 120 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1312 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_44
		 'macroargpairlist', 3,
sub {
#line 121 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1319 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_45
		 'parameterlist', 3,
sub {
#line 126 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1326 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_46
		 'parameterlist', 3,
sub {
#line 127 "infix2pharmml_model.eyp"
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


#line 1409 ./infix2pharmml_model.pm



1;
