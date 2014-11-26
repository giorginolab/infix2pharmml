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
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G\b(Absorption|Compartment|Depot|Effect|Elimination|IV|Oral|Peripheral|Transfer)\b/gc and return ('MACRO', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);
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


#line 71 ./infix2pharmml_model.pm

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
  [ 'assignment_8' => 'assignment', [ 'par', 'parameterlist' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'common_15' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'common_16' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'common_17' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'equation_18' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_19' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_20' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_21' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_25' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_26' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_27' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_28' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_29' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_30' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_31' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_32' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_33' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_34' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_35' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_36' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_37' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_38' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_39' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_40' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_41' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_42' => 'macroargpairlist', [ 'equation' ], 0 ],
  [ 'macroargpairlist_43' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'parameterlist_44' => 'parameterlist', [ 'parameterlist', ',', 'parameterlist' ], 0 ],
  [ 'parameterlist_45' => 'parameterlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  '_OPTIONAL' => 11,
  '_OPTIONAL' => 12,
  '_OPTIONAL' => 13,
  '_OPTIONAL' => 14,
  'common_15' => 15,
  'common_16' => 16,
  'common_17' => 17,
  'equation_18' => 18,
  'expr_19' => 19,
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
  'constant_35' => 35,
  'constant_36' => 36,
  'constant_37' => 37,
  'constant_38' => 38,
  'argpairlist_39' => 39,
  'argpairlist_40' => 40,
  'macroargpairlist_41' => 41,
  'macroargpairlist_42' => 42,
  'macroargpairlist_43' => 43,
  'parameterlist_44' => 44,
  'parameterlist_45' => 45,
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
		DEFAULT => -6
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
		DEFAULT => -5
	},
	{#State 11
		DEFAULT => 0
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			"delay" => 27,
			'UNIOP' => 26,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 31,
			'PI' => 33,
			'BINOP' => 32
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 21,
			'macroargpairlist' => 25
		}
	},
	{#State 14
		ACTIONS => {
			"," => 34
		},
		DEFAULT => -8
	},
	{#State 15
		ACTIONS => {
			"=" => 35
		}
	},
	{#State 16
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 36
		}
	},
	{#State 17
		ACTIONS => {
			"," => 38
		}
	},
	{#State 18
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 39,
			'constant' => 28
		}
	},
	{#State 19
		DEFAULT => -35
	},
	{#State 20
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 40,
			'constant' => 28
		}
	},
	{#State 21
		DEFAULT => -42
	},
	{#State 22
		DEFAULT => -24
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		ACTIONS => {
			"-" => 41,
			"+" => 42,
			"!" => 43,
			"^" => 44,
			"*" => 45,
			"/" => 46
		},
		DEFAULT => -18
	},
	{#State 25
		ACTIONS => {
			"," => 47,
			")" => 48
		}
	},
	{#State 26
		ACTIONS => {
			"(" => 49
		}
	},
	{#State 27
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 28
		DEFAULT => -25
	},
	{#State 29
		DEFAULT => -37
	},
	{#State 30
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 51,
			'constant' => 28
		}
	},
	{#State 31
		ACTIONS => {
			"=" => 52,
			"(" => 53
		},
		DEFAULT => -34
	},
	{#State 32
		ACTIONS => {
			"(" => 54
		}
	},
	{#State 33
		DEFAULT => -36
	},
	{#State 34
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'parameterlist' => 55
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 56
		}
	},
	{#State 36
		ACTIONS => {
			'DESCRIPTION' => 58
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-2' => 57
		}
	},
	{#State 37
		ACTIONS => {
			"(" => 53
		},
		DEFAULT => -34
	},
	{#State 38
		ACTIONS => {
			'VAR' => 59
		}
	},
	{#State 39
		DEFAULT => -28
	},
	{#State 40
		ACTIONS => {
			"!" => 43,
			"^" => 44,
			"*" => 45,
			"/" => 46
		},
		DEFAULT => -27
	},
	{#State 41
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 60,
			'constant' => 28
		}
	},
	{#State 42
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 61,
			'constant' => 28
		}
	},
	{#State 43
		DEFAULT => -26
	},
	{#State 44
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 62,
			'constant' => 28
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 63,
			'constant' => 28
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 28
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 31,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 21,
			'macroargpairlist' => 65
		}
	},
	{#State 48
		DEFAULT => -7
	},
	{#State 49
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 66,
			'constant' => 28
		}
	},
	{#State 50
		ACTIONS => {
			'VAR' => 67
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 41,
			"^" => 44,
			"!" => 43,
			"*" => 45,
			"+" => 42,
			"/" => 46,
			")" => 68
		}
	},
	{#State 52
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 69
		}
	},
	{#State 53
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 70
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 72,
			'constant' => 28
		}
	},
	{#State 55
		DEFAULT => -44
	},
	{#State 56
		DEFAULT => -45
	},
	{#State 57
		DEFAULT => -15
	},
	{#State 58
		DEFAULT => -9
	},
	{#State 59
		ACTIONS => {
			"):=" => 73,
			")=" => 74
		}
	},
	{#State 60
		ACTIONS => {
			"!" => 43,
			"^" => 44,
			"*" => 45,
			"/" => 46
		},
		DEFAULT => -20
	},
	{#State 61
		ACTIONS => {
			"!" => 43,
			"^" => 44,
			"*" => 45,
			"/" => 46
		},
		DEFAULT => -19
	},
	{#State 62
		ACTIONS => {
			"!" => 43,
			"^" => 44
		},
		DEFAULT => -23
	},
	{#State 63
		ACTIONS => {
			"!" => 43,
			"^" => 44
		},
		DEFAULT => -21
	},
	{#State 64
		ACTIONS => {
			"!" => 43,
			"^" => 44
		},
		DEFAULT => -22
	},
	{#State 65
		DEFAULT => -41
	},
	{#State 66
		ACTIONS => {
			"-" => 41,
			"^" => 44,
			"!" => 43,
			"*" => 45,
			"+" => 42,
			"/" => 46,
			")" => 75
		}
	},
	{#State 67
		ACTIONS => {
			"," => 76
		}
	},
	{#State 68
		DEFAULT => -29
	},
	{#State 69
		DEFAULT => -43
	},
	{#State 70
		ACTIONS => {
			"," => 77,
			")" => 78
		}
	},
	{#State 71
		ACTIONS => {
			"=" => 79
		}
	},
	{#State 72
		ACTIONS => {
			"-" => 41,
			"^" => 44,
			"!" => 43,
			"*" => 45,
			"+" => 42,
			"/" => 46,
			"," => 80
		}
	},
	{#State 73
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 81
		}
	},
	{#State 74
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 82
		}
	},
	{#State 75
		DEFAULT => -30
	},
	{#State 76
		ACTIONS => {
			'VAR' => 83
		}
	},
	{#State 77
		ACTIONS => {
			'VAR' => 71
		},
		GOTOS => {
			'argpairlist' => 84
		}
	},
	{#State 78
		DEFAULT => -33
	},
	{#State 79
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 24,
			'constant' => 28,
			'equation' => 85
		}
	},
	{#State 80
		ACTIONS => {
			"-" => 18,
			'NAN' => 19,
			"+" => 20,
			'UNIOP' => 26,
			"delay" => 27,
			'EULER' => 29,
			'NUM' => 22,
			"(" => 30,
			'INF' => 23,
			'VAR' => 37,
			'BINOP' => 32,
			'PI' => 33
		},
		GOTOS => {
			'expr' => 86,
			'constant' => 28
		}
	},
	{#State 81
		ACTIONS => {
			'DESCRIPTION' => 87
		},
		DEFAULT => -14,
		GOTOS => {
			'OPTIONAL-4' => 88
		}
	},
	{#State 82
		ACTIONS => {
			'DESCRIPTION' => 89
		},
		DEFAULT => -12,
		GOTOS => {
			'OPTIONAL-3' => 90
		}
	},
	{#State 83
		ACTIONS => {
			")" => 91
		}
	},
	{#State 84
		DEFAULT => -39
	},
	{#State 85
		DEFAULT => -40
	},
	{#State 86
		ACTIONS => {
			"-" => 41,
			"^" => 44,
			"!" => 43,
			"*" => 45,
			"+" => 42,
			"/" => 46,
			")" => 92
		}
	},
	{#State 87
		DEFAULT => -13
	},
	{#State 88
		DEFAULT => -17
	},
	{#State 89
		DEFAULT => -11
	},
	{#State 90
		DEFAULT => -16
	},
	{#State 91
		DEFAULT => -32
	},
	{#State 92
		DEFAULT => -31
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1017 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 1021 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 1025 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1032 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1039 ./infix2pharmml_model.pm
	],
	[#Rule line_5
		 'line', 2, undef
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule assignment_6
		 'assignment', 1, undef
#line 1047 ./infix2pharmml_model.pm
	],
	[#Rule assignment_7
		 'assignment', 4,
sub {
#line 46 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1054 ./infix2pharmml_model.pm
	],
	[#Rule assignment_8
		 'assignment', 2, undef
#line 1058 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 61 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1065 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 61 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1072 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 62 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1079 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 62 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1086 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1093 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 64 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1100 ./infix2pharmml_model.pm
	],
	[#Rule common_15
		 'common', 4,
sub {
#line 61 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1107 ./infix2pharmml_model.pm
	],
	[#Rule common_16
		 'common', 7,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1114 ./infix2pharmml_model.pm
	],
	[#Rule common_17
		 'common', 7,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1121 ./infix2pharmml_model.pm
	],
	[#Rule equation_18
		 'equation', 1,
sub {
#line 71 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 1128 ./infix2pharmml_model.pm
	],
	[#Rule expr_19
		 'expr', 3,
sub {
#line 75 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1135 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 76 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1142 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 3,
sub {
#line 77 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1149 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 3,
sub {
#line 78 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1156 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 79 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1163 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 1,
sub {
#line 80 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1170 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 1,
sub {
#line 81 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1177 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 2,
sub {
#line 82 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1184 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 2,
sub {
#line 83 "infix2pharmml_model.eyp"
$_[2]}
#line 1191 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 2,
sub {
#line 84 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1198 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 85 "infix2pharmml_model.eyp"
$_[2]}
#line 1205 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 4,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1212 ./infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 6,
sub {
#line 87 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1219 ./infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 6,
sub {
#line 88 "infix2pharmml_model.eyp"
my $d = $_[5]; my $v = $_[3]; infix2pharmml::delay($v,$d)}
#line 1226 ./infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 4,
sub {
#line 89 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1233 ./infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 1,
sub {
#line 90 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1240 ./infix2pharmml_model.pm
	],
	[#Rule constant_35
		 'constant', 1,
sub {
#line 98 "infix2pharmml_model.eyp"
"notanumber"}
#line 1247 ./infix2pharmml_model.pm
	],
	[#Rule constant_36
		 'constant', 1,
sub {
#line 99 "infix2pharmml_model.eyp"
"pi"}
#line 1254 ./infix2pharmml_model.pm
	],
	[#Rule constant_37
		 'constant', 1,
sub {
#line 100 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1261 ./infix2pharmml_model.pm
	],
	[#Rule constant_38
		 'constant', 1,
sub {
#line 101 "infix2pharmml_model.eyp"
"infinity"}
#line 1268 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_39
		 'argpairlist', 3,
sub {
#line 105 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1275 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_40
		 'argpairlist', 3,
sub {
#line 106 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1282 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_41
		 'macroargpairlist', 3,
sub {
#line 116 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1289 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_42
		 'macroargpairlist', 1,
sub {
#line 117 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1296 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_43
		 'macroargpairlist', 3,
sub {
#line 118 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1303 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_44
		 'parameterlist', 3,
sub {
#line 123 "infix2pharmml_model.eyp"
$_[1].$_[3]}
#line 1310 ./infix2pharmml_model.pm
	],
	[#Rule parameterlist_45
		 'parameterlist', 3,
sub {
#line 124 "infix2pharmml_model.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1317 ./infix2pharmml_model.pm
	]
],
#line 1320 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_15', 
         'common_16', 
         'common_17', 
         'equation_18', 
         'expr_19', 
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
         'constant_35', 
         'constant_36', 
         'constant_37', 
         'constant_38', 
         'argpairlist_39', 
         'argpairlist_40', 
         'macroargpairlist_41', 
         'macroargpairlist_42', 
         'macroargpairlist_43', 
         'parameterlist_44', 
         'parameterlist_45', );
  $self;
}

#line 128 "infix2pharmml_model.eyp"



=for None

=cut


#line 1392 ./infix2pharmml_model.pm



1;
