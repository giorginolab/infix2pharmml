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

      m{\G(diff\(|\)\:\=|\)\=|\:\=|\-|\+|\;|\,|\^|\!|\*|\)|\/|\=|\()}gc and return ($1, $1);

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
  [ 'structuralstmt_9' => 'structuralstmt', [ 'VAR', ':=', 'equation', 'OPTIONAL-1' ], 0 ],
  [ 'structuralstmt_10' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-2' ], 0 ],
  [ 'structuralstmt_11' => 'structuralstmt', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-3' ], 0 ],
  [ 'equation_12' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_13' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_14' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_15' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_16' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_17' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_18' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_19' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_20' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_21' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_22' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_23' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_24' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_25' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_26' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_27' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_28' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_29' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_30' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_31' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_32' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_33' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
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
  'structuralstmt_9' => 9,
  'structuralstmt_10' => 10,
  'structuralstmt_11' => 11,
  'equation_12' => 12,
  'expr_13' => 13,
  'expr_14' => 14,
  'expr_15' => 15,
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
  'constant_28' => 28,
  'constant_29' => 29,
  'constant_30' => 30,
  'constant_31' => 31,
  'argpairlist_32' => 32,
  'argpairlist_33' => 33,
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
			"diff(" => 2
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
			'VAR' => 5
		}
	},
	{#State 3
		ACTIONS => {
			":=" => 6
		}
	},
	{#State 4
		ACTIONS => {
			'' => 8,
			'VAR' => 3,
			"diff(" => 2
		},
		GOTOS => {
			'structuralstmt' => 7
		}
	},
	{#State 5
		ACTIONS => {
			"," => 9
		}
	},
	{#State 6
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 20,
			'equation' => 15,
			'constant' => 14
		}
	},
	{#State 7
		DEFAULT => -1
	},
	{#State 8
		DEFAULT => 0
	},
	{#State 9
		ACTIONS => {
			'VAR' => 24
		}
	},
	{#State 10
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 25,
			'constant' => 14
		}
	},
	{#State 11
		DEFAULT => -28
	},
	{#State 12
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 26,
			'constant' => 14
		}
	},
	{#State 13
		ACTIONS => {
			"(" => 27
		}
	},
	{#State 14
		DEFAULT => -19
	},
	{#State 15
		ACTIONS => {
			";" => 28
		},
		DEFAULT => -4,
		GOTOS => {
			'OPTIONAL-1' => 29
		}
	},
	{#State 16
		DEFAULT => -30
	},
	{#State 17
		DEFAULT => -18
	},
	{#State 18
		DEFAULT => -31
	},
	{#State 19
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 30,
			'constant' => 14
		}
	},
	{#State 20
		ACTIONS => {
			"-" => 31,
			"+" => 32,
			"/" => 33,
			"!" => 34,
			"^" => 35,
			"*" => 36
		},
		DEFAULT => -12
	},
	{#State 21
		ACTIONS => {
			"(" => 37
		},
		DEFAULT => -27
	},
	{#State 22
		DEFAULT => -29
	},
	{#State 23
		ACTIONS => {
			"(" => 38
		}
	},
	{#State 24
		ACTIONS => {
			"):=" => 39,
			")=" => 40
		}
	},
	{#State 25
		DEFAULT => -22
	},
	{#State 26
		ACTIONS => {
			"/" => 33,
			"!" => 34,
			"^" => 35,
			"*" => 36
		},
		DEFAULT => -21
	},
	{#State 27
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 41,
			'constant' => 14
		}
	},
	{#State 28
		DEFAULT => -3
	},
	{#State 29
		DEFAULT => -9
	},
	{#State 30
		ACTIONS => {
			"-" => 31,
			"^" => 35,
			"!" => 34,
			"*" => 36,
			"+" => 32,
			"/" => 33,
			")" => 42
		}
	},
	{#State 31
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 14
		}
	},
	{#State 32
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 14
		}
	},
	{#State 33
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 45,
			'constant' => 14
		}
	},
	{#State 34
		DEFAULT => -20
	},
	{#State 35
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 46,
			'constant' => 14
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 47,
			'constant' => 14
		}
	},
	{#State 37
		ACTIONS => {
			'VAR' => 48
		},
		GOTOS => {
			'argpairlist' => 49
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 50,
			'constant' => 14
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 20,
			'equation' => 51,
			'constant' => 14
		}
	},
	{#State 40
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 20,
			'equation' => 52,
			'constant' => 14
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 31,
			"^" => 35,
			"!" => 34,
			"*" => 36,
			"+" => 32,
			"/" => 33,
			")" => 53
		}
	},
	{#State 42
		DEFAULT => -23
	},
	{#State 43
		ACTIONS => {
			"/" => 33,
			"!" => 34,
			"^" => 35,
			"*" => 36
		},
		DEFAULT => -14
	},
	{#State 44
		ACTIONS => {
			"/" => 33,
			"!" => 34,
			"^" => 35,
			"*" => 36
		},
		DEFAULT => -13
	},
	{#State 45
		ACTIONS => {
			"!" => 34,
			"^" => 35
		},
		DEFAULT => -16
	},
	{#State 46
		ACTIONS => {
			"!" => 34,
			"^" => 35
		},
		DEFAULT => -17
	},
	{#State 47
		ACTIONS => {
			"!" => 34,
			"^" => 35
		},
		DEFAULT => -15
	},
	{#State 48
		ACTIONS => {
			"=" => 54
		}
	},
	{#State 49
		ACTIONS => {
			"," => 55,
			")" => 56
		}
	},
	{#State 50
		ACTIONS => {
			"-" => 31,
			"^" => 35,
			"!" => 34,
			"*" => 36,
			"+" => 32,
			"," => 57,
			"/" => 33
		}
	},
	{#State 51
		ACTIONS => {
			";" => 58
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-3' => 59
		}
	},
	{#State 52
		ACTIONS => {
			";" => 60
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-2' => 61
		}
	},
	{#State 53
		DEFAULT => -24
	},
	{#State 54
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 20,
			'equation' => 62,
			'constant' => 14
		}
	},
	{#State 55
		ACTIONS => {
			'VAR' => 48
		},
		GOTOS => {
			'argpairlist' => 63
		}
	},
	{#State 56
		DEFAULT => -26
	},
	{#State 57
		ACTIONS => {
			"-" => 10,
			'NAN' => 11,
			"+" => 12,
			'UNIOP' => 13,
			'EULER' => 16,
			'NUM' => 17,
			'INF' => 18,
			"(" => 19,
			'VAR' => 21,
			'BINOP' => 23,
			'PI' => 22
		},
		GOTOS => {
			'expr' => 64,
			'constant' => 14
		}
	},
	{#State 58
		DEFAULT => -7
	},
	{#State 59
		DEFAULT => -11
	},
	{#State 60
		DEFAULT => -5
	},
	{#State 61
		DEFAULT => -10
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		ACTIONS => {
			"-" => 31,
			"^" => 35,
			"!" => 34,
			"*" => 36,
			"+" => 32,
			"/" => 33,
			")" => 65
		}
	},
	{#State 65
		DEFAULT => -25
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 769 ./infix2pharmml_model.pm
	],
	[#Rule model_1
		 'model', 2, undef
#line 773 ./infix2pharmml_model.pm
	],
	[#Rule model_2
		 'model', 1, undef
#line 777 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 1,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 784 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-1', 0,
sub {
#line 34 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 791 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 1,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 798 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-2', 0,
sub {
#line 35 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 805 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 812 ./infix2pharmml_model.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 37 "infix2pharmml_model.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 819 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_9
		 'structuralstmt', 4,
sub {
#line 34 "infix2pharmml_model.eyp"
infix2pharmml::vardef($_[1],$_[3])}
#line 826 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_10
		 'structuralstmt', 7,
sub {
#line 36 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 833 ./infix2pharmml_model.pm
	],
	[#Rule structuralstmt_11
		 'structuralstmt', 7,
sub {
#line 38 "infix2pharmml_model.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6])}
#line 840 ./infix2pharmml_model.pm
	],
	[#Rule equation_12
		 'equation', 1,
sub {
#line 52 "infix2pharmml_model.eyp"
infix2pharmml::eqn($_[1])}
#line 847 ./infix2pharmml_model.pm
	],
	[#Rule expr_13
		 'expr', 3,
sub {
#line 56 "infix2pharmml_model.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 854 ./infix2pharmml_model.pm
	],
	[#Rule expr_14
		 'expr', 3,
sub {
#line 57 "infix2pharmml_model.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 861 ./infix2pharmml_model.pm
	],
	[#Rule expr_15
		 'expr', 3,
sub {
#line 58 "infix2pharmml_model.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 868 ./infix2pharmml_model.pm
	],
	[#Rule expr_16
		 'expr', 3,
sub {
#line 59 "infix2pharmml_model.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 875 ./infix2pharmml_model.pm
	],
	[#Rule expr_17
		 'expr', 3,
sub {
#line 60 "infix2pharmml_model.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 882 ./infix2pharmml_model.pm
	],
	[#Rule expr_18
		 'expr', 1,
sub {
#line 61 "infix2pharmml_model.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 889 ./infix2pharmml_model.pm
	],
	[#Rule expr_19
		 'expr', 1,
sub {
#line 62 "infix2pharmml_model.eyp"
infix2pharmml::const($_[1])}
#line 896 ./infix2pharmml_model.pm
	],
	[#Rule expr_20
		 'expr', 2,
sub {
#line 63 "infix2pharmml_model.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 903 ./infix2pharmml_model.pm
	],
	[#Rule expr_21
		 'expr', 2,
sub {
#line 64 "infix2pharmml_model.eyp"
$_[2]}
#line 910 ./infix2pharmml_model.pm
	],
	[#Rule expr_22
		 'expr', 2,
sub {
#line 65 "infix2pharmml_model.eyp"
infix2pharmml::u("minus",$_[2])}
#line 917 ./infix2pharmml_model.pm
	],
	[#Rule expr_23
		 'expr', 3,
sub {
#line 66 "infix2pharmml_model.eyp"
$_[2]}
#line 924 ./infix2pharmml_model.pm
	],
	[#Rule expr_24
		 'expr', 4,
sub {
#line 67 "infix2pharmml_model.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 931 ./infix2pharmml_model.pm
	],
	[#Rule expr_25
		 'expr', 6,
sub {
#line 68 "infix2pharmml_model.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 938 ./infix2pharmml_model.pm
	],
	[#Rule expr_26
		 'expr', 4,
sub {
#line 69 "infix2pharmml_model.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 945 ./infix2pharmml_model.pm
	],
	[#Rule expr_27
		 'expr', 1,
sub {
#line 70 "infix2pharmml_model.eyp"
infix2pharmml::symbref($_[1])}
#line 952 ./infix2pharmml_model.pm
	],
	[#Rule constant_28
		 'constant', 1,
sub {
#line 78 "infix2pharmml_model.eyp"
"notanumber"}
#line 959 ./infix2pharmml_model.pm
	],
	[#Rule constant_29
		 'constant', 1,
sub {
#line 79 "infix2pharmml_model.eyp"
"pi"}
#line 966 ./infix2pharmml_model.pm
	],
	[#Rule constant_30
		 'constant', 1,
sub {
#line 80 "infix2pharmml_model.eyp"
"exponentiale"}
#line 973 ./infix2pharmml_model.pm
	],
	[#Rule constant_31
		 'constant', 1,
sub {
#line 81 "infix2pharmml_model.eyp"
"infinity"}
#line 980 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_32
		 'argpairlist', 3,
sub {
#line 85 "infix2pharmml_model.eyp"
 $_[1].$_[3] }
#line 987 ./infix2pharmml_model.pm
	],
	[#Rule argpairlist_33
		 'argpairlist', 3,
sub {
#line 86 "infix2pharmml_model.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 994 ./infix2pharmml_model.pm
	]
],
#line 997 ./infix2pharmml_model.pm
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
         'structuralstmt_9', 
         'structuralstmt_10', 
         'structuralstmt_11', 
         'equation_12', 
         'expr_13', 
         'expr_14', 
         'expr_15', 
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
         'constant_28', 
         'constant_29', 
         'constant_30', 
         'constant_31', 
         'argpairlist_32', 
         'argpairlist_33', );
  $self;
}

#line 93 "infix2pharmml_model.eyp"



=for None

=cut


#line 1057 ./infix2pharmml_model.pm



1;
