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

      m{\G(macro\(|diff\(|\)\:\=|\)\=|\:\=|\-|\+|\;|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

      /\G\b(nan|NaN|notanumber)\b/gc and return ('NAN', $1);
      /\G\b(e|exponentiale)\b/gc and return ('EULER', $1);
      /\G\b(pi)\b/gc and return ('PI', $1);
      /\G\b(inf|infinity)\b/gc and return ('INF', $1);
      /\G\b(exp|log|minus|factorial|sin|cos|tan|sec|csc|cot|sinh|cosh|tanh|sech|csch|coth|arcsin|arccos|arctan|arcsec|arccsc|arccot|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth|floor|ceiling|abs|logistic|logit|probit|ln|factln|gammaln|normcdf|sqrt)\b/gc and return ('UNIOP', $1);
      /\G\b(atan2|logx|min|max|root|rem)\b/gc and return ('BINOP', $1);
      /\G([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?)/gc and return ('NUM', $1);
      /\G([A-Za-z][A-Za-z0-9_]*)/gc and return ('VAR', $1);


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


#line 69 ./infix2pharmml_model.pm

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
  [ 'model_1' => 'model', [ 'model', 'structuralstmt' ], 0 ],
  [ 'model_2' => 'model', [ 'structuralstmt' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-1', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-2', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ 'structuralstmt_11' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-1' ], 0 ],
  [ 'structuralstmt_12' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_13' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'structuralstmt_14' => 'structuralstmt', [ 'macro(', 'VAR', ',', 'macroargpairlist', ')', 'OPTIONAL-4' ], 0 ],
  [ 'equation_15' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_16' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_17' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_18' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_19' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_20' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_21' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_22' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_23' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_24' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_26' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_27' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_28' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_29' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_30' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_31' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_32' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_33' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_34' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_35' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_36' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'macroargpairlist_37' => 'macroargpairlist', [ 'macroargpairlist', ',', 'macroargpairlist' ], 0 ],
  [ 'macroargpairlist_38' => 'macroargpairlist', [ 'VAR', '=', 'equation' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'model_1' => 1,
  'model_2' => 2,
  '_OPTIONAL' => 3,
  '_OPTIONAL' => 4,
  '_OPTIONAL' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_OPTIONAL' => 8,
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  'structuralstmt_11' => 11,
  'structuralstmt_12' => 12,
  'structuralstmt_13' => 13,
  'structuralstmt_14' => 14,
  'equation_15' => 15,
  'expr_16' => 16,
  'expr_17' => 17,
  'expr_18' => 18,
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
  'constant_31' => 31,
  'constant_32' => 32,
  'constant_33' => 33,
  'constant_34' => 34,
  'argpairlist_35' => 35,
  'argpairlist_36' => 36,
  'macroargpairlist_37' => 37,
  'macroargpairlist_38' => 38,
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
	'diff(' => { ISSEMANTIC => 0 },
	'macro(' => { ISSEMANTIC => 0 },
	BINOP => { ISSEMANTIC => 1 },
	EULER => { ISSEMANTIC => 1 },
	INF => { ISSEMANTIC => 1 },
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
			'VAR' => 3,
			"diff(" => 2,
			"macro(" => 5
		},
		GOTOS => {
			'structuralstmt' => 1,
			'model' => 4
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			'VAR' => 6
		}
	},
	{#State 3
		ACTIONS => {
			":=" => 7
		}
	},
	{#State 4
		ACTIONS => {
			'' => 9,
			'VAR' => 3,
			"diff(" => 2,
			"macro(" => 5
		},
		GOTOS => {
			'structuralstmt' => 8
		}
	},
	{#State 5
		ACTIONS => {
			'VAR' => 10
		}
	},
	{#State 6
		ACTIONS => {
			"," => 11
		}
	},
	{#State 7
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 22,
			'equation' => 17,
			'constant' => 16
		}
	},
	{#State 8
		DEFAULT => -1
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		ACTIONS => {
			"," => 26
		}
	},
	{#State 11
		ACTIONS => {
			'VAR' => 27
		}
	},
	{#State 12
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 28,
			'constant' => 16
		}
	},
	{#State 13
		DEFAULT => -31
	},
	{#State 14
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 29,
			'constant' => 16
		}
	},
	{#State 15
		ACTIONS => {
			"(" => 30
		}
	},
	{#State 16
		DEFAULT => -22
	},
	{#State 17
		ACTIONS => {
			";" => 31
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 32
		}
	},
	{#State 18
		DEFAULT => -33
	},
	{#State 19
		DEFAULT => -21
	},
	{#State 20
		DEFAULT => -34
	},
	{#State 21
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 33,
			'constant' => 16
		}
	},
	{#State 22
		ACTIONS => {
			"-" => 34,
			"+" => 35,
			"/" => 36,
			"!" => 37,
			"^" => 38,
			"*" => 39
		},
		DEFAULT => -15
	},
	{#State 23
		ACTIONS => {
			"(" => 40
		},
		DEFAULT => -30
	},
	{#State 24
		DEFAULT => -32
	},
	{#State 25
		ACTIONS => {
			"(" => 41
		}
	},
	{#State 26
		ACTIONS => {
			'VAR' => 42
		},
		GOTOS => {
			'macroargpairlist' => 43
		}
	},
	{#State 27
		ACTIONS => {
			"):=" => 44,
			")=" => 45
		}
	},
	{#State 28
		DEFAULT => -25
	},
	{#State 29
		ACTIONS => {
			"/" => 36,
			"!" => 37,
			"^" => 38,
			"*" => 39
		},
		DEFAULT => -24
	},
	{#State 30
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 46,
			'constant' => 16
		}
	},
	{#State 31
		DEFAULT => -3
	},
	{#State 32
		DEFAULT => -11
	},
	{#State 33
		ACTIONS => {
			"-" => 34,
			"^" => 38,
			"!" => 37,
			"*" => 39,
			"+" => 35,
			"/" => 36,
			")" => 47
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 48,
			'constant' => 16
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 49,
			'constant' => 16
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 50,
			'constant' => 16
		}
	},
	{#State 37
		DEFAULT => -23
	},
	{#State 38
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 51,
			'constant' => 16
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 52,
			'constant' => 16
		}
	},
	{#State 40
		ACTIONS => {
			'VAR' => 53
		},
		GOTOS => {
			'argpairlist' => 54
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 55,
			'constant' => 16
		}
	},
	{#State 42
		ACTIONS => {
			"=" => 56
		}
	},
	{#State 43
		ACTIONS => {
			"," => 57,
			")" => 58
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 22,
			'equation' => 59,
			'constant' => 16
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 22,
			'equation' => 60,
			'constant' => 16
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 34,
			"^" => 38,
			"!" => 37,
			"*" => 39,
			"+" => 35,
			"/" => 36,
			")" => 61
		}
	},
	{#State 47
		DEFAULT => -26
	},
	{#State 48
		ACTIONS => {
			"/" => 36,
			"!" => 37,
			"^" => 38,
			"*" => 39
		},
		DEFAULT => -17
	},
	{#State 49
		ACTIONS => {
			"/" => 36,
			"!" => 37,
			"^" => 38,
			"*" => 39
		},
		DEFAULT => -16
	},
	{#State 50
		ACTIONS => {
			"!" => 37,
			"^" => 38
		},
		DEFAULT => -19
	},
	{#State 51
		ACTIONS => {
			"!" => 37,
			"^" => 38
		},
		DEFAULT => -20
	},
	{#State 52
		ACTIONS => {
			"!" => 37,
			"^" => 38
		},
		DEFAULT => -18
	},
	{#State 53
		ACTIONS => {
			"=" => 62
		}
	},
	{#State 54
		ACTIONS => {
			"," => 63,
			")" => 64
		}
	},
	{#State 55
		ACTIONS => {
			"-" => 34,
			"^" => 38,
			"!" => 37,
			"*" => 39,
			"+" => 35,
			"," => 65,
			"/" => 36
		}
	},
	{#State 56
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 22,
			'equation' => 66,
			'constant' => 16
		}
	},
	{#State 57
		ACTIONS => {
			'VAR' => 42
		},
		GOTOS => {
			'macroargpairlist' => 67
		}
	},
	{#State 58
		ACTIONS => {
			";" => 68
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-4' => 69
		}
	},
	{#State 59
		ACTIONS => {
			";" => 70
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 71
		}
	},
	{#State 60
		ACTIONS => {
			";" => 72
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 73
		}
	},
	{#State 61
		DEFAULT => -27
	},
	{#State 62
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 22,
			'equation' => 74,
			'constant' => 16
		}
	},
	{#State 63
		ACTIONS => {
			'VAR' => 53
		},
		GOTOS => {
			'argpairlist' => 75
		}
	},
	{#State 64
		DEFAULT => -29
	},
	{#State 65
		ACTIONS => {
			"-" => 12,
			'NAN' => 13,
			"+" => 14,
			'UNIOP' => 15,
			'EULER' => 18,
			'NUM' => 19,
			'INF' => 20,
			"(" => 21,
			'VAR' => 23,
			'BINOP' => 25,
			'PI' => 24
		},
		GOTOS => {
			'expr' => 76,
			'constant' => 16
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		DEFAULT => -37
	},
	{#State 68
		DEFAULT => -9
	},
	{#State 69
		DEFAULT => -14
	},
	{#State 70
		DEFAULT => -7
	},
	{#State 71
		DEFAULT => -13
	},
	{#State 72
		DEFAULT => -5
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		DEFAULT => -36
	},
	{#State 75
		DEFAULT => -35
	},
	{#State 76
		ACTIONS => {
			"-" => 34,
			"^" => 38,
			"!" => 37,
			"*" => 39,
			"+" => 35,
			"/" => 36,
			")" => 77
		}
	},
	{#State 77
		DEFAULT => -28
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 860 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 864 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 868 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 875 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 882 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 889 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 896 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 903 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 910 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 917 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 39 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 924 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_11
		 'structuralstmt', 4,
sub {
#line 34 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3])}
#line 931 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_12
		 'structuralstmt', 7,
sub {
#line 36 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 938 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_13
		 'structuralstmt', 7,
sub {
#line 38 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 945 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_14
		 'structuralstmt', 6,
sub {
#line 40 "infix2pharmml_model.eyp"
infix2pharmml::macro($_[2],$_[4])}
#line 952 ./infix2pharmml_model.pm
	],
	[#Rule equation_15
		 'equation', 1,
sub {
#line 54 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 959 ./infix2pharmml_model.pm
	],
	[#Rule expr_16
		 'expr', 3,
sub {
#line 58 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 966 ./infix2pharmml_model.pm
	],
	[#Rule expr_17
		 'expr', 3,
sub {
#line 59 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 973 ./infix2pharmml_model.pm
	],
	[#Rule expr_18
		 'expr', 3,
sub {
#line 60 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 980 ./infix2pharmml_model.pm
	],
	[#Rule expr_19
		 'expr', 3,
sub {
#line 61 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 987 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 3,
sub {
#line 62 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 994 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 1,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 1001 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 1,
sub {
#line 64 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 1008 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 2,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 1015 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 2,
sub {
#line 66 "infix2pharmml_model.eyp"
$_[2]}
#line 1022 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 2,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 1029 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 3,
sub {
#line 68 "infix2pharmml_model.eyp"
$_[2]}
#line 1036 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 4,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 1043 ./infix2pharmml_model.pm
	],
	[#Rule expr_28
		 'expr', 6,
sub {
#line 70 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 1050 ./infix2pharmml_model.pm
	],
	[#Rule expr_29
		 'expr', 4,
sub {
#line 71 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 1057 ./infix2pharmml_model.pm
	],
	[#Rule expr_30
		 'expr', 1,
sub {
#line 72 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 1064 ./infix2pharmml_model.pm
	],
	[#Rule constant_31
		 'constant', 1,
sub {
#line 80 "infix2pharmml_model.eyp"
"notanumber"}
#line 1071 ./infix2pharmml_model.pm
	],
	[#Rule constant_32
		 'constant', 1,
sub {
#line 81 "infix2pharmml_model.eyp"
"pi"}
#line 1078 ./infix2pharmml_model.pm
	],
	[#Rule constant_33
		 'constant', 1,
sub {
#line 82 "infix2pharmml_model.eyp"
"exponentiale"}
#line 1085 ./infix2pharmml_model.pm
	],
	[#Rule constant_34
		 'constant', 1,
sub {
#line 83 "infix2pharmml_model.eyp"
"infinity"}
#line 1092 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_35
		 'argpairlist', 3,
sub {
#line 87 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1099 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_36
		 'argpairlist', 3,
sub {
#line 88 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 1106 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_37
		 'macroargpairlist', 3,
sub {
#line 91 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 1113 ./infix2pharmml_model.pm
	],
	[#Rule macroargpairlist_38
		 'macroargpairlist', 3,
sub {
#line 92 "infix2pharmml_model.eyp"
infix2pharmml::macroarg($_[1],$_[3]) }
#line 1120 ./infix2pharmml_model.pm
	]
],
#line 1123 ./infix2pharmml_model.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'structuralstmt_11', 
         'structuralstmt_12', 
         'structuralstmt_13', 
         'structuralstmt_14', 
         'equation_15', 
         'expr_16', 
         'expr_17', 
         'expr_18', 
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
         'constant_31', 
         'constant_32', 
         'constant_33', 
         'constant_34', 
         'argpairlist_35', 
         'argpairlist_36', 
         'macroargpairlist_37', 
         'macroargpairlist_38', );
  $self;
}

#line 99 "infix2pharmml_model.eyp"



=for None

=cut


#line 1188 ./infix2pharmml_model.pm



1;
