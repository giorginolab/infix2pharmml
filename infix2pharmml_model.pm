########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.21.
#
# Copyright © 2006, 2007, 2008, 2009, 2010, 2011, 2012 Casiano Rodriguez-Leon.
# Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
# Parse::Yapp is Copyright © 1998, 1999, 2000, 2001, Francois Desarmenien.
# Parse::Yapp is Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
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

      m{\G(diff\(|delay|\)\:\=|\)\=|\:\=|\*|\-|\^|\)|\+|\=|\(|\/|\;|\,|\!)}gc and return ($1, $1);

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
      /\G\{(.+?)\}/gc and return ('DESCRIPTION', $1);


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


#line 79 infix2pharmml_model.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@infix2pharmml_model::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.21',
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
			'VAR' => 6,
			'COMMENT' => 4,
			'MACRO' => 9,
			'PAR' => 3,
			"diff(" => 10
		},
		GOTOS => {
			'assignment' => 7,
			'model' => 2,
			'line' => 8,
			'common' => 5,
			'PLUS-1' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'VAR' => 6,
			"diff(" => 10,
			'MACRO' => 9,
			'COMMENT' => 4,
			'PAR' => 3
		},
		DEFAULT => -3,
		GOTOS => {
			'assignment' => 7,
			'line' => 11,
			'common' => 5
		}
	},
	{#State 2
		ACTIONS => {
			'' => 12
		}
	},
	{#State 3
		ACTIONS => {
			'VAR' => 14
		},
		GOTOS => {
			'parameterlist' => 13
		}
	},
	{#State 4
		DEFAULT => -8
	},
	{#State 5
		DEFAULT => -10
	},
	{#State 6
		ACTIONS => {
			":=" => 15
		}
	},
	{#State 7
		ACTIONS => {
			";" => 16
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
			"(" => 18
		}
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
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			"," => 20
		},
		DEFAULT => -12
	},
	{#State 14
		ACTIONS => {
			"=" => 21
		}
	},
	{#State 15
		ACTIONS => {
			'PI' => 29,
			"-" => 30,
			'BINOP' => 33,
			"delay" => 32,
			"(" => 31,
			'NAN' => 23,
			'INF' => 24,
			'NUM' => 25,
			'EULER' => 26,
			'UNIOP' => 27,
			'VAR' => 28
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 34
		}
	},
	{#State 16
		DEFAULT => -4
	},
	{#State 17
		ACTIONS => {
			'COMMENT' => 35
		},
		DEFAULT => -7,
		GOTOS => {
			'OPTIONAL-3' => 36
		}
	},
	{#State 18
		ACTIONS => {
			'NAN' => 23,
			"-" => 30,
			'PI' => 29,
			'INF' => 24,
			'BINOP' => 33,
			"delay" => 32,
			'VAR' => 37,
			"(" => 31,
			'UNIOP' => 27,
			'EULER' => 26,
			'NUM' => 25
		},
		GOTOS => {
			'macroargpairlist' => 38,
			'constant' => 22,
			'expr' => 39
		}
	},
	{#State 19
		ACTIONS => {
			"," => 40
		}
	},
	{#State 20
		ACTIONS => {
			'VAR' => 14
		},
		GOTOS => {
			'parameterlist' => 41
		}
	},
	{#State 21
		ACTIONS => {
			'INF' => 24,
			'NUM' => 42,
			'BINOP' => 33,
			"delay" => 32,
			"(" => 31,
			'VAR' => 28,
			'EULER' => 26,
			'UNIOP' => 27,
			'NAN' => 23,
			'PI' => 29,
			"-" => 30
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 43
		}
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -43
	},
	{#State 24
		DEFAULT => -46
	},
	{#State 25
		DEFAULT => -33
	},
	{#State 26
		DEFAULT => -45
	},
	{#State 27
		ACTIONS => {
			"(" => 44
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 45
		},
		DEFAULT => -42
	},
	{#State 29
		DEFAULT => -44
	},
	{#State 30
		ACTIONS => {
			'INF' => 24,
			'BINOP' => 33,
			"delay" => 32,
			"(" => 31,
			'EULER' => 26,
			'UNIOP' => 27,
			'VAR' => 28,
			'NUM' => 25,
			'NAN' => 23,
			"-" => 30,
			'PI' => 29
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 46
		}
	},
	{#State 31
		ACTIONS => {
			"delay" => 32,
			'BINOP' => 33,
			"(" => 31,
			'PI' => 29,
			"-" => 30,
			'INF' => 24,
			'NUM' => 25,
			'UNIOP' => 27,
			'VAR' => 28,
			'EULER' => 26,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 47
		}
	},
	{#State 32
		ACTIONS => {
			"(" => 48
		}
	},
	{#State 33
		ACTIONS => {
			"(" => 49
		}
	},
	{#State 34
		ACTIONS => {
			"+" => 51,
			"!" => 50,
			"*" => 54,
			"/" => 53,
			"-" => 55,
			'DESCRIPTION' => 56,
			"^" => 57
		},
		DEFAULT => -20,
		GOTOS => {
			'OPTIONAL-4' => 52
		}
	},
	{#State 35
		DEFAULT => -6
	},
	{#State 36
		DEFAULT => -9
	},
	{#State 37
		ACTIONS => {
			"=" => 58,
			"(" => 45
		},
		DEFAULT => -42
	},
	{#State 38
		ACTIONS => {
			"," => 60,
			")" => 59
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 55,
			"^" => 57,
			"+" => 51,
			"!" => 50,
			"/" => 53,
			"*" => 54
		},
		DEFAULT => -14
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
			"/" => -33,
			"*" => -33,
			"^" => -33,
			"-" => -33,
			"!" => -33,
			"+" => -33
		},
		DEFAULT => -17
	},
	{#State 43
		ACTIONS => {
			"!" => 50,
			"+" => 51,
			"*" => 54,
			"/" => 53,
			"^" => 57,
			"-" => 55
		},
		DEFAULT => -18
	},
	{#State 44
		ACTIONS => {
			'NUM' => 25,
			"delay" => 32,
			'BINOP' => 33,
			'UNIOP' => 27,
			'VAR' => 28,
			'EULER' => 26,
			"(" => 31,
			'INF' => 24,
			'PI' => 29,
			"-" => 30,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 62
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
		DEFAULT => -36
	},
	{#State 47
		ACTIONS => {
			"^" => 57,
			"-" => 55,
			"!" => 50,
			"+" => 51,
			"/" => 53,
			")" => 65,
			"*" => 54
		}
	},
	{#State 48
		ACTIONS => {
			'VAR' => 66
		}
	},
	{#State 49
		ACTIONS => {
			'NAN' => 23,
			"-" => 30,
			'PI' => 29,
			'INF' => 24,
			'VAR' => 28,
			'UNIOP' => 27,
			'EULER' => 26,
			"(" => 31,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 25
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 67
		}
	},
	{#State 50
		DEFAULT => -35
	},
	{#State 51
		ACTIONS => {
			'PI' => 29,
			"-" => 30,
			'NAN' => 23,
			'NUM' => 25,
			"delay" => 32,
			'BINOP' => 33,
			'VAR' => 28,
			'UNIOP' => 27,
			'EULER' => 26,
			"(" => 31,
			'INF' => 24
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 68
		}
	},
	{#State 52
		DEFAULT => -25
	},
	{#State 53
		ACTIONS => {
			'NUM' => 25,
			'BINOP' => 33,
			"delay" => 32,
			'EULER' => 26,
			"(" => 31,
			'UNIOP' => 27,
			'VAR' => 28,
			'INF' => 24,
			'PI' => 29,
			"-" => 30,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 69
		}
	},
	{#State 54
		ACTIONS => {
			"-" => 30,
			'PI' => 29,
			'NAN' => 23,
			'VAR' => 28,
			'EULER' => 26,
			'UNIOP' => 27,
			"(" => 31,
			'BINOP' => 33,
			"delay" => 32,
			'NUM' => 25,
			'INF' => 24
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 70
		}
	},
	{#State 55
		ACTIONS => {
			"(" => 31,
			"delay" => 32,
			'BINOP' => 33,
			'PI' => 29,
			"-" => 30,
			'INF' => 24,
			'NUM' => 25,
			'UNIOP' => 27,
			'VAR' => 28,
			'EULER' => 26,
			'NAN' => 23
		},
		GOTOS => {
			'expr' => 71,
			'constant' => 22
		}
	},
	{#State 56
		DEFAULT => -19
	},
	{#State 57
		ACTIONS => {
			'PI' => 29,
			"-" => 30,
			'NAN' => 23,
			'NUM' => 25,
			'BINOP' => 33,
			"delay" => 32,
			'UNIOP' => 27,
			'EULER' => 26,
			'VAR' => 28,
			"(" => 31,
			'INF' => 24
		},
		GOTOS => {
			'expr' => 72,
			'constant' => 22
		}
	},
	{#State 58
		ACTIONS => {
			"-" => 30,
			'PI' => 29,
			'NAN' => 23,
			'VAR' => 28,
			"(" => 31,
			'EULER' => 26,
			'UNIOP' => 27,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 25,
			'INF' => 24
		},
		GOTOS => {
			'expr' => 73,
			'constant' => 22
		}
	},
	{#State 59
		DEFAULT => -11
	},
	{#State 60
		ACTIONS => {
			'NUM' => 25,
			'BINOP' => 33,
			"delay" => 32,
			'VAR' => 37,
			'EULER' => 26,
			'UNIOP' => 27,
			"(" => 31,
			'INF' => 24,
			'PI' => 29,
			"-" => 30,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'macroargpairlist' => 74,
			'expr' => 39
		}
	},
	{#State 61
		ACTIONS => {
			")=" => 76,
			"):=" => 75
		}
	},
	{#State 62
		ACTIONS => {
			"!" => 50,
			"+" => 51,
			"-" => 55,
			"^" => 57,
			"*" => 54,
			")" => 77,
			"/" => 53
		}
	},
	{#State 63
		ACTIONS => {
			")" => 79,
			"," => 78
		}
	},
	{#State 64
		ACTIONS => {
			"=" => 80
		}
	},
	{#State 65
		DEFAULT => -37
	},
	{#State 66
		ACTIONS => {
			"," => 81
		}
	},
	{#State 67
		ACTIONS => {
			"*" => 54,
			"/" => 53,
			"," => 82,
			"+" => 51,
			"!" => 50,
			"^" => 57,
			"-" => 55
		}
	},
	{#State 68
		ACTIONS => {
			"^" => 57,
			"*" => 54,
			"/" => 53,
			"!" => 50
		},
		DEFAULT => -28
	},
	{#State 69
		ACTIONS => {
			"^" => 57,
			"!" => 50
		},
		DEFAULT => -31
	},
	{#State 70
		ACTIONS => {
			"!" => 50,
			"^" => 57
		},
		DEFAULT => -30
	},
	{#State 71
		ACTIONS => {
			"^" => 57,
			"/" => 53,
			"*" => 54,
			"!" => 50
		},
		DEFAULT => -29
	},
	{#State 72
		ACTIONS => {
			"^" => 57,
			"!" => 50
		},
		DEFAULT => -32
	},
	{#State 73
		ACTIONS => {
			"/" => 53,
			"*" => 54,
			"-" => 55,
			"^" => 57,
			"!" => 50,
			"+" => 51
		},
		DEFAULT => -15
	},
	{#State 74
		DEFAULT => -13
	},
	{#State 75
		ACTIONS => {
			"-" => 30,
			'PI' => 29,
			'NAN' => 23,
			'VAR' => 28,
			"(" => 31,
			'UNIOP' => 27,
			'EULER' => 26,
			"delay" => 32,
			'BINOP' => 33,
			'NUM' => 25,
			'INF' => 24
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 83
		}
	},
	{#State 76
		ACTIONS => {
			'NAN' => 23,
			'NUM' => 25,
			'VAR' => 28,
			'EULER' => 26,
			'UNIOP' => 27,
			'INF' => 24,
			'PI' => 29,
			"-" => 30,
			"delay" => 32,
			'BINOP' => 33,
			"(" => 31
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 84
		}
	},
	{#State 77
		DEFAULT => -38
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
		DEFAULT => -41
	},
	{#State 80
		ACTIONS => {
			'NUM' => 25,
			'BINOP' => 33,
			"delay" => 32,
			'VAR' => 28,
			'UNIOP' => 27,
			'EULER' => 26,
			"(" => 31,
			'INF' => 24,
			'PI' => 29,
			"-" => 30,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 86
		}
	},
	{#State 81
		ACTIONS => {
			'VAR' => 87
		}
	},
	{#State 82
		ACTIONS => {
			"(" => 31,
			'BINOP' => 33,
			"delay" => 32,
			"-" => 30,
			'PI' => 29,
			'EULER' => 26,
			'VAR' => 28,
			'UNIOP' => 27,
			'NUM' => 25,
			'INF' => 24,
			'NAN' => 23
		},
		GOTOS => {
			'constant' => 22,
			'expr' => 88
		}
	},
	{#State 83
		ACTIONS => {
			"-" => 55,
			'DESCRIPTION' => 90,
			"^" => 57,
			"/" => 53,
			"*" => 54,
			"!" => 50,
			"+" => 51
		},
		DEFAULT => -24,
		GOTOS => {
			'OPTIONAL-6' => 89
		}
	},
	{#State 84
		ACTIONS => {
			"^" => 57,
			'DESCRIPTION' => 91,
			"-" => 55,
			"/" => 53,
			"*" => 54,
			"!" => 50,
			"+" => 51
		},
		DEFAULT => -22,
		GOTOS => {
			'OPTIONAL-5' => 92
		}
	},
	{#State 85
		DEFAULT => -47
	},
	{#State 86
		ACTIONS => {
			"/" => 53,
			"*" => 54,
			"^" => 57,
			"-" => 55,
			"+" => 51,
			"!" => 50
		},
		DEFAULT => -48
	},
	{#State 87
		ACTIONS => {
			")" => 93
		}
	},
	{#State 88
		ACTIONS => {
			"^" => 57,
			"-" => 55,
			"+" => 51,
			"!" => 50,
			"/" => 53,
			")" => 94,
			"*" => 54
		}
	},
	{#State 89
		DEFAULT => -27
	},
	{#State 90
		DEFAULT => -23
	},
	{#State 91
		DEFAULT => -21
	},
	{#State 92
		DEFAULT => -26
	},
	{#State 93
		DEFAULT => -40
	},
	{#State 94
		DEFAULT => -39
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 1050 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 1057 infix2pharmml_model.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 39 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1064 infix2pharmml_model.pm
	],
	[#Rule model_3
		 'model', 1, undef
#line 1068 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1075 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1082 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1089 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 46 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1096 infix2pharmml_model.pm
	],
	[#Rule line_8
		 'line', 1, undef
#line 1100 infix2pharmml_model.pm
	],
	[#Rule line_9
		 'line', 3, undef
#line 1104 infix2pharmml_model.pm
	],
	[#Rule assignment_10
		 'assignment', 1, undef
#line 1108 infix2pharmml_model.pm
	],
	[#Rule assignment_11
		 'assignment', 4,
sub {
#line 52 "infix2pharmml_base.eyp"
infix2pharmml::macro($_[1],$_[3])}
#line 1115 infix2pharmml_model.pm
	],
	[#Rule assignment_12
		 'assignment', 2, undef
#line 1119 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_13
		 'macroargpairlist', 3,
sub {
#line 58 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1126 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_14
		 'macroargpairlist', 1,
sub {
#line 59 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1]) }
#line 1133 infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_15
		 'macroargpairlist', 3,
sub {
#line 60 "infix2pharmml_base.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1140 infix2pharmml_model.pm
	],
	[#Rule parameterlist_16
		 'parameterlist', 3,
sub {
#line 66 "infix2pharmml_base.eyp"
$_[1].$_[3]}
#line 1147 infix2pharmml_model.pm
	],
	[#Rule parameterlist_17
		 'parameterlist', 3,
sub {
#line 67 "infix2pharmml_base.eyp"
infix2pharmml::par_n($_[1],$_[3])}
#line 1154 infix2pharmml_model.pm
	],
	[#Rule parameterlist_18
		 'parameterlist', 3,
sub {
#line 68 "infix2pharmml_base.eyp"
infix2pharmml::par($_[1],$_[3])}
#line 1161 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1168 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 93 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1175 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1182 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 94 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1189 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 1196 infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 96 "infix2pharmml_base.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 1203 infix2pharmml_model.pm
	],
	[#Rule common_25
		 'common', 4,
sub {
#line 93 "infix2pharmml_base.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 1210 infix2pharmml_model.pm
	],
	[#Rule common_26
		 'common', 7,
sub {
#line 95 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1217 infix2pharmml_model.pm
	],
	[#Rule common_27
		 'common', 7,
sub {
#line 97 "infix2pharmml_base.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 1224 infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 3,
sub {
#line 105 "infix2pharmml_base.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 1231 infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 3,
sub {
#line 106 "infix2pharmml_base.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 1238 infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 3,
sub {
#line 107 "infix2pharmml_base.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 1245 infix2pharmml_model.pm
	],
	[#Rule expr_31
		 'expr', 3,
sub {
#line 108 "infix2pharmml_base.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 1252 infix2pharmml_model.pm
	],
	[#Rule expr_32
		 'expr', 3,
sub {
#line 109 "infix2pharmml_base.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 1259 infix2pharmml_model.pm
	],
	[#Rule expr_33
		 'expr', 1,
sub {
#line 110 "infix2pharmml_base.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1266 infix2pharmml_model.pm
	],
	[#Rule expr_34
		 'expr', 1,
sub {
#line 111 "infix2pharmml_base.eyp"
infix2pharmml::const($_[1])}
#line 1273 infix2pharmml_model.pm
	],
	[#Rule expr_35
		 'expr', 2,
sub {
#line 112 "infix2pharmml_base.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1280 infix2pharmml_model.pm
	],
	[#Rule expr_36
		 'expr', 2,
sub {
#line 113 "infix2pharmml_base.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1287 infix2pharmml_model.pm
	],
	[#Rule expr_37
		 'expr', 3,
sub {
#line 114 "infix2pharmml_base.eyp"
$_[2]}
#line 1294 infix2pharmml_model.pm
	],
	[#Rule expr_38
		 'expr', 4,
sub {
#line 115 "infix2pharmml_base.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1301 infix2pharmml_model.pm
	],
	[#Rule expr_39
		 'expr', 6,
sub {
#line 116 "infix2pharmml_base.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1308 infix2pharmml_model.pm
	],
	[#Rule expr_40
		 'expr', 6,
sub {
#line 117 "infix2pharmml_base.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 1315 infix2pharmml_model.pm
	],
	[#Rule expr_41
		 'expr', 4,
sub {
#line 118 "infix2pharmml_base.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1322 infix2pharmml_model.pm
	],
	[#Rule expr_42
		 'expr', 1,
sub {
#line 119 "infix2pharmml_base.eyp"
infix2pharmml::symbref($_[1])}
#line 1329 infix2pharmml_model.pm
	],
	[#Rule constant_43
		 'constant', 1,
sub {
#line 127 "infix2pharmml_base.eyp"
"notanumber"}
#line 1336 infix2pharmml_model.pm
	],
	[#Rule constant_44
		 'constant', 1,
sub {
#line 128 "infix2pharmml_base.eyp"
"pi"}
#line 1343 infix2pharmml_model.pm
	],
	[#Rule constant_45
		 'constant', 1,
sub {
#line 129 "infix2pharmml_base.eyp"
"exponentiale"}
#line 1350 infix2pharmml_model.pm
	],
	[#Rule constant_46
		 'constant', 1,
sub {
#line 130 "infix2pharmml_base.eyp"
"infinity"}
#line 1357 infix2pharmml_model.pm
	],
	[#Rule argpairlist_47
		 'argpairlist', 3,
sub {
#line 134 "infix2pharmml_base.eyp"
 $_[1].$_[3] }
#line 1364 infix2pharmml_model.pm
	],
	[#Rule argpairlist_48
		 'argpairlist', 3,
sub {
#line 135 "infix2pharmml_base.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1371 infix2pharmml_model.pm
	]
],
#line 1374 infix2pharmml_model.pm
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


#line 1449 infix2pharmml_model.pm



1;
