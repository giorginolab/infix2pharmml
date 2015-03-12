########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'infix2pharmml_statement.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package infix2pharmml_statement;
use strict;

push @infix2pharmml_statement::ISA, 'Parse::Eyapp::Driver';



  # Loading Parse::Eyapp::Driver
  BEGIN {
    unless (Parse::Eyapp::Driver->can('YYParse')) {
      eval << 'MODULE_Parse_Eyapp_Driver'
#
# Module Parse::Eyapp::Driver
#
# This module is part of the Parse::Eyapp package available on your
# nearest CPAN
#
# This module is based on Francois Desarmenien Parse::Yapp module
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien, all rights reserved.
# (c) Parse::Eyapp Copyright 2006-2010 Casiano Rodriguez-Leon, all rights reserved.

our $SVNREVISION = '$Rev: 2399M $';
our $SVNDATE     = '$Date: 2009-01-06 12:28:04 +0000 (mar, 06 ene 2009) $';

package Parse::Eyapp::Driver;

require 5.006;

use strict;

our ( $VERSION, $COMPATIBLE, $FILENAME );


# $VERSION is also in Parse/Eyapp.pm
$VERSION = "1.182";
$COMPATIBLE = '0.07';
$FILENAME   =__FILE__;

use Carp;
use Scalar::Util qw{blessed reftype looks_like_number};

use Getopt::Long;

#Known parameters, all starting with YY (leading YY will be discarded)
my (%params)=(YYLEX => 'CODE', 'YYERROR' => 'CODE', YYVERSION => '',
       YYRULES => 'ARRAY', YYSTATES => 'ARRAY', YYDEBUG => '', 
       # added by Casiano
       #YYPREFIX  => '',  # Not allowed at YYParse time but in new
       YYFILENAME => '', 
       YYBYPASS   => '',
       YYGRAMMAR  => 'ARRAY', 
       YYTERMS    => 'HASH',
       YYBUILDINGTREE  => '',
       YYACCESSORS => 'HASH',
       YYCONFLICTHANDLERS => 'HASH',
       YYSTATECONFLICT => 'HASH',
       YYLABELS => 'HASH',
       ); 
my (%newparams) = (%params, YYPREFIX => '',);

#Mandatory parameters
my (@params)=('LEX','RULES','STATES');

sub new {
    my($class)=shift;

    my($errst,$nberr,$token,$value,$check,$dotpos);

    my($self)={ 
      ERRST => \$errst,
      NBERR => \$nberr,
      TOKEN => \$token,
      VALUE => \$value,
      DOTPOS => \$dotpos,
      STACK => [],
      DEBUG => 0,
      PREFIX => "",
      CHECK => \$check, 
    };

  _CheckParams( [], \%newparams, \@_, $self );

    exists($$self{VERSION})
  and $$self{VERSION} < $COMPATIBLE
  and croak "Eyapp driver version $VERSION ".
        "incompatible with version $$self{VERSION}:\n".
        "Please recompile parser module.";

        ref($class)
    and $class=ref($class);

    unless($self->{ERROR}) {
      $self->{ERROR} = $class->error;
      $self->{ERROR} = \&_Error unless ($self->{ERROR});
    }

    unless ($self->{LEX}) {
        $self->{LEX} = $class->YYLexer;
        @params = ('RULES','STATES');
    }

    my $parser = bless($self,$class);

    $parser;
}

sub YYParse {
    my($self)=shift;
    my($retval);

  _CheckParams( \@params, \%params, \@_, $self );

  unless($self->{ERROR}) {
    $self->{ERROR} = $self->error;
    $self->{ERROR} = \&_Error unless ($self->{ERROR});
  }

  unless($self->{LEX}) {
    $self->{LEX} = $self->YYLexer;
    croak "Missing parameter 'yylex' " unless $self->{LEX} && reftype($self->{LEX}) eq 'CODE';
  }

  if($$self{DEBUG}) {
    _DBLoad();
    $retval = eval '$self->_DBParse()';#Do not create stab entry on compile
        $@ and die $@;
  }
  else {
    $retval = $self->_Parse();
  }
    return $retval;
}

sub YYData {
  my($self)=shift;

    exists($$self{USER})
  or  $$self{USER}={};

  $$self{USER};
  
}

sub YYErrok {
  my($self)=shift;

  ${$$self{ERRST}}=0;
    undef;
}

sub YYNberr {
  my($self)=shift;

  ${$$self{NBERR}};
}

sub YYRecovering {
  my($self)=shift;

  ${$$self{ERRST}} != 0;
}

sub YYAbort {
  my($self)=shift;

  ${$$self{CHECK}}='ABORT';
    undef;
}

sub YYAccept {
  my($self)=shift;

  ${$$self{CHECK}}='ACCEPT';
    undef;
}

# Used to set that we are in "error recovery" state
sub YYError {
  my($self)=shift;

  ${$$self{CHECK}}='ERROR';
    undef;
}

sub YYSemval {
  my($self)=shift;
  my($index)= $_[0] - ${$$self{DOTPOS}} - 1;

    $index < 0
  and -$index <= @{$$self{STACK}}
  and return $$self{STACK}[$index][1];

  undef;  #Invalid index
}

### Casiano methods

sub YYRule { 
  # returns the list of rules
  # counting the super rule as rule 0
  my $self = shift;
  my $index = shift;

  if ($index) {
    $index = $self->YYIndex($index) unless (looks_like_number($index));
    return wantarray? @{$self->{RULES}[$index]} : $self->{RULES}[$index]
  }

  return wantarray? @{$self->{RULES}} : $self->{RULES}
}

# YYState returns the list of states. Each state is an anonymous hash
#  DB<4> x $parser->YYState(2)
#  0  HASH(0xfa7120)
#     'ACTIONS' => HASH(0xfa70f0) # token => state
#           ':' => '-7'
#     'DEFAULT' => '-6'
# There are three keys: ACTIONS, GOTOS and  DEFAULT
#  DB<7> x $parser->YYState(13)
# 0  HASH(0xfa8b50)
#    'ACTIONS' => HASH(0xfa7530)
#       'VAR' => 17
#    'GOTOS' => HASH(0xfa8b20)
#       'type' => 19
sub YYState {
  my $self = shift;
  my $index = shift;

  if ($index) {
    # Comes from the stack: a pair [state number, attribute]
    $index = $index->[0] if 'ARRAY' eq reftype($index);
    die "YYState error. Expecting a number, found <$index>" unless (looks_like_number($index));
    return $self->{STATES}[$index]
  }

  return $self->{STATES}
}

sub YYGoto {
  my ($self, $state, $symbol) = @_;
 
  my $stateLRactions = $self->YYState($state);

  $stateLRactions->{GOTOS}{$symbol};
}

sub YYRHSLength {
  my $self = shift;
  # If no production index is given, is the production begin used in the current reduction
  my $index = shift || $self->YYRuleindex;

  # If the production was given by its name, compute its index
  $index = $self->YYIndex($index) unless looks_like_number($index); 
  
  return unless looks_like_number($index);

  my $currentprod = $self->YYRule($index);

  $currentprod->[1] if reftype($currentprod);
}

# To be used in a semantic action, when reducing ...
# It gives the next state after reduction
sub YYNextState {
  my $self = shift;

  my $lhs = $self->YYLhs;

  if ($lhs) { # reduce
    my $length = $self->YYRHSLength;

    my $state = $self->YYTopState($length);
    #print "state = $$state[0]\n";
    $self->YYGoto($state, $lhs);
  }
  else { # shift: a token must be provided as argument
    my $token = shift;
    
    my $state = $self->YYTopState;
    $self->YYGetLRAction($state, $token);
  }
}

# TODO: make it work with a list of indices ...
sub YYGrammar { 
  my $self = shift;
  my $index = shift;

  if ($index) {
    $index = $self->YYIndex($index) unless (looks_like_number($index));
    return wantarray? @{$self->{GRAMMAR}[$index]} : $self->{GRAMMAR}[$index]
  }
  return wantarray? @{$self->{GRAMMAR}} : $self->{GRAMMAR}
}

# Return the list of production names
sub YYNames { 
  my $self = shift;

  my @names = map { $_->[0] } @{$self->{GRAMMAR}};

  return wantarray? @names : \@names;
}

# Return the hash of indices  for each production name
# Initializes the INDICES attribute of the parser
# Returns the index of the production rule with name $name
sub YYIndex {
  my $self = shift;

  if (@_) {
    my @indices = map { $self->{LABELS}{$_} } @_;
    return wantarray? @indices : $indices[0];
  }
  return wantarray? %{$self->{LABELS}} : $self->{LABELS};

}

sub YYTopState {
  my $self = shift;
  my $length = shift || 0;

  $length = -$length unless $length <= 0;
  $length--;

  $_[1] and $self->{STACK}[$length] = $_[1];
  $self->{STACK}[$length];
}

sub YYStack {
  my $self = shift;

  return $self->{STACK};
}

# To dynamically set syntactic actions
# Change it to state, token, action
# it is more natural
sub YYSetLRAction {
  my ($self,  $state, $token, $action) = @_;

  die "YYLRAction: Provide a state " unless defined($state);

  # Action can be given using the name of the production
  $action = -$self->YYIndex($action) unless looks_like_number($action);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    $self->{STATES}[$state]{ACTIONS}{$_} = $action;
  }
}

sub YYRestoreLRAction {
  my $self = shift;
  my $conflictname = shift;
  my @tokens = @_;

  for (@tokens) {
    my ($conflictstate, $action) = @{$self->{CONFLICT}{$conflictname}{$_}};
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

# Fools the lexer to get a new token
# without modifying the parsing position (pos)
# Warning, warning! this and YYLookaheads assume
# that the input comes from the string
# referenced by $self->input.
# It will not work for a stream 
sub YYLookahead {
  my $self = shift;

  my $pos = pos(${$self->input});
  my ($nextToken, $val) = $self->YYLexer->($self);
  # restore pos
  pos(${$self->input}) = $pos;
  return $nextToken;
}

# Fools the lexer to get $spec new tokens
sub YYLookaheads {
  my $self = shift;
  my $spec = shift || 1; # a number

  my $pos = pos(${$self->input});
  my @r; # list of lookahead tokens

  my ($t, $v);
  if (looks_like_number($spec)) {
    for my $i (1..$spec) { 
      ($t, $v) = $self->YYLexer->($self);
      push @r, $t;
      last if $t eq '';
    }
  }
  else { # if string
    do {
      ($t, $v) = $self->YYLexer->($self);
      push @r, $t;
    } while ($t ne $spec && $t ne '');
  }

  # restore pos
  pos(${$self->input}) = $pos;

  return @r;
}


# more parameters: debug, etc, ...
#sub YYNestedParse {
sub YYPreParse {
  my $self = shift; 
  my $parser = shift;
  my $file = shift() || $parser;

  # Check for errors!
  eval "require $file";
   
  # optimize to state variable for 5.10
  my $rp = $parser->new( yyerror => sub {});

  my $pos  = pos(${$self->input});
  my $rpos = $self->{POS};

  #print "pos = $pos\n";
  $rp->input($self->input);
  pos(${$rp->input}) = $rpos;

  my $t = $rp->Run(@_);
  my $ne = $rp->YYNberr;

  #print "After nested parsing\n";

  pos(${$self->input}) = $pos;

  return (wantarray ? ($t, !$ne) : !$ne);
}

sub YYNestedParse {
  my $self = shift;
  my $parser = shift;
  my $conflictName =  shift;

  $conflictName = $self->YYLhs unless $conflictName;

  my ($t, $ok) = $self->YYPreParse($parser, @_);

  $self->{CONFLICTHANDLERS}{$conflictName}{".".$parser} = [$ok, $t];

  return $ok;
}

sub YYNestedRegexp {
  my $self = shift;
  my $regexp = shift;
  my $conflictName = $self->YYLhs;

  my $ok = $_ =~ /$regexp/gc;

  $self->{CONFLICTHANDLERS}{$conflictName}{'..regexp'} = [$ok, undef];

  return $ok;
}

sub YYIs {
  my $self = shift;
  # this is ungly and dangeorus. Don't use the dot. Change it!
  my $syntaxVariable = '.'.(shift());
  my $conflictName = $self->YYLhs;
  my $v = $self->{CONFLICTHANDLERS}{$conflictName};

  $v->{$syntaxVariable}[0] = shift if @_;
  return $v->{$syntaxVariable}[0];
}


sub YYVal {
  my $self = shift;
  # this is ungly and dangeorus. Don't use the dot. Change it!
  my $syntaxVariable = '.'.(shift());
  my $conflictName = $self->YYLhs;
  my $v = $self->{CONFLICTHANDLERS}{$conflictName};

  $v->{$syntaxVariable}[1] = shift if @_;
  return $v->{$syntaxVariable}[1];
}

#x $self->{CONFLICTHANDLERS}                                                                              
#0  HASH(0x100b306c0)
#   'rangeORenum' => HASH(0x100b30660)
#      'explorerline' => 12
#      'line' => 5
#      'production' => HASH(0x100b30580)
#         '-13' => ARRAY(0x100b30520)
#            0  1 <------- mark: conflictive position in the rhs 
#         '-5' => ARRAY(0x100b30550)
#            0  1 <------- mark: conflictive position in the rhs 
#      'states' => ARRAY(0x100b30630)
#         0  HASH(0x100b30600)
#            25 => ARRAY(0x100b305c0)
#               0  '\',\''
#               1  '\')\''
sub YYSetReduceXXXXX {
  my $self = shift;
  my $action = pop;
  my $token = shift;
  

  croak "YYSetReduce error: specify a production" unless defined($action);

  # Conflict state
  my $conflictstate = $self->YYNextState();

  my $conflictName = $self->YYLhs;

  #$self->{CONFLICTHANDLERS}{conflictName}{states}
  # is a hash
  #        statenumber => [ tokens, '\'-\'' ]
  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();

  # Perform the action to change the LALR tables only if the next state 
  # is listed as a conflictstate
  my ($cs) = (grep { exists $_->{$conflictstate}} @conflictStates); 
  return unless $cs;

  # Action can be given using the name of the production
  unless (looks_like_number($action)) {
    my $actionnum = $self->{LABELS}{$action};
    unless (looks_like_number($actionnum)) {
      croak "YYSetReduce error: can't find production '$action'. Did you forget to name it?";
    }
    $action = -$actionnum;
  }

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    # save if shift
    if (exists($self->{STATES}[$conflictstate]{ACTIONS}) and $self->{STATES}[$conflictstate]{ACTIONS}{$_} >= 0) {
      $self->{CONFLICT}{$conflictName}{$_}  = [ $conflictstate,  $self->{STATES}[$conflictstate]{ACTIONS}{$_} ];
    }
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

sub YYSetReduce {
  my $self = shift;
  my $action = pop;
  my $token = shift;
  

  croak "YYSetReduce error: specify a production" unless defined($action);

  my $conflictName = $self->YYLhs;

  #$self->{CONFLICTHANDLERS}{conflictName}{states}
  # is a hash
  #        statenumber => [ tokens, '\'-\'' ]
  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();
 
  return unless @conflictStates;

  # Conflict state
  my $cs = $conflictStates[0];


  my ($conflictstate) = keys %{$cs};

  # Action can be given using the name of the production
  unless (looks_like_number($action)) {
    my $actionnum = $self->{LABELS}{$action};
    unless (looks_like_number($actionnum)) {
      croak "YYSetReduce error: can't find production '$action'. Did you forget to name it?";
    }
    $action = -$actionnum;
  }

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    # save if shift
    if (exists($self->{STATES}[$conflictstate]{ACTIONS}) and $self->{STATES}[$conflictstate]{ACTIONS}{$_} >= 0) {
      $self->{CONFLICT}{$conflictName}{$_}  = [ $conflictstate,  $self->{STATES}[$conflictstate]{ACTIONS}{$_} ];
    }
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

sub YYSetShift {
  my ($self, $token) = @_;

  # my ($self, $token, $action) = @_;
  # $action is syntactic sugar ...


  my $conflictName = $self->YYLhs;

  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();
 
  return unless @conflictStates;

  my $cs = $conflictStates[0];

  my ($conflictstate) = keys %{$cs};

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);

  for (@$token) {
    if (defined($self->{CONFLICT}{$conflictName}{$_}))  {
      my ($conflictstate2, $action) = @{$self->{CONFLICT}{$conflictName}{$_}};
      # assert($conflictstate == $conflictstate2) 

      $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $self->{CONFLICT}{$conflictName}{$_}[1];
    }
    else {
      #croak "YYSetShift error. No shift action found";
      # shift is the default ...  hope to be lucky!
    }
  }
}


  # if is reduce ...
    # x $self->{CONFLICTHANDLERS}{$conflictName}{production}{$action} $action is a number
    #0  ARRAY(0x100b3f930)
    #   0  2
    # has the position in the item, starting at 0
    # DB<19> x $self->YYRHSLength(4)
    # 0  3
    # if pos is length -1 then is reduce otherwise is shift


# It does YYSetReduce or YYSetshift according to the 
# decision variable
# I need to know the kind of conflict that there is
# shift-reduce or reduce-reduce
sub YYIf {
  my $self = shift;
  my $syntaxVariable = shift;

  if ($self->YYIs($syntaxVariable)) {
    if ($_[0] eq 'shift') {
      $self->YYSetShift(@_); 
    }
    else {
      $self->YYSetReduce($_[0]); 
    }
  }
  else {
    if ($_[1] eq 'shift') {
      $self->YYSetShift(@_); 
    }
    else {
      $self->YYSetReduce($_[1]); 
    }
  }
  $self->YYIs($syntaxVariable, 0); 
}

sub YYGetLRAction {
  my ($self,  $state, $token) = @_;

  $state = $state->[0] if reftype($state) && (reftype($state) eq 'ARRAY');
  my $stateentry = $self->{STATES}[$state];

  if (defined($token)) {
    return $stateentry->{ACTIONS}{$token} if exists $stateentry->{ACTIONS}{$token};
  }

  return $stateentry->{DEFAULT} if exists $stateentry->{DEFAULT};

  return;
}

# to dynamically set semantic actions
sub YYAction {
  my $self = shift;
  my $index = shift;
  my $newaction = shift;

  croak "YYAction error: Expecting an index" unless $index;

  # If $index is the production 'name' find the actual index
  $index = $self->YYIndex($index) unless looks_like_number($index);
  my $rule = $self->{RULES}->[$index];
  $rule->[2] = $newaction if $newaction && (reftype($newaction) eq 'CODE');

  return $rule->[2];
}

sub YYSetaction {
  my $self = shift;
  my %newaction = @_;

  for my $n (keys(%newaction)) {
    my $m = looks_like_number($n) ? $n : $self->YYIndex($n);
    my $rule = $self->{RULES}->[$m];
    $rule->[2] = $newaction{$n} if ($newaction{$n} && (reftype($newaction{$n}) eq 'CODE'));
  }
}

#sub YYDebugtree  {
#  my ($self, $i, $e) = @_;
#
#  my ($name, $lhs, $rhs) = @$e;
#  my @rhs = @$rhs;
#
#  return if $name =~ /_SUPERSTART/;
#  $name = $lhs."::"."@rhs";
#  $name =~ s/\W/_/g;
#  return $name;
#}
#
#sub YYSetnames {
#  my $self = shift;
#  my $newname = shift || \&YYDebugtree;
#
#    die "YYSetnames error. Exected a CODE reference found <$newname>" 
#  unless $newname && (reftype($newname) eq 'CODE');
#
#  my $i = 0;
#  for my $e (@{$self->{GRAMMAR}}) {
#     my $nn= $newname->($self, $i, $e);
#     $e->[0] = $nn if defined($nn);
#     $i++;
#  }
#}

sub YYLhs { 
  # returns the syntax variable on
  # the left hand side of the current production
  my $self = shift;

  return $self->{CURRENT_LHS}
}

sub YYRuleindex { 
  # returns the index of the rule
  # counting the super rule as rule 0
  my $self = shift;

  return $self->{CURRENT_RULE}
}

sub YYRightside { 
  # returns the rule
  # counting the super rule as rule 0
  my $self = shift;
  my $index = shift || $self->{CURRENT_RULE};
  $index = $self->YYIndex($index) unless looks_like_number($index);

  return @{$self->{GRAMMAR}->[$index]->[2]};
}

sub YYTerms {
  my $self = shift;

  return $self->{TERMS};
}


sub YYIsterm {
  my $self = shift;
  my $symbol = shift;

  return exists ($self->{TERMS}->{$symbol});
}

sub YYIssemantic {
  my $self = shift;
  my $symbol = shift;

  return 0 unless exists($self->{TERMS}{$symbol});
  $self->{TERMS}{$symbol}{ISSEMANTIC} = shift if @_;
  return ($self->{TERMS}{$symbol}{ISSEMANTIC});
}

sub YYName {
  my $self = shift;

  my $current_rule = $self->{GRAMMAR}->[$self->{CURRENT_RULE}];
  $current_rule->[0] = shift if @_;
  return $current_rule->[0];
}

sub YYPrefix {
  my $self = shift;

  $self->{PREFIX} = $_[0] if @_;
  $self->{PREFIX};
}

sub YYAccessors {
  my $self = shift;

  $self->{ACCESSORS}
}

# name of the file containing
# the source grammar
sub YYFilename {
  my $self = shift;

  $self->{FILENAME} = $_[0] if @_;
  $self->{FILENAME};
}

sub YYBypass {
  my $self = shift;

  $self->{BYPASS} = $_[0] if @_;
  $self->{BYPASS};
}

sub YYBypassrule {
  my $self = shift;

  $self->{GRAMMAR}->[$self->{CURRENT_RULE}][3] = $_[0] if @_;
  return $self->{GRAMMAR}->[$self->{CURRENT_RULE}][3];
}

sub YYFirstline {
  my $self = shift;

  $self->{FIRSTLINE} = $_[0] if @_;
  $self->{FIRSTLINE};
}

# Used as default action when writing a reusable grammar.
# See files examples/recycle/NoacInh.eyp 
# and examples/recycle/icalcu_and_ipost.pl 
# in the Parse::Eyapp distribution
sub YYDelegateaction {
  my $self = shift;

  my $action = $self->YYName;
  
  $self->$action(@_);
}

# Influences the behavior of YYActionforT_X1X2
# YYActionforT_single and YYActionforT_empty
# If true these methods will build simple lists of attributes 
# for the lists operators X*, X+ and X? and parenthesis (X Y)
# Otherwise the classic node construction for the
# syntax tree is used
sub YYBuildingTree {
  my $self = shift;

  $self->{BUILDINGTREE} = $_[0] if @_;
  $self->{BUILDINGTREE};
}

sub BeANode {
  my $class = shift;

    no strict 'refs';
    push @{$class."::ISA"}, "Parse::Eyapp::Node" unless $class->isa("Parse::Eyapp::Node");
}

#sub BeATranslationScheme {
#  my $class = shift;
#
#    no strict 'refs';
#    push @{$class."::ISA"}, "Parse::Eyapp::TranslationScheme" unless $class->isa("Parse::Eyapp::TranslationScheme");
#}

{
  my $attr =  sub { 
      $_[0]{attr} = $_[1] if @_ > 1;
      $_[0]{attr}
    };

  sub make_node_classes {
    my $self = shift;
    my $prefix = $self->YYPrefix() || '';

    { no strict 'refs';
      *{$prefix."TERMINAL::attr"} = $attr;
    }

    for (@_) {
       my ($class) = split /:/, $_;
       BeANode("$prefix$class"); 
    }

    my $accessors = $self->YYAccessors();
    for (keys %$accessors) {
      my $position = $accessors->{$_};
      no strict 'refs';
      *{$prefix.$_} = sub {
        my $self = shift;

        return $self->child($position, @_)
      }
    } # for
  }
}

####################################################################
# Usage      : ????
# Purpose    : Responsible for the %tree directive 
#              On each production the default action becomes:
#              sub { goto &Parse::Eyapp::Driver::YYBuildAST }
#
# Returns    : ????
# Parameters : ????
# Throws     : no exceptions
# Comments   : none
# See Also   : n/a
# To Do      : many things: Optimize this!!!!
sub YYBuildAST { 
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside(); # Symbols on the right hand side of the production
  my $lhs = $self->YYLhs;
  my $fullname = $self->YYName();
  my ($name) = split /:/, $fullname;
  my $bypass = $self->YYBypassrule; # Boolean: shall we do bypassing of lonely nodes?
  my $class = "$PREFIX$name";
  my @children;

  my $node = bless {}, $class;

  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i]; # The symbol
    my $ch = $_[$i]; # The attribute/reference

    # is $ch already a Parse::Eyapp::Node. May be a terminal and a syntax variable share the same name?
    unless (UNIVERSAL::isa($ch, 'Parse::Eyapp::Node')) {
      if ($self->YYIssemantic($_)) {
        my $class = $PREFIX.'TERMINAL';
        my $node = bless { token => $_, attr => $ch, children => [] }, $class;
        push @children, $node;
        next;
      }

      if ($self->YYIsterm($_)) {
        TERMINAL::save_attributes($ch, $node) if UNIVERSAL::can($PREFIX."TERMINAL", "save_attributes");
        next;
      }
    }

    if (UNIVERSAL::isa($ch, $PREFIX."_PAREN")) { # Warning: weak code!!!
      push @children, @{$ch->{children}};
      next;
    }

    # If it is an intermediate semantic action skip it
    next if $_ =~ qr{@}; # intermediate rule
    next unless ref($ch);
    push @children, $ch;
  }

  
  if ($bypass and @children == 1) {
    $node = $children[0]; 

    my $childisterminal = ref($node) =~ /TERMINAL$/;
    # Re-bless unless is "an automatically named node", but the characterization of this is 
    bless $node, $class unless $name =~ /${lhs}_\d+$/; # lazy, weak (and wicked).

   
    my $finalclass =  ref($node);
    $childisterminal and !$finalclass->isa($PREFIX.'TERMINAL') 
      and do { 
        no strict 'refs';
        push @{$finalclass."::ISA"}, $PREFIX.'TERMINAL' 
      };

    return $node;
  }
  $node->{children} = \@children; 
  return $node;
}

sub YYBuildTS { 
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside(); # Symbols on the right hand side of the production
  my $lhs = $self->YYLhs;
  my $fullname = $self->YYName();
  my ($name) = split /:/, $fullname;
  my $class;
  my @children;

  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i]; # The symbol
    my $ch = $_[$i]; # The attribute/reference

    if ($self->YYIsterm($_)) { 
      $class = $PREFIX.'TERMINAL';
      push @children, bless { token => $_, attr => $ch, children => [] }, $class;
      next;
    }

    if (UNIVERSAL::isa($ch, $PREFIX."_PAREN")) { # Warning: weak code!!!
      push @children, @{$ch->{children}};
      next;
    }

    # Substitute intermediate code node _CODE(CODE()) by CODE()
    if (UNIVERSAL::isa($ch, $PREFIX."_CODE")) { # Warning: weak code!!!
      push @children, $ch->child(0);
      next;
    }

    next unless ref($ch);
    push @children, $ch;
  }

  if (unpack('A1',$lhs) eq '@') { # class has to be _CODE check
          $lhs =~ /^\@[0-9]+\-([0-9]+)$/
      or  croak "In line rule name '$lhs' ill formed: report it as a BUG.\n";
      my $dotpos = $1;
 
      croak "Fatal error building metatree when processing  $lhs -> @right" 
      unless exists($_[$dotpos]) and UNIVERSAL::isa($_[$dotpos], 'CODE') ; 
      push @children, $_[$dotpos];
  }
  else {
    my $code = $_[@right];
    if (UNIVERSAL::isa($code, 'CODE')) {
      push @children, $code; 
    }
    else {
      croak "Fatal error building translation scheme. Code or undef expected" if (defined($code));
    }
  }

  $class = "$PREFIX$name";
  my $node = bless { children => \@children }, $class; 
  $node;
}

sub YYActionforT_TX1X2_tree {
  my $self = shift;
  my $head = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside();
  my $class;

  for(my $i = 1; $i < @right; $i++) {
    local $_ = $right[$i];
    my $ch = $_[$i-1];
    if ($self->YYIssemantic($_)) {
      $class = $PREFIX.'TERMINAL';
      push @{$head->{children}}, bless { token => $_, attr => $ch, children => [] }, $class;
      
      next;
    }
    next if $self->YYIsterm($_);
    if (ref($ch) eq  $PREFIX."_PAREN") { # Warning: weak code!!!
      push @{$head->{children}}, @{$ch->{children}};
      next;
    }
    next unless ref($ch);
    push @{$head->{children}}, $ch;
  }

  return $head;
}

# For * and + lists 
# S2 -> S2 X         { push @$_[1] the node associated with X; $_[1] }
# S2 -> /* empty */  { a node with empty children }
sub YYActionforT_TX1X2 {
  goto &YYActionforT_TX1X2_tree if $_[0]->YYBuildingTree;

  my $self = shift;
  my $head = shift;

  push @$head, @_;
  return $head;
}

sub YYActionforParenthesis {
  goto &YYBuildAST if $_[0]->YYBuildingTree;

  my $self = shift;

  return [ @_ ];
}


sub YYActionforT_empty_tree {
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my $name = $self->YYName();

  # Allow use of %name
  my $class = $PREFIX.$name;
  my $node = bless { children => [] }, $class;
  #BeANode($class);
  $node;
}

sub YYActionforT_empty {
  goto &YYActionforT_empty_tree  if $_[0]->YYBuildingTree;

  [];
}

sub YYActionforT_single_tree {
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my $name = $self->YYName();
  my @right = $self->YYRightside();
  my $class;

  # Allow use of %name
  my @t;
  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i];
    my $ch = $_[$i];
    if ($self->YYIssemantic($_)) {
      $class = $PREFIX.'TERMINAL';
      push @t, bless { token => $_, attr => $ch, children => [] }, $class;
      #BeANode($class);
      next;
    }
    next if $self->YYIsterm($_);
    if (ref($ch) eq  $PREFIX."_PAREN") { # Warning: weak code!!!
      push @t, @{$ch->{children}};
      next;
    }
    next unless ref($ch);
    push @t, $ch;
  }
  $class = $PREFIX.$name;
  my $node = bless { children => \@t }, $class;
  #BeANode($class);
  $node;
}

sub YYActionforT_single {
  goto &YYActionforT_single_tree  if $_[0]->YYBuildingTree;

  my $self = shift;
  [ @_ ];
}

### end Casiano methods

sub YYCurtok {
  my($self)=shift;

        @_
    and ${$$self{TOKEN}}=$_[0];
    ${$$self{TOKEN}};
}

sub YYCurval {
  my($self)=shift;

        @_
    and ${$$self{VALUE}}=$_[0];
    ${$$self{VALUE}};
}

{
  sub YYSimStack {
    my $self = shift;
    my $stack = shift;
    my @reduce = @_;
    my @expected;

    for my $index (@reduce) {
      my ($lhs, $length) = @{$self->{RULES}[-$index]};
      if (@$stack > $length) {
        my @auxstack = @$stack;
        splice @auxstack, -$length if $length;

        my $state = $auxstack[-1]->[0];
        my $nextstate = $self->{STATES}[$state]{GOTOS}{$lhs};
        if (defined($nextstate)) {
          push @auxstack, [$nextstate, undef];
          push @expected, $self->YYExpected(\@auxstack);
        }
      }
      # else something went wrong!!! See Frank Leray report
    }

    return map { $_ => 1 } @expected;
  }

  sub YYExpected {
    my($self)=shift;
    my $stack = shift;

    # The state in the top of the stack
    my $state = $self->{STATES}[$stack->[-1][0]];

    my %actions;
    %actions = %{$state->{ACTIONS}} if exists $state->{ACTIONS};

    # The keys of %reduction are the -production numbers
    # Use hashes and not lists to guarantee that no tokens are repeated
    my (%expected, %reduce); 
    for (keys(%actions)) {
      if ($actions{$_} > 0) { # shift
        $expected{$_} = 1;
        next;
      }
      $reduce{$actions{$_}} = 1;
    }
    $reduce{$state->{DEFAULT}} = 1 if exists($state->{DEFAULT});

    if (keys %reduce) {
      %expected = (%expected, $self->YYSimStack($stack, keys %reduce));
    }
    
    return keys %expected;
  }

  sub YYExpect {
    my $self = shift;
    $self->YYExpected($self->{STACK}, @_);
  }
}

# $self->expects($token) : returns true if the token is among the expected ones
sub expects {
  my $self = shift;
  my $token = shift;

  my @expected = $self->YYExpect;
  return grep { $_ eq $token } @expected;
}

BEGIN {
*YYExpects = \&expects;
}

# Set/Get a static/class attribute for $class
# Searches the $class ancestor tree for  an ancestor
# having defined such attribute. If found, that value is returned
sub static_attribute { 
    my $class = shift;
    $class = ref($class) if ref($class);
    my $attributename = shift;

    # class/static method
    no strict 'refs';
    my $classlexer;
    my $classname = $classlexer = $class.'::'.$attributename;
    if (@_) {
      ${$classlexer} = shift;
    }

    return ${$classlexer} if defined($$classlexer);
   
    # Traverse the inheritance tree for a defined
    # version of the attribute
    my @classes = @{$class.'::ISA'};
    my %classes = map { $_ => undef } @classes;
    while (@classes) {
      my $c = shift @classes || return;  
      $classlexer = $c.'::'.$attributename;
      if (defined($$classlexer)) {
        $$classname = $$classlexer;
        return $$classlexer;
      }
      # push those that aren't already there
      push @classes, grep { !exists $classes{$_} } @{$c.'::ISA'};
    }
    return undef;
}

sub YYEndOfInput {
   my $self = shift;

   for (${$self->input}) {
     return !defined($_) || ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
   }
}

#################
# Private stuff #
#################


sub _CheckParams {
  my ($mandatory,$checklist,$inarray,$outhash)=@_;
  my ($prm,$value);
  my ($prmlst)={};

  while(($prm,$value)=splice(@$inarray,0,2)) {
        $prm=uc($prm);
      exists($$checklist{$prm})
    or  croak("Unknown parameter '$prm'");
      ref($value) eq $$checklist{$prm}
    or  croak("Invalid value for parameter '$prm'");
        $prm=unpack('@2A*',$prm);
    $$outhash{$prm}=$value;
  }
  for (@$mandatory) {
      exists($$outhash{$_})
    or  croak("Missing mandatory parameter '".lc($_)."'");
  }
}

#################### TailSupport ######################
sub line {
  my $self = shift;

  if (ref($self)) {
    $self->{TOKENLINE} = shift if @_;

    return $self->static_attribute('TOKENLINE', @_,) unless defined($self->{TOKENLINE}); # class/static method 
    return $self->{TOKENLINE};
  }
  else { # class/static method
    return $self->static_attribute('TOKENLINE', @_,); # class/static method 
  }
}

# attribute to count the lines
sub tokenline {
  my $self = shift;

  if (ref($self)) {
    $self->{TOKENLINE} += shift if @_;

    return $self->static_attribute('TOKENLINE', @_,) unless defined($self->{TOKENLINE}); # class/static method 
    return $self->{TOKENLINE};
  }
  else { # class/static method
    return $self->static_attribute('TOKENLINE', @_,); # class/static method 
  }
}

our $ERROR = \&_Error;
sub error {
  my $self = shift;

  if (ref $self) { # instance method
    $self->{ERROR} = shift if @_;

    return $self->static_attribute('ERROR', @_,) unless defined($self->{ERROR}); # class/static method 
    return $self->{ERROR};
  }
  else { # class/static method
    return $self->static_attribute('ERROR', @_,); # class/static method 
  }
}

# attribute with the input
# is a reference to the actual input
# slurp_file. 
# Parameters: object or class, filename, prompt messagge, mode (interactive or not: undef or "\n")
*YYSlurpFile = \&slurp_file;
sub slurp_file {
  my $self = shift;
  my $fn = shift;
  my $f;

  my $mode = undef;
  if ($fn && -r $fn) {
    open $f, $fn  or die "Can't find file '$fn'!\n";
  }
  else {
    $f = \*STDIN;
    my $msg = $self->YYPrompt();
    $mode = shift;
    print($msg) if $msg;
  }
  $self->YYInputFile($f);

  local $/ = $mode;
  my $input = <$f>;

  if (ref($self)) {  # called as object method
    $self->input(\$input);
  }
  else { # class/static method
    my $classinput = $self.'::input';
    ${$classinput}->input(\$input);
  }
}

our $INPUT = \undef;
*Parse::Eyapp::Driver::YYInput = \&input;
sub input {
  my $self = shift;

  $self->line(1) if @_; # used as setter
  if (ref $self) { # instance method
    if (@_) {
      if (ref $_[0]) {
        $self->{INPUT} = shift;
      }
      else {
        my $input = shift;
        $self->{INPUT} = \$input;
      }
    }

    return $self->static_attribute('INPUT', @_,) unless defined($self->{INPUT}); # class/static method 
    return $self->{INPUT};
  }
  else { # class/static method
    return $self->static_attribute('INPUT', @_,); # class/static method 
  }
}
*YYInput = \&input;  # alias

# Opened file used to get the input
# static and instance method
our $INPUTFILE = \*STDIN;
sub YYInputFile {
  my $self = shift;

  if (ref($self)) { # object method
     my $file = shift;
     if ($file) { # setter
       $self->{INPUTFILE} = $file;
     }
    
    return $self->static_attribute('INPUTFILE', @_,) unless defined($self->{INPUTFILE}); # class/static method 
    return $self->{INPUTFILE};
  }
  else { # static
    return $self->static_attribute('INPUTFILE', @_,); # class/static method 
  }
}


our $PROMPT;
sub YYPrompt {
  my $self = shift;

  if (ref($self)) { # object method
     my $prompt = shift;
     if ($prompt) { # setter
       $self->{PROMPT} = $prompt;
     }
    
    return $self->static_attribute('PROMPT', @_,) unless defined($self->{PROMPT}); # class/static method 
    return $self->{PROMPT};
  }
  else { # static
    return $self->static_attribute('PROMPT', @_,); # class/static method 
  }
}

# args: parser, debug and optionally the input or a reference to the input
sub Run {
  my ($self) = shift;
  my $yydebug = shift;
  
  if (defined($_[0])) {
    if (ref($_[0])) { # if arg is a reference
      $self->input(shift());
    }
    else { # arg isn't a ref: make a copy
      my $x = shift();
      $self->input(\$x);
    }
  }
  croak "Provide some input for parsing" unless ($self->input && defined(${$self->input()}));
  return $self->YYParse( 
    #yylex => $self->lexer(), 
    #yyerror => $self->error(),
    yydebug => $yydebug, # 0xF
  );
}
*Parse::Eyapp::Driver::YYRun = \&run;

# args: class, prompt, file, optionally input (ref or not)
# return the abstract syntax tree (or whatever was returned by the parser)
*Parse::Eyapp::Driver::YYMain = \&main;
sub main {
  my $package = shift;
  my $prompt = shift;

  my $debug = 0;
  my $file = '';
  my $showtree = 0;
  my $TERMINALinfo;
  my $help;
  my $slurp;
  my $inputfromfile = 1;
  my $commandinput = '';
  my $quotedcommandinput = '';
  my $yaml = 0;
  my $dot = 0;

  my $result = GetOptions (
    "debug!"         => \$debug,         # sets yydebug on
    "file=s"         => \$file,          # read input from that file
    "commandinput=s" => \$commandinput,  # read input from command line arg
    "tree!"          => \$showtree,      # prints $tree->str
    "info"           => \$TERMINALinfo,  # prints $tree->str and provides default TERMINAL::info
    "help"           => \$help,          # shows SYNOPSIS section from the script pod
    "slurp!"         => \$slurp,         # read until EOF or CR is reached
    "argfile!"       => \$inputfromfile, # take input string from @_
    "yaml"           => \$yaml,          # dumps YAML for $tree: YAML must be installed
    "dot=s"          => \$dot,          # dumps YAML for $tree: YAML must be installed
    "margin=i"       => \$Parse::Eyapp::Node::INDENT,      
  );

  $package->_help() if $help;

  $debug = 0x1F if $debug;
  $file = shift if !$file && @ARGV; # file is taken from the @ARGV unless already defined
  $slurp = "\n" if defined($slurp);

  my $parser = $package->new();
  $parser->YYPrompt($prompt) if defined($prompt);

  if ($commandinput) {
    $parser->input(\$commandinput);
  }
  elsif ($inputfromfile) {
    $parser->slurp_file( $file, $slurp);
  }
  else { # input must be a string argument
    croak "No input provided for parsing! " unless defined($_[0]);
    if (ref($_[0])) {
      $parser->input(shift());
    }
    else {
      my $x = shift();
      $parser->input(\$x);
    }
  }

  if (defined($TERMINALinfo)) {
    my $prefix = ($parser->YYPrefix || '');
    no strict 'refs';
    *{$prefix.'TERMINAL::info'} = sub { 
      (ref($_[0]->attr) eq 'ARRAY')? $_[0]->attr->[0] : $_[0]->attr 
    };
  }

  my $tree = $parser->Run( $debug, @_ );

  if (my $ne = $parser->YYNberr > 0) {
    print "There were $ne errors during parsing\n";
    return undef;
  }
  else {
    if ($showtree) {
      if ($tree && blessed $tree && $tree->isa('Parse::Eyapp::Node')) {

          print $tree->str()."\n";
      }
      elsif ($tree && ref $tree) {
        require Data::Dumper;
        print Data::Dumper::Dumper($tree)."\n";
      }
      elsif (defined($tree)) {
        print "$tree\n";
      }
    }
    if ($yaml && ref($tree)) {
      eval {
        require YAML;
      };
      if ($@) {
        print "You must install 'YAML' to use this option\n";
      }
      else {
        YAML->import;
        print Dump($tree);
      }
    }
    if ($dot && blessed($tree)) {
      my ($sfile, $extension) = $dot =~ /^(.*)\.([^.]*)$/;
      $extension = 'png' unless (defined($extension) and $tree->can($extension));
      ($sfile) = $file =~ m{(.*[^.])} if !defined($sfile) and defined($file);
      $tree->$extension($sfile);
    }

    return $tree
  }
}

sub _help {
  my $package = shift;

  print << 'AYUDA';
Available options:
    --debug                    sets yydebug on
    --nodebug                  sets yydebug off
    --file filepath            read input from filepath
    --commandinput string      read input from string
    --tree                     prints $tree->str
    --notree                   does not print $tree->str
    --info                     When printing $tree->str shows the value of TERMINALs
    --help                     shows this help
    --slurp                    read until EOF reached
    --noslurp                  read until CR is reached
    --argfile                  main() will take the input string from its @_
    --noargfile                main() will not take the input string from its @_
    --yaml                     dumps YAML for $tree: YAML module must be installed
    --margin=i                 controls the indentation of $tree->str (i.e. $Parse::Eyapp::Node::INDENT)      
    --dot format               produces a .dot and .format file (png,jpg,bmp, etc.)
AYUDA

  $package->help() if ($package & $package->can("help"));

  exit(0);
}

# Generic error handler
# Convention adopted: if the attribute of a token is an object
# assume it has 'line' and 'str' methods. Otherwise, if it
# is an array, follows the convention [ str, line, ...]
# otherwise is just an string representing the value of the token
sub _Error {
  my $parser = shift;

  my $yydata = $parser->YYData;

    exists $yydata->{ERRMSG}
  and do {
      warn $yydata->{ERRMSG};
      delete $yydata->{ERRMSG};
      return;
  };

  my ($attr)=$parser->YYCurval;

  my $stoken = '';

  if (blessed($attr) && $attr->can('str')) {
     $stoken = " near '".$attr->str."'"
  }
  elsif (ref($attr) eq 'ARRAY') {
    $stoken = " near '".$attr->[0]."'";
  }
  else {
    if ($attr) {
      $stoken = " near '$attr'";
    }
    else {
      $stoken = " near end of input";
    }
  }

  my @expected = map { ($_ ne '')? "'$_'" : q{'end of input'}} $parser->YYExpect();
  my $expected = '';
  if (@expected) {
    $expected = (@expected >1) ? "Expected one of these terminals: @expected" 
                              : "Expected terminal: @expected"
  }

  my $tline = '';
  if (blessed($attr) && $attr->can('line')) {
    $tline = " (line number ".$attr->line.")" 
  }
  elsif (ref($attr) eq 'ARRAY') {
    $tline = " (line number ".$attr->[1].")";
  }
  else {
    # May be the parser object knows the line number ?
    my $lineno = $parser->line;
    $tline = " (line number $lineno)" if $lineno > 1;
  }

  local $" = ', ';
  warn << "ERRMSG";

Syntax error$stoken$tline. 
$expected
ERRMSG
};

################ end TailSupport #####################

sub _DBLoad {

  #Already loaded ?
  __PACKAGE__->can('_DBParse') and return;
  
  my($fname)=__FILE__;
  my(@drv);
  local $/ = "\n";
  if (open(DRV,"<$fname")) {
    local $_;
    while(<DRV>) {
       #/^\s*sub\s+_Parse\s*{\s*$/ .. /^\s*}\s*#\s*_Parse\s*$/ and do {
       /^my\s+\$lex;##!!##$/ .. /^\s*}\s*#\s*_Parse\s*$/ and do {
          s/^#DBG>//;
          push(@drv,$_);
      }
    }
    close(DRV);

    $drv[1]=~s/_P/_DBP/;
    eval join('',@drv);
  }
  else {
    # TODO: debugging for standalone modules isn't supported yet
    *Parse::Eyapp::Driver::_DBParse = \&_Parse;
  }
}

### Receives an  index for the parsing stack: -1 is the top
### Returns the symbol associated with the state $index
sub YYSymbol {
  my $self = shift;
  my $index = shift;
  
  return $self->{STACK}[$index][2];
}

# # YYSymbolStack(0,-k) string with symbols from 0 to last-k
# # YYSymbolStack(-k-2,-k) string with symbols from last-k-2 to last-k
# # YYSymbolStack(-k-2,-k, filter) string with symbols from last-k-2 to last-k that match with filter
# # YYSymbolStack('SYMBOL',-k, filter) string with symbols from the last occurrence of SYMBOL to last-k
# #                                    where filter can be code, regexp or string
# sub YYSymbolStack {
#   my $self = shift;
#   my ($a, $b, $filter) = @_;
#   
#   # $b must be negative
#   croak "Error: Second index in YYSymbolStack must be negative\n" unless $b < 0;
# 
#   my $stack = $self->{STACK};
#   my $bottom = -@{$stack};
#   unless (looks_like_number($a)) {
#     # $a is a string: search from the top to the bottom for $a. Return empty list if not found
#     # $b must be a negative number
#     # $b must be a negative number
#     my $p = $b;
#     while ($p >= $bottom) {
#       last if (defined($stack->[$p][2]) && ($stack->[$p][2] eq $a));
#       $p--;
#     }
#     return () if $p < $bottom;
#     $a = $p;
#   }
#   # If positive, $a is an offset from the bottom of the stack 
#   $a = $bottom+$a if $a >= 0;
#   
#   my @a = map { $self->YYSymbol($_) or '' } $a..$b;
#    
#   return @a                          unless defined $filter;          # no filter
#   return (grep { $filter->{$_} } @a) if reftype($filter) && (reftype($filter) eq 'CODE');   # sub
#   return (grep  /$filter/, @a)       if reftype($filter) && (reftype($filter) eq 'SCALAR'); # regexp
#   return (grep { $_ eq $filter } @a);                                  # string
# }

#Note that for loading debugging version of the driver,
#this file will be parsed from 'sub _Parse' up to '}#_Parse' inclusive.
#So, DO NOT remove comment at end of sub !!!
my $lex;##!!##
sub _Parse {
    my($self)=shift;

  #my $lex = $self->{LEX};

  my($rules,$states,$error)
     = @$self{ 'RULES', 'STATES', 'ERROR' };
  my($errstatus,$nberror,$token,$value,$stack,$check,$dotpos)
     = @$self{ 'ERRST', 'NBERR', 'TOKEN', 'VALUE', 'STACK', 'CHECK', 'DOTPOS' };

  my %conflictiveStates = %{$self->{STATECONFLICT}};
#DBG> my($debug)=$$self{DEBUG};
#DBG> my($dbgerror)=0;

#DBG> my($ShowCurToken) = sub {
#DBG>   my($tok)='>';
#DBG>   for (split('',$$token)) {
#DBG>     $tok.=    (ord($_) < 32 or ord($_) > 126)
#DBG>         ? sprintf('<%02X>',ord($_))
#DBG>         : $_;
#DBG>   }
#DBG>   $tok.='<';
#DBG> };

  $$errstatus=0;
  $$nberror=0;
  ($$token,$$value)=(undef,undef);
  @$stack=( [ 0, undef, ] );
#DBG>   push(@{$stack->[-1]}, undef);
  #@$stack=( [ 0, undef, undef ] );
  $$check='';

    while(1) {
        my($actions,$act,$stateno);

        $self->{POS} = pos(${$self->input()});
        $stateno=$$stack[-1][0];
        if (exists($conflictiveStates{$stateno})) {
          #warn "Conflictive state $stateno managed by conflict handler '$conflictiveStates{$stateno}{name}'\n" 
          for my $h (@{$conflictiveStates{$stateno}}) {
            $self->{CURRENT_LHS} = $h->{name};
            $h->{codeh}($self);
          }
        }

        # check if the state is a conflictive one,
        # if so, execute its conflict handlers
        $actions=$$states[$stateno];

#DBG> print STDERR ('-' x 40),"\n";
#DBG>   $debug & 0x2
#DBG> and print STDERR "In state $stateno:\n";
#DBG>   $debug & 0x08
#DBG> and print STDERR "Stack: ".
#DBG>          join('->',map { defined($$_[2])? "'$$_[2]'->".$$_[0] : $$_[0] } @$stack).
#DBG>          "\n";


        if  (exists($$actions{ACTIONS})) {

        defined($$token)
            or  do {
        ($$token,$$value)=$self->{LEX}->($self); # original line
        #($$token,$$value)=$self->$lex;   # to make it a method call
        #($$token,$$value) = $self->{LEX}->($self); # sensitive to the lexer changes
#DBG>       $debug & 0x01
#DBG>     and do { 
#DBG>       print STDERR "Need token. Got ".&$ShowCurToken."\n";
#DBG>     };
      };

            $act=   exists($$actions{ACTIONS}{$$token})
                    ?   $$actions{ACTIONS}{$$token}
                    :   exists($$actions{DEFAULT})
                        ?   $$actions{DEFAULT}
                        :   undef;
        }
        else {
            $act=$$actions{DEFAULT};
#DBG>     $debug & 0x01
#DBG>   and print STDERR "Don't need token.\n";
        }

            defined($act)
        and do {

                $act > 0
            and do {        #shift

#DBG>       $debug & 0x04
#DBG>     and print STDERR "Shift and go to state $act.\n";

          $$errstatus
        and do {
          --$$errstatus;

#DBG>         $debug & 0x10
#DBG>       and $dbgerror
#DBG>       and $$errstatus == 0
#DBG>       and do {
#DBG>         print STDERR "**End of Error recovery.\n";
#DBG>         $dbgerror=0;
#DBG>       };
        };


        push(@$stack,[ $act, $$value ]);
#DBG>   push(@{$stack->[-1]},$$token);

          defined($$token) and ($$token ne '') #Don't eat the eof
              and $$token=$$value=undef;
                next;
            };

            #reduce
            my($lhs,$len,$code,@sempar,$semval);
            ($lhs,$len,$code)=@{$$rules[-$act]};

#DBG>     $debug & 0x04
#DBG>   and $act
#DBG>   #and  print STDERR "Reduce using rule ".-$act." ($lhs,$len): "; # old Parse::Yapp line
#DBG>   and do { my @rhs = @{$self->{GRAMMAR}->[-$act]->[2]};
#DBG>            @rhs = ( '/* empty */' ) unless @rhs;
#DBG>            my $rhs = "@rhs";
#DBG>            $rhs = substr($rhs, 0, 30).'...' if length($rhs) > 30; # chomp if too large
#DBG>            print STDERR "Reduce using rule ".-$act." ($lhs --> $rhs): "; 
#DBG>          };

                $act
            or  $self->YYAccept();

            $$dotpos=$len;

                unpack('A1',$lhs) eq '@'    #In line rule
            and do {
                    $lhs =~ /^\@[0-9]+\-([0-9]+)$/
                or  die "In line rule name '$lhs' ill formed: ".
                        "report it as a BUG.\n";
                $$dotpos = $1;
            };

            @sempar =       $$dotpos
                        ?   map { $$_[1] } @$stack[ -$$dotpos .. -1 ]
                        :   ();

            $self->{CURRENT_LHS} = $lhs;
            $self->{CURRENT_RULE} = -$act; # count the super-rule?
            $semval = $code ? $self->$code( @sempar )
                            : @sempar ? $sempar[0] : undef;

            splice(@$stack,-$len,$len);

                $$check eq 'ACCEPT'
            and do {

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Accept.\n";

        return($semval);
      };

                $$check eq 'ABORT'
            and do {

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Abort.\n";

        return(undef);

      };

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Back to state $$stack[-1][0], then ";

                $$check eq 'ERROR'
            or  do {
#DBG>       $debug & 0x04
#DBG>     and print STDERR 
#DBG>           "go to state $$states[$$stack[-1][0]]{GOTOS}{$lhs}.\n";

#DBG>       $debug & 0x10
#DBG>     and $dbgerror
#DBG>     and $$errstatus == 0
#DBG>     and do {
#DBG>       print STDERR "**End of Error recovery.\n";
#DBG>       $dbgerror=0;
#DBG>     };

          push(@$stack,
                     [ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval, ]);
                     #[ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval, $lhs ]);
#DBG>     push(@{$stack->[-1]},$lhs);
                $$check='';
                $self->{CURRENT_LHS} = undef;
                next;
            };

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Forced Error recovery.\n";

            $$check='';

        };

        #Error
            $$errstatus
        or   do {

            $$errstatus = 1;
            &$error($self);
                $$errstatus # if 0, then YYErrok has been called
            or  next;       # so continue parsing

#DBG>     $debug & 0x10
#DBG>   and do {
#DBG>     print STDERR "**Entering Error recovery.\n";
#DBG>     { 
#DBG>       local $" = ", "; 
#DBG>       my @expect = map { ">$_<" } $self->YYExpect();
#DBG>       print STDERR "Expecting one of: @expect\n";
#DBG>     };
#DBG>     ++$dbgerror;
#DBG>   };

            ++$$nberror;

        };

      $$errstatus == 3  #The next token is not valid: discard it
    and do {
        $$token eq '' # End of input: no hope
      and do {
#DBG>       $debug & 0x10
#DBG>     and print STDERR "**At eof: aborting.\n";
        return(undef);
      };

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Discard invalid token ".&$ShowCurToken.".\n";

      $$token=$$value=undef;
    };

        $$errstatus=3;

    while(    @$stack
        and (   not exists($$states[$$stack[-1][0]]{ACTIONS})
              or  not exists($$states[$$stack[-1][0]]{ACTIONS}{error})
          or  $$states[$$stack[-1][0]]{ACTIONS}{error} <= 0)) {

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Pop state $$stack[-1][0].\n";

      pop(@$stack);
    }

      @$stack
    or  do {

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**No state left on stack: aborting.\n";

      return(undef);
    };

    #shift the error token

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Shift \$error token and go to state ".
#DBG>            $$states[$$stack[-1][0]]{ACTIONS}{error}.
#DBG>            ".\n";

    push(@$stack, [ $$states[$$stack[-1][0]]{ACTIONS}{error}, undef, 'error' ]);

    }

    #never reached
  croak("Error in driver logic. Please, report it as a BUG");

}#_Parse
#DO NOT remove comment

*Parse::Eyapp::Driver::lexer = \&Parse::Eyapp::Driver::YYLexer;
sub YYLexer {
  my $self = shift;

  if (ref $self) { # instance method
    # The class attribute isn't changed, only the instance
    $self->{LEX} = shift if @_;

    return $self->static_attribute('LEX', @_,) unless defined($self->{LEX}); # class/static method 
    return $self->{LEX};
  }
  else {
    return $self->static_attribute('LEX', @_,);
  }
}


1;


MODULE_Parse_Eyapp_Driver
    }; # Unless Parse::Eyapp::Driver was loaded
  } ########### End of BEGIN { load /home/toni/perl5/lib/perl5/Parse/Eyapp/Driver.pm }

  # Loading Parse::Eyapp::Node
  BEGIN {
    unless (Parse::Eyapp::Node->can('m')) {
      eval << 'MODULE_Parse_Eyapp_Node'
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon, all rights reserved.
package Parse::Eyapp::Node;
use strict;
use Carp;
no warnings 'recursion';use List::Util qw(first);
use Data::Dumper;

our $FILENAME=__FILE__;

sub firstval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[0]
}

sub lastval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[-1]
}

####################################################################
# Usage      : 
# line: %name PROG
#        exp <%name EXP + ';'>
#                 { @{$lhs->{t}} = map { $_->{t}} ($lhs->child(0)->children()); }
# ;
# Returns    : The array of children of the node. When the tree is a
#              translation scheme the CODE references are also included
# Parameters : the node (method)
# See Also   : Children

sub children {
  my $self = CORE::shift;
  
  return () unless UNIVERSAL::can($self, 'children');
  @{$self->{children}} = @_ if @_;
  @{$self->{children}}
}

####################################################################
# Usage      :  line: %name PROG
#                        (exp) <%name EXP + ';'>
#                          { @{$lhs->{t}} = map { $_->{t}} ($_[1]->Children()); }
#
# Returns    : The true children of the node, excluding CODE CHILDREN
# Parameters : The Node object

sub Children {
  my $self = CORE::shift;
  
  return () unless UNIVERSAL::can($self, 'children');

  @{$self->{children}} = @_ if @_;
  grep { !UNIVERSAL::isa($_, 'CODE') } @{$self->{children}}
}

####################################################################
# Returns    : Last non CODE child
# Parameters : the node object

sub Last_child {
  my $self = CORE::shift;

  return unless UNIVERSAL::can($self, 'children') and @{$self->{children}};
  my $i = -1;
  $i-- while defined($self->{children}->[$i]) and UNIVERSAL::isa($self->{children}->[$i], 'CODE');
  return  $self->{children}->[$i];
}

sub last_child {
  my $self = CORE::shift;

  return unless UNIVERSAL::can($self, 'children') and @{$self->{children}};
  ${$self->{children}}[-1];
}

####################################################################
# Usage      :  $node->child($i)
#  my $transform = Parse::Eyapp::Treeregexp->new( STRING => q{
#     commutative_add: PLUS($x, ., $y, .)
#       => { my $t = $x; $_[0]->child(0, $y); $_[0]->child(2, $t)}
#  }
# Purpose    : Setter-getter to modify a specific child of a node
# Returns    : Child with index $i. Returns undef if the child does not exists
# Parameters : Method: the node and the index of the child. The new value is used 
#              as a setter.
# Throws     : Croaks if the index parameter is not provided
sub child {
  my ($self, $index, $value) = @_;
  
  #croak "$self is not a Parse::Eyapp::Node" unless $self->isa('Parse::Eyapp::Node');
  return undef unless  UNIVERSAL::can($self, 'child');
  croak "Index not provided" unless defined($index);
  $self->{children}[$index] = $value if defined($value);
  $self->{children}[$index];
}

sub descendant {
  my $self = shift;
  my $coord = shift;

  my @pos = split /\./, $coord;
  my $t = $self;
  my $x = shift(@pos); # discard the first empty dot
  for (@pos) {
      croak "Error computing descendant: $_ is not a number\n" 
    unless m{\d+} and $_ < $t->children;
    $t = $t->child($_);
  }
  return $t;
}

####################################################################
# Usage      : $node->s(@transformationlist);
# Example    : The following example simplifies arithmetic expressions
# using method "s":
# > cat Timeszero.trg
# /* Operator "and" has higher priority than comma "," */
# whatever_times_zero: TIMES(@b, NUM($x) and { $x->{attr} == 0 }) => { $_[0] = $NUM }
#
# > treereg Timeszero
# > cat arrays.pl
#  !/usr/bin/perl -w
#  use strict;
#  use Rule6;
#  use Parse::Eyapp::Treeregexp;
#  use Timeszero;
#
#  my $parser = new Rule6();
#  my $t = $parser->Run;
#  $t->s(@Timeszero::all);
#
#
# Returns    : Nothing
# Parameters : The object (is a method) and the list of transformations to apply.
#              The list may be a list of Parse::Eyapp:YATW objects and/or CODE
#              references
# Throws     : No exceptions
# Comments   : The set of transformations is repeatedly applied to the node
#              until there are no changes.
#              The function may hang if the set of transformations
#              matches forever.
# See Also   : The "s" method for Parse::Eyapp::YATW objects 
#              (i.e. transformation objects)

sub s {
  my @patterns = @_[1..$#_];

  # Make them Parse::Eyapp:YATW objects if they are CODE references
  @patterns = map { ref($_) eq 'CODE'? 
                      Parse::Eyapp::YATW->new(
                        PATTERN => $_,
                        #PATTERN_ARGS => [],
                      )
                      :
                      $_
                  } 
                  @patterns;
  my $changes; 
  do { 
    $changes = 0;
    foreach (@patterns) {
      $_->{CHANGES} = 0;
      $_->s($_[0]);
      $changes += $_->{CHANGES};
    }
  } while ($changes);
}


####################################################################
# Usage      : ????
# Purpose    : bud = Bottom Up Decoration: Decorates the tree with flowers :-)
#              The purpose is to decorate the AST with attributes during
#              the context-dependent analysis, mainly type-checking.
# Returns    : ????
# Parameters : The transformations.
# Throws     : no exceptions
# Comments   : The tree is traversed bottom-up. The set of
#              transformations is applied to each node in the order
#              supplied by the user. As soon as one succeeds
#              no more transformations are applied.
# See Also   : n/a
# To Do      : Avoid closure. Save @patterns inside the object
{
  my @patterns;

  sub bud {
    @patterns = @_[1..$#_];

    @patterns = map { ref($_) eq 'CODE'? 
                        Parse::Eyapp::YATW->new(
                          PATTERN => $_,
                          #PATTERN_ARGS => [],
                        )
                        :
                        $_
                    } 
                    @patterns;
    _bud($_[0], undef, undef);
  }

  sub _bud {
    my $node = $_[0];
    my $index = $_[2];

      # Is an odd leaf. Not actually a Parse::Eyapp::Node. Decorate it and leave
      if (!ref($node) or !UNIVERSAL::can($node, "children"))  {
        for my $p (@patterns) {
          return if $p->pattern->(
            $_[0],  # Node being visited  
            $_[1],  # Father of this node
            $index, # Index of this node in @Father->children
            $p,  # The YATW pattern object   
          );
        }
      };

      # Recursively decorate subtrees
      my $i = 0;
      for (@{$node->{children}}) {
        $_->_bud($_, $_[0], $i);
        $i++;
      }

      # Decorate the node
      #Change YATW object to be the  first argument?
      for my $p (@patterns) {
        return if $p->pattern->($_[0], $_[1], $index, $p); 
      }
  }
} # closure for @patterns

####################################################################
# Usage      : 
# @t = Parse::Eyapp::Node->new( q{TIMES(NUM(TERMINAL), NUM(TERMINAL))}, 
#      sub { 
#        our ($TIMES, @NUM, @TERMINAL);
#        $TIMES->{type}       = "binary operation"; 
#        $NUM[0]->{type}      = "int"; 
#        $NUM[1]->{type}      = "float"; 
#        $TERMINAL[1]->{attr} = 3.5; 
#      },
#    );
# Purpose    : Multi-Constructor
# Returns    : Array of pointers to the objects created
#              in scalar context a pointer to the first node
# Parameters : The class plus the string description and attribute handler

{

my %cache;

  sub m_bless {

    my $key = join "",@_;
    my $class = shift;
    return $cache{$key} if exists $cache{$key};

    my $b = bless { children => \@_}, $class;
    $cache{$key} = $b;

    return $b;
  }
}

sub _bless {
  my $class = shift;

  my $b = bless { children => \@_ }, $class;
  return $b;
}

sub hexpand {
  my $class = CORE::shift;

  my $handler = CORE::pop if ref($_[-1]) eq 'CODE';
  my $n = m_bless(@_);

  my $newnodeclass = CORE::shift;

  no strict 'refs';
  push @{$newnodeclass."::ISA"}, 'Parse::Eyapp::Node' unless $newnodeclass->isa('Parse::Eyapp::Node');

  if (defined($handler) and UNIVERSAL::isa($handler, "CODE")) {
    $handler->($n);
  }

  $n;
}

sub hnew {
  my $blesser = \&m_bless;

  return _new($blesser, @_);
}

# Regexp for a full Perl identifier
sub _new {
  my $blesser = CORE::shift;
  my $class = CORE::shift;
  local $_ = CORE::shift; # string: tree description
  my $handler = CORE::shift if ref($_[0]) eq 'CODE';


  my %classes;
  my $b;
  #TODO: Shall I receive a prefix?

  my (@stack, @index, @results, %results, @place, $open);
  #skip white spaces
  s{\A\s+}{};
  while ($_) {
    # If is a leaf is followed by parenthesis or comma or an ID
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s*([),])} 
     {$1()$2} # ... then add an empty pair of parenthesis
      and do { 
        next; 
       };

    # If is a leaf is followed by an ID
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s+([A-Za-z_])} 
     {$1()$2} # ... then add an empty pair of parenthesis
      and do { 
        next; 
       };

    # If is a leaf at the end
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s*$} 
     {$1()} # ... then add an empty pair of parenthesis
      and do { 
        $classes{$1} = 1;
        next; 
       };

    # Is an identifier
    s{\A([A-Za-z_][A-Za-z0-9_:]*)}{} 
      and do { 
        $classes{$1} = 1;
        CORE::push @stack, $1; 
        next; 
      };

    # Open parenthesis: mark the position for when parenthesis closes
    s{\A[(]}{} 
      and do { 
        my $pos = scalar(@stack);
        CORE::push @index, $pos; 
        $place[$pos] = $open++;

        # Warning! I don't know what I am doing
        next;
      };

    # Skip commas
    s{\A,}{} and next; 

    # Closing parenthesis: time to build a node
    s{\A[)]}{} and do { 
        croak "Syntax error! Closing parenthesis has no left partner!" unless @index;
        my $begin = pop @index; # check if empty!
        my @children = splice(@stack, $begin);
        my $class = pop @stack;
        croak "Syntax error! Any couple of parenthesis must be preceded by an identifier"
          unless (defined($class) and $class =~ m{^[a-zA-Z_][\w:]*$});

        $b = $blesser->($class, @children);

        CORE::push @stack, $b;
        $results[$place[$begin]] = $b;
        CORE::push @{$results{$class}}, $b;
        next; 
    }; 

    last unless $_;

    #skip white spaces
    croak "Error building Parse::Eyapp::Node tree at '$_'." unless s{\A\s+}{};
  } # while
  croak "Syntax error! Open parenthesis has no right partner!" if @index;
  { 
    no strict 'refs';
    for (keys(%classes)) {
      push @{$_."::ISA"}, 'Parse::Eyapp::Node' unless $_->isa('Parse::Eyapp::Node');
    }
  }
  if (defined($handler) and UNIVERSAL::isa($handler, "CODE")) {
    $handler->(@results);
  }
  return wantarray? @results : $b;
}

sub new {
  my $blesser = \&_bless;

  _new($blesser, @_);
}

## Used by _subtree_list
#sub compute_hierarchy {
#  my @results = @{shift()};
#
#  # Compute the hierarchy
#  my $b;
#  my @r = @results;
#  while (@results) {
#    $b = pop @results;
#    my $d = $b->{depth};
#    my $f = lastval { $_->{depth} < $d} @results;
#    
#    $b->{father} = $f;
#    $b->{children} = [];
#    unshift @{$f->{children}}, $b;
#  }
#  $_->{father} = undef for @results;
#  bless $_, "Parse::Eyapp::Node::Match" for @r;
#  return  @r;
#}

# Matches

sub m {
  my $self = shift;
  my @patterns = @_ or croak "Expected a pattern!";
  croak "Error in method m of Parse::Eyapp::Node. Expected Parse::Eyapp:YATW patterns"
    unless $a = first { !UNIVERSAL::isa($_, "Parse::Eyapp:YATW") } @_;

  # array context: return all matches
  local $a = 0;
  my %index = map { ("$_", $a++) } @patterns;
  my @stack = (
    Parse::Eyapp::Node::Match->new( 
       node => $self, 
       depth => 0,  
       dewey => "", 
       patterns =>[] 
    ) 
  );
  my @results;
  do {
    my $mn = CORE::shift(@stack);
    my %n = %$mn;

    # See what patterns do match the current $node
    for my $pattern (@patterns) {
      push @{$mn->{patterns}}, $index{$pattern} if $pattern->{PATTERN}($n{node});
    } 
    my $dewey = $n{dewey};
    if (@{$mn->{patterns}}) {
      $mn->{family} = \@patterns;

      # Is at this time that I have to compute the father
      my $f = lastval { $dewey =~ m{^$_->{dewey}}} @results;
      $mn->{father} = $f;
      # ... and children
      push @{$f->{children}}, $mn if defined($f);
      CORE::push @results, $mn;
    }
    my $childdepth = $n{depth}+1;
    my $k = -1;
    CORE::unshift @stack, 
          map 
            { 
              $k++; 
              Parse::Eyapp::Node::Match->new(
                node => $_, 
                depth => $childdepth, 
                dewey => "$dewey.$k", 
                patterns => [] 
              ) 
            } $n{node}->children();
  } while (@stack);

  wantarray? @results : $results[0];
}

#sub _subtree_scalar {
#  # scalar context: return iterator
#  my $self = CORE::shift;
#  my @patterns = @_ or croak "Expected a pattern!";
#
#  # %index gives the index of $p in @patterns
#  local $a = 0;
#  my %index = map { ("$_", $a++) } @patterns;
#
#  my @stack = ();
#  my $mn = { node => $self, depth => 0, patterns =>[] };
#  my @results = ();
#
#  return sub {
#     do {
#       # See if current $node matches some patterns
#       my $d = $mn->{depth};
#       my $childdepth = $d+1;
#       # See what patterns do match the current $node
#       for my $pattern (@patterns) {
#         push @{$mn->{patterns}}, $index{$pattern} if $pattern->{PATTERN}($mn->{node});
#       } 
#
#       if (@{$mn->{patterns}}) { # matched
#         CORE::push @results, $mn;
#
#         # Compute the hierarchy
#         my $f = lastval { $_->{depth} < $d} @results;
#         $mn->{father} = $f;
#         $mn->{children} = [];
#         $mn->{family} = \@patterns;
#         unshift @{$f->{children}}, $mn if defined($f);
#         bless $mn, "Parse::Eyapp::Node::Match";
#
#         # push children in the stack
#         CORE::unshift @stack, 
#                   map { { node => $_, depth => $childdepth, patterns => [] } } 
#                                                       $mn->{node}->children();
#         $mn = CORE::shift(@stack);
#         return $results[-1];
#       }
#       # didn't match: push children in the stack
#       CORE::unshift @stack, 
#                  map { { node => $_, depth => $childdepth, patterns => [] } } 
#                                                      $mn->{node}->children();
#       $mn = CORE::shift(@stack);
#     } while ($mn); # May be the stack is empty now, but if $mn then there is a node to process
#     # reset iterator
#     my @stack = ();
#     my $mn = { node => $self, depth => 0, patterns =>[] };
#     return undef;
#   };
#}

# Factorize this!!!!!!!!!!!!!!
#sub m {
#  goto &_subtree_list if (wantarray()); 
#  goto &_subtree_scalar;
#}

####################################################################
# Usage      :   $BLOCK->delete($ASSIGN)
#                $BLOCK->delete(2)
# Purpose    : deletes the specified child of the node
# Returns    : The deleted child
# Parameters : The object plus the index or pointer to the child to be deleted
# Throws     : If the object can't do children or has no children
# See Also   : n/a

sub delete {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer

  croak "Parse::Eyapp::Node::delete error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);
  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::delete warning: node:\n".Parse::Eyapp::Node::str($self)
           ."\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)
           ."\nThe node was not deleted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i, 1);
    return $child;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::delete error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child, 1);
  return $child;
}

####################################################################
# Usage      : $BLOCK->shift
# Purpose    : deletes the first child of the node
# Returns    : The deleted child
# Parameters : The object 
# Throws     : If the object can't do children 
# See Also   : n/a

sub shift {
  my $self = CORE::shift; # The tree object

  croak "Parse::Eyapp::Node::shift error, node:\n"
       .Parse::Eyapp::Node->str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children');

  return CORE::shift(@{$self->{children}});
}

sub unshift {
  my $self = CORE::shift; # The tree object
  my $node = CORE::shift; # node to insert

  CORE::unshift @{$self->{children}}, $node;
}

sub push {
  my $self = CORE::shift; # The tree object
  #my $node = CORE::shift; # node to insert

  #CORE::push @{$self->{children}}, $node;
  CORE::push @{$self->{children}}, @_;
}

sub insert_before {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer
  my $node = CORE::shift; # node to insert

  croak "Parse::Eyapp::Node::insert_before error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);

  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::insert_before warning: node:\n"
           .Parse::Eyapp::Node::str($self)
           ."\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)."\nThe node was not inserted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i, 0, $node);
    return $node;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::insert_before error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child, 0, $node);
  return $child;
}

sub insert_after {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer
  my $node = CORE::shift; # node to insert

  croak "Parse::Eyapp::Node::insert_after error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);

  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::insert_after warning: node:\n"
           .Parse::Eyapp::Node::str($self).
           "\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)."\nThe node was not inserted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i+1, 0, $node);
    return $node;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::insert_after error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child+1, 0, $node);
  return $child;
}

{ # $match closure

  my $match;

  sub clean_tree {
    $match = pop;
    croak "clean tree: a node and code reference expected" unless (ref($match) eq 'CODE') and (@_ > 0);
    $_[0]->_clean_tree();
  }

  sub _clean_tree {
    my @children;
    
    for ($_[0]->children()) {
      next if (!defined($_) or $match->($_));
      
      $_->_clean_tree();
      CORE::push @children, $_;
    }
    $_[0]->{children} = \@children; # Bad code
  }
} # $match closure

####################################################################
# Usage      : $t->str 
# Returns    : Returns a string describing the Parse::Eyapp::Node as a term
#              i.e., s.t. like: 'PROGRAM(FUNCTION(RETURN(TERMINAL,VAR(TERMINAL))))'
our @PREFIXES = qw(Parse::Eyapp::Node::);
our $INDENT = 0; # -1 new 0 = compact, 1 = indent, 2 = indent and include Types in closing parenthesis
our $STRSEP = ',';
our $DELIMITER = '[';
our $FOOTNOTE_HEADER = "\n---------------------------\n";
our $FOOTNOTE_SEP = ")\n";
our $FOOTNOTE_LEFT = '^{';
our $FOOTNOTE_RIGHT = '}';
our $LINESEP = 4;
our $CLASS_HANDLER = sub { type($_[0]) }; # What to print to identify the node

my %match_del = (
  '[' => ']',
  '{' => '}',
  '(' => ')',
  '<' => '>'
);

my $pair;
my $footnotes = '';
my $footnote_label;

sub str {

  my @terms;

  # Consume arg only if called as a class method Parse::Eyap::Node->str($node1, $node2, ...)
  CORE::shift unless ref($_[0]);

  for (@_) {
    $footnote_label = 0;
    $footnotes = '';
    # Set delimiters for semantic values
    if (defined($DELIMITER) and exists($match_del{$DELIMITER})) {
      $pair = $match_del{$DELIMITER};
    }
    else {
      $DELIMITER = $pair = '';
    }
    CORE::push @terms,  _str($_).$footnotes;
  }
  return wantarray? @terms : $terms[0];
}  

sub _str {
  my $self = CORE::shift;          # root of the subtree
  my $indent = (CORE::shift or 0); # current depth in spaces " "

  my @children = Parse::Eyapp::Node::children($self);
  my @t;

  my $res;
  my $fn = $footnote_label;
  if ($INDENT >= 0 && UNIVERSAL::can($self, 'footnote')) {
    $res = $self->footnote; 
    $footnotes .= $FOOTNOTE_HEADER.$footnote_label++.$FOOTNOTE_SEP.$res if $res;
  }

  # recursively visit nodes
  for (@children) {
    CORE::push @t, Parse::Eyapp::Node::_str($_, $indent+2) if defined($_);
  }
  local $" = $STRSEP;
  my $class = $CLASS_HANDLER->($self);
  $class =~ s/^$_// for @PREFIXES; 
  my $information;
  $information = $self->info if ($INDENT >= 0 && UNIVERSAL::can($self, 'info'));
  $class .= $DELIMITER.$information.$pair if defined($information);
  if ($INDENT >= 0 &&  $res) {
   $class .= $FOOTNOTE_LEFT.$fn.$FOOTNOTE_RIGHT;
  }

  if ($INDENT > 0) {
    my $w = " "x$indent;
    $class = "\n$w$class";
    $class .= "(@t\n$w)" if @children;
    $class .= " # ".$CLASS_HANDLER->($self) if ($INDENT > 1) and ($class =~ tr/\n/\n/>$LINESEP);
  }
  else {
    $class .= "(@t)" if @children;
  }
  return $class;
}

sub _dot {
  my ($root, $number) = @_;

  my $type = $root->type();

  my $information;
  $information = $root->info if ($INDENT >= 0 && $root->can('info'));
  my $class = $CLASS_HANDLER->($root);
  $class = qq{$class<font color="red">$DELIMITER$information$pair</font>} if defined($information);

  my $dot = qq{  $number [label = <$class>];\n};

  my $k = 0;
  my @dots = map { $k++; $_->_dot("$number$k") }  $root->children;

  for($k = 1; $k <= $root->children; $k++) {;
    $dot .= qq{  $number -> $number$k;\n};
  }

  return $dot.join('',@dots);
}

sub dot {
  my $dot = $_[0]->_dot('0');
  return << "EOGRAPH";
digraph G {
ordering=out

$dot
}
EOGRAPH
}

sub fdot {
  my ($self, $file) = @_;

  if ($file) {
    $file .= '.dot' unless $file =~ /\.dot$/;
  }
  else {
    $file = $self->type().".dot";
  }
  open my $f, "> $file";
  print $f $self->dot();
  close($f);
}

BEGIN {
  my @dotFormats = qw{bmp canon cgimage cmap cmapx cmapx_np eps exr fig gd gd2 gif gv imap imap_np ismap jp2 jpe jpeg jpg pct pdf pict plain plain-ext png ps ps2 psd sgi svg svgz tga tif tiff tk vml vmlz vrml wbmp x11 xdot xlib};

  for my $format (@dotFormats) {
     
    no strict 'refs';
    *{'Parse::Eyapp::Node::'.$format} = sub { 
       my ($self, $file) = @_;
   
       $file = $self->type() unless defined($file);
   
       $self->fdot($file);
   
       $file =~ s/\.(dot|$format)$//;
       my $dotfile = "$file.dot";
       my $pngfile = "$file.$format";
       my $err = qx{dot -T$format $dotfile -o $pngfile 2>&1};
       return ($err, $?);
    }
  }
}

sub translation_scheme {
  my $self = CORE::shift; # root of the subtree
  my @children = $self->children();
  for (@children) {
    if (ref($_) eq 'CODE') {
      $_->($self, $self->Children);
    }
    elsif (defined($_)) {
      translation_scheme($_);
    }
  }
}

sub type {
 my $type = ref($_[0]);

 if ($type) {
   if (defined($_[1])) {
     $type = $_[1];
     Parse::Eyapp::Driver::BeANode($type);
     bless $_[0], $type;
   }
   return $type 
 }
 return 'Parse::Eyapp::Node::STRING';
}

{ # Tree "fuzzy" equality

####################################################################
# Usage      : $t1->equal($t2, n => sub { return $_[0] == $_[1] })
# Purpose    : Checks the equality between two AST
# Returns    : 1 if equal, 0 if not 'equal'
# Parameters : Two Parse::Eyapp:Node nodes and a hash of comparison handlers.
#              The keys of the hash are the attributes of the nodes. The value is
#              a comparator function. The comparator for key $k receives the attribute
#              for the nodes being visited and rmust return true if they are considered similar
# Throws     : exceptions if the parameters aren't Parse::Eyapp::Nodes

  my %handler;

  # True if the two trees look similar
  sub equal {
    croak "Parse::Eyapp::Node::equal error. Expected two syntax trees \n" unless (@_ > 1);

    %handler = splice(@_, 2);
    my $key = '';
    defined($key=firstval {!UNIVERSAL::isa($handler{$_},'CODE') } keys %handler) 
    and 
      croak "Parse::Eyapp::Node::equal error. Expected a CODE ref for attribute $key\n";
    goto &_equal;
  }

  sub _equal {
    my $tree1 = CORE::shift;
    my $tree2 = CORE::shift;

    # Same type
    return 0 unless ref($tree1) eq ref($tree2);

    # Check attributes via handlers
    for (keys %handler) {
      # Check for existence
      return 0 if (exists($tree1->{$_}) && !exists($tree2->{$_}));
      return 0 if (exists($tree2->{$_}) && !exists($tree1->{$_}));

      # Check for definition
      return 0 if (defined($tree1->{$_}) && !defined($tree2->{$_}));
      return 0 if (defined($tree2->{$_}) && !defined($tree1->{$_}));

      # Check for equality
      return 0 unless $handler{$_}->($tree1->{$_}, $tree2->{$_});
    }

    # Same number of children
    my @children1 = @{$tree1->{children}};
    my @children2 = @{$tree2->{children}};
    return 0 unless @children1 == @children2;

    # Children must be similar
    for (@children1) {
      my $ch2 = CORE::shift @children2;
      return 0 unless _equal($_, $ch2);
    }
    return 1;
  }
}

1;

package Parse::Eyapp::Node::Match;
our @ISA = qw(Parse::Eyapp::Node);

# A Parse::Eyapp::Node::Match object is a reference
# to a tree of Parse::Eyapp::Nodes that has been used
# in a tree matching regexp. You can think of them
# as the equivalent of $1 $2, ... in treeregexeps

# The depth of the Parse::Eyapp::Node being referenced

sub new {
  my $class = shift;

  my $matchnode = { @_ };
  $matchnode->{children} = [];
  bless $matchnode, $class;
}

sub depth {
  my $self = shift;

  return $self->{depth};
}

# The coordinates of the Parse::Eyapp::Node being referenced
sub coord {
  my $self = shift;

  return $self->{dewey};
}


# The Parse::Eyapp::Node being referenced
sub node {
  my $self = shift;

  return $self->{node};
}

# The Parse::Eyapp::Node:Match that references
# the nearest ancestor of $self->{node} that matched
sub father {
  my $self = shift;

  return $self->{father};
}
  
# The patterns that matched with $self->{node}
# Indexes
sub patterns {
  my $self = shift;

  @{$self->{patterns}} = @_ if @_;
  return @{$self->{patterns}};
}
  
# The original list of patterns that produced this match
sub family {
  my $self = shift;

  @{$self->{family}} = @_ if @_;
  return @{$self->{family}};
}
  
# The names of the patterns that matched
sub names {
  my $self = shift;

  my @indexes = $self->patterns;
  my @family = $self->family;

  return map { $_->{NAME} or "Unknown" } @family[@indexes];
}
  
sub info {
  my $self = shift;

  my $node = $self->node;
  my @names = $self->names;
  my $nodeinfo;
  if (UNIVERSAL::can($node, 'info')) {
    $nodeinfo = ":".$node->info;
  }
  else {
    $nodeinfo = "";
  }
  return "[".ref($self->node).":".$self->depth.":@names$nodeinfo]"
}

1;



MODULE_Parse_Eyapp_Node
    }; # Unless Parse::Eyapp::Node was loaded
  } ########### End of BEGIN { load /home/toni/perl5/lib/perl5/Parse/Eyapp/Node.pm }

  # Loading Parse::Eyapp::YATW
  BEGIN {
    unless (Parse::Eyapp::YATW->can('m')) {
      eval << 'MODULE_Parse_Eyapp_YATW'
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon, all rights reserved.
package Parse::Eyapp::YATW;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use List::Util qw(first);

sub firstval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[0]
}

sub lastval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[-1]
}

sub valid_keys {
  my %valid_args = @_;

  my @valid_args = keys(%valid_args); 
  local $" = ", "; 
  return "@valid_args" 
}

sub invalid_keys {
  my $valid_args = shift;
  my $args = shift;

  return (first { !exists($valid_args->{$_}) } keys(%$args));
}


our $VERSION = $Parse::Eyapp::Driver::VERSION;

our $FILENAME=__FILE__;

# TODO: Check args. Typical args:
# 'CHANGES' => 0,
# 'PATTERN' => sub { "DUMMY" },
# 'NAME' => 'fold',
# 'PATTERN_ARGS' => [],
# 'PENDING_TASKS' => {},
# 'NODE' => []

my %_new_yatw = (
  PATTERN => 'CODE',
  NAME => 'STRING',
);

my $validkeys = valid_keys(%_new_yatw); 

sub new {
  my $class = shift;
  my %args = @_;

  croak "Error. Expected a code reference when building a tree walker. " unless (ref($args{PATTERN}) eq 'CODE');
  if (defined($a = invalid_keys(\%_new_yatw, \%args))) {
    croak("Parse::Eyapp::YATW::new Error!: unknown argument $a. Valid arguments are: $validkeys")
  }


  # obsolete, I have to delete this
  #$args{PATTERN_ARGS} = [] unless (ref($args{PATTERN_ARGS}) eq 'ARRAY'); 

  # Internal fields

  # Tell us if the node has changed after the visit
  $args{CHANGES} = 0;
  
  # PENDING_TASKS is a queue storing the tasks waiting for a "safe time/node" to do them 
  # Usually that time occurs when visiting the father of the node who generated the job 
  # (when asap criteria is applied).
  # Keys are node references. Values are array references. Each entry defines:
  #  [ the task kind, the node where to do the job, and info related to the particular job ]
  # Example: @{$self->{PENDING_TASKS}{$father}}, ['insert_before', $node, ${$self->{NODE}}[0] ];
  $args{PENDING_TASKS} = {};

  # NODE is a stack storing the ancestor of the node being visited
  # Example: my $ancestor = ${$self->{NODE}}[$k]; when k=1 is the father, k=2 the grandfather, etc.
  # Example: CORE::unshift @{$self->{NODE}}, $_[0]; Finished the visit so take it out
  $args{NODE} = [];

  bless \%args, $class;
}

sub buildpatterns {
  my $class = shift;
  
  my @family;
  while (my ($n, $p) = splice(@_, 0,2)) {
    push @family, Parse::Eyapp::YATW->new(NAME => $n, PATTERN => $p);
  }
  return wantarray? @family : $family[0];
}

####################################################################
# Usage      : @r = $b{$_}->m($t)
#              See Simple4.eyp and m_yatw.pl in the examples directory
# Returns    : Returns an array of nodes matching the treeregexp
#              The set of nodes is a Parse::Eyapp::Node::Match tree 
#              showing the relation between the matches
# Parameters : The tree (and the object of course)
# depth is no longer used: eliminate
sub m {
  my $p = shift(); # pattern YATW object
  my $t = shift;   # tree
  my $pattern = $p->{PATTERN}; # CODE ref

  # References to the found nodes are stored in @stack
  my @stack = ( Parse::Eyapp::Node::Match->new(node=>$t, depth=>0, dewey => "") ); 
  my @results;
  do {
    my $n = CORE::shift(@stack);
    my %n = %$n;

    my $dewey = $n->{dewey};
    my $d = $n->{depth};
    if ($pattern->($n{node})) {
      $n->{family} = [ $p ];
      $n->{patterns} = [ 0 ];

      # Is at this time that I have to compute the father
      my $f = lastval { $dewey =~ m{^$_->{dewey}}} @results;
      $n->{father} = $f;
      # ... and children
      push @{$f->{children}}, $n if defined($f);
      push @results, $n;
    }
    my $k = 0;
    CORE::unshift @stack, 
       map { 
              local $a;
              $a = Parse::Eyapp::Node::Match->new(node=>$_, depth=>$d+1, dewey=>"$dewey.$k" );
              $k++;
              $a;
           } $n{node}->children();
  } while (@stack);

  return wantarray? @results : $results[0];
}

######################### getter-setter for YATW objects ###########################

sub pattern {
  my $self = shift;
  $self->{PATTERN} = shift if (@_);
  return $self->{PATTERN};
}

sub name {
  my $self = shift;
  $self->{NAME} = shift if (@_);
  return $self->{NAME};
}

#sub pattern_args {
#  my $self = shift;
#
#  $self->{PATTERN_ARGS} = @_ if @_;
#  return @{$self->{PATTERN_ARGS}};
#}

########################## PENDING TASKS management ################################

# Purpose    : Deletes the node that matched from the list of children of its father. 
sub delete {
  my $self = shift;

  bless $self->{NODE}[0], 'Parse::Eyapp::Node::DELETE';
}
  
sub make_delete_effective {
  my $self = shift;
  my $node = shift;

  my $i = -1+$node->children;
  while ($i >= 0) {
    if (UNIVERSAL::isa($node->child($i), 'Parse::Eyapp::Node::DELETE')) {
      $self->{CHANGES}++ if defined(splice(@{$node->{children}}, $i, 1));
    }
    $i--;
  }
}

####################################################################
# Usage      :    my $b = Parse::Eyapp::Node->new( 'NUM(TERMINAL)', sub { $_[1]->{attr} = 4 });
#                 $yatw_pattern->unshift($b); 
# Parameters : YATW object, node to insert, 
#              ancestor offset: 0 = root of the tree that matched, 1 = father, 2 = granfather, etc.

sub unshift {
  my ($self, $node, $k) = @_;
  $k = 1 unless defined($k); # father by default

  my $ancestor = ${$self->{NODE}}[$k];
  croak "unshift: does not exist ancestor $k of node ".Dumper(${$self->{NODE}}[0]) unless defined($ancestor);

  # Stringification of $ancestor. Hope it works
                                            # operation, node to insert, 
  push @{$self->{PENDING_TASKS}{$ancestor}}, ['unshift', $node ];
}

sub insert_before {
  my ($self, $node) = @_;

  my $father = ${$self->{NODE}}[1];
  croak "insert_before: does not exist father of node ".Dumper(${$self->{NODE}}[0]) unless defined($father);

                                           # operation, node to insert, before this node 
  push @{$self->{PENDING_TASKS}{$father}}, ['insert_before', $node, ${$self->{NODE}}[0] ];
}

sub _delayed_insert_before {
  my ($father, $node, $before) = @_;

  my $i = 0;
  for ($father->children()) {
    last if ($_ == $before);
    $i++;
  }
  splice @{$father->{children}}, $i, 0, $node;
}

sub do_pending_tasks {
  my $self = shift;
  my $node = shift;

  my $mytasks = $self->{PENDING_TASKS}{$node};
  while ($mytasks and (my $job = shift @{$mytasks})) {
    my @args = @$job;
    my $task = shift @args;

    # change this for a jump table
    if ($task eq 'unshift') {
      CORE::unshift(@{$node->{children}}, @args);
      $self->{CHANGES}++;
    }
    elsif ($task eq 'insert_before') {
      _delayed_insert_before($node, @args);
      $self->{CHANGES}++;
    }
  }
}

####################################################################
# Parameters : pattern, node, father of the node, index of the child in the children array
# YATW object. Probably too many 
sub s {
  my $self = shift;
  my $node = $_[0] or croak("Error. Method __PACKAGE__::s requires a node");
  CORE::unshift @{$self->{NODE}}, $_[0];
  # father is $_[1]
  my $index = $_[2];

  # If is not a reference or can't children then simply check the matching and leave
  if (!ref($node) or !UNIVERSAL::can($node, "children"))  {
                                         
    $self->{CHANGES}++ if $self->pattern->(
      $_[0],  # Node being visited  
      $_[1],  # Father of this node
      $index, # Index of this node in @Father->children
      $self,  # The YATW pattern object   
    );
    return;
  };
  
  # Else, is not a leaf and is a regular Parse::Eyapp::Node
  # Recursively transform subtrees
  my $i = 0;
  for (@{$node->{children}}) {
    $self->s($_, $_[0], $i);
    $i++;
  }
  
  my $number_of_changes = $self->{CHANGES};
  # Now is safe to delete children nodes that are no longer needed
  $self->make_delete_effective($node);

  # Safely do pending jobs for this node
  $self->do_pending_tasks($node);

  #node , father, childindex, and ... 
  #Change YATW object to be the  first argument?
  if ($self->pattern->($_[0], $_[1], $index, $self)) {
    $self->{CHANGES}++;
  }
  shift @{$self->{NODE}};
}

1;


MODULE_Parse_Eyapp_YATW
    }; # Unless Parse::Eyapp::YATW was loaded
  } ########### End of BEGIN { load /home/toni/perl5/lib/perl5/Parse/Eyapp/YATW.pm }



sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }



# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(delay|diff\(|\)\:\=|\)\=|\:\=|\/|\!|\(|\)|\=|\,|\-|\*|\^|\+)}gc and return ($1, $1);

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


#line 3466 ./infix2pharmml_statement.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@infix2pharmml_statement::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'statement', '$end' ], 0 ],
  [ 'statement_1' => 'statement', [ 'common' ], 0 ],
  [ 'statement_2' => 'statement', [ 'equation' ], 0 ],
  [ 'statement_3' => 'statement', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'statement_4' => 'statement', [ 'VAR', '(', 'varlist', '):=', 'equation' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-4', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-5', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [ 'DESCRIPTION' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-6', [  ], 0 ],
  [ 'common_11' => 'common', [ 'VAR', ':=', 'equation', 'OPTIONAL-4' ], 0 ],
  [ 'common_12' => 'common', [ 'diff(', 'VAR', ',', 'VAR', ')=', 'equation', 'OPTIONAL-5' ], 0 ],
  [ 'common_13' => 'common', [ 'diff(', 'VAR', ',', 'VAR', '):=', 'equation', 'OPTIONAL-6' ], 0 ],
  [ 'equation_14' => 'equation', [ 'expr' ], 0 ],
  [ 'expr_15' => 'expr', [ 'expr', '+', 'expr' ], 0 ],
  [ 'expr_16' => 'expr', [ 'expr', '-', 'expr' ], 0 ],
  [ 'expr_17' => 'expr', [ 'expr', '*', 'expr' ], 0 ],
  [ 'expr_18' => 'expr', [ 'expr', '/', 'expr' ], 0 ],
  [ 'expr_19' => 'expr', [ 'expr', '^', 'expr' ], 0 ],
  [ 'expr_20' => 'expr', [ 'NUM' ], 0 ],
  [ 'expr_21' => 'expr', [ 'constant' ], 0 ],
  [ 'expr_22' => 'expr', [ 'expr', '!' ], 0 ],
  [ 'expr_23' => 'expr', [ '+', 'expr' ], 0 ],
  [ 'expr_24' => 'expr', [ '-', 'expr' ], 0 ],
  [ 'expr_25' => 'expr', [ '(', 'expr', ')' ], 0 ],
  [ 'expr_26' => 'expr', [ 'UNIOP', '(', 'expr', ')' ], 0 ],
  [ 'expr_27' => 'expr', [ 'BINOP', '(', 'expr', ',', 'expr', ')' ], 0 ],
  [ 'expr_28' => 'expr', [ 'delay', '(', 'VAR', ',', 'VAR', ')' ], 0 ],
  [ 'expr_29' => 'expr', [ 'VAR', '(', 'argpairlist', ')' ], 0 ],
  [ 'expr_30' => 'expr', [ 'VAR' ], 0 ],
  [ 'constant_31' => 'constant', [ 'NAN' ], 0 ],
  [ 'constant_32' => 'constant', [ 'PI' ], 0 ],
  [ 'constant_33' => 'constant', [ 'EULER' ], 0 ],
  [ 'constant_34' => 'constant', [ 'INF' ], 0 ],
  [ 'argpairlist_35' => 'argpairlist', [ 'argpairlist', ',', 'argpairlist' ], 0 ],
  [ 'argpairlist_36' => 'argpairlist', [ 'VAR', '=', 'equation' ], 0 ],
  [ 'varlist_37' => 'varlist', [ 'varlist', ',', 'varlist' ], 0 ],
  [ 'varlist_38' => 'varlist', [ 'VAR' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'statement_1' => 1,
  'statement_2' => 2,
  'statement_3' => 3,
  'statement_4' => 4,
  '_OPTIONAL' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_OPTIONAL' => 8,
  '_OPTIONAL' => 9,
  '_OPTIONAL' => 10,
  'common_11' => 11,
  'common_12' => 12,
  'common_13' => 13,
  'equation_14' => 14,
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
  'expr_28' => 28,
  'expr_29' => 29,
  'expr_30' => 30,
  'constant_31' => 31,
  'constant_32' => 32,
  'constant_33' => 33,
  'constant_34' => 34,
  'argpairlist_35' => 35,
  'argpairlist_36' => 36,
  'varlist_37' => 37,
  'varlist_38' => 38,
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
	'=' => { ISSEMANTIC => 0 },
	'^' => { ISSEMANTIC => 0 },
	'delay' => { ISSEMANTIC => 0 },
	'diff(' => { ISSEMANTIC => 0 },
	BINOP => { ISSEMANTIC => 1 },
	DESCRIPTION => { ISSEMANTIC => 1 },
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
    yyFILENAME  => 'infix2pharmml_statement.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'BINOP' => 8,
			'PI' => 5,
			'VAR' => 16,
			"delay" => 17,
			"(" => 7,
			"-" => 18,
			'UNIOP' => 9,
			"+" => 10,
			'NUM' => 11,
			"diff(" => 12,
			'EULER' => 2,
			'NAN' => 1,
			'INF' => 14
		},
		GOTOS => {
			'equation' => 3,
			'constant' => 13,
			'statement' => 6,
			'expr' => 15,
			'common' => 4
		}
	},
	{#State 1
		DEFAULT => -31
	},
	{#State 2
		DEFAULT => -33
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		DEFAULT => -1
	},
	{#State 5
		DEFAULT => -32
	},
	{#State 6
		ACTIONS => {
			'' => 19
		}
	},
	{#State 7
		ACTIONS => {
			'BINOP' => 8,
			"(" => 7,
			"-" => 18,
			"delay" => 17,
			'PI' => 5,
			'VAR' => 21,
			'INF' => 14,
			'NAN' => 1,
			'EULER' => 2,
			"+" => 10,
			'UNIOP' => 9,
			'NUM' => 11
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 20
		}
	},
	{#State 8
		ACTIONS => {
			"(" => 22
		}
	},
	{#State 9
		ACTIONS => {
			"(" => 23
		}
	},
	{#State 10
		ACTIONS => {
			'INF' => 14,
			"+" => 10,
			'NUM' => 11,
			'UNIOP' => 9,
			'NAN' => 1,
			'EULER' => 2,
			'BINOP' => 8,
			"-" => 18,
			"(" => 7,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 24
		}
	},
	{#State 11
		DEFAULT => -20
	},
	{#State 12
		ACTIONS => {
			'VAR' => 25
		}
	},
	{#State 13
		DEFAULT => -21
	},
	{#State 14
		DEFAULT => -34
	},
	{#State 15
		ACTIONS => {
			"^" => 28,
			"*" => 29,
			"+" => 27,
			"!" => 30,
			"/" => 31,
			"-" => 26
		},
		DEFAULT => -14
	},
	{#State 16
		ACTIONS => {
			"=" => 33,
			":=" => 32,
			"(" => 34
		},
		DEFAULT => -30
	},
	{#State 17
		ACTIONS => {
			"(" => 35
		}
	},
	{#State 18
		ACTIONS => {
			"delay" => 17,
			'PI' => 5,
			'VAR' => 21,
			"-" => 18,
			"(" => 7,
			'BINOP' => 8,
			'EULER' => 2,
			'NAN' => 1,
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'INF' => 14
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 36
		}
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		ACTIONS => {
			"!" => 30,
			"^" => 28,
			"/" => 31,
			"*" => 29,
			")" => 37,
			"+" => 27,
			"-" => 26
		}
	},
	{#State 21
		ACTIONS => {
			"(" => 38
		},
		DEFAULT => -30
	},
	{#State 22
		ACTIONS => {
			"(" => 7,
			"-" => 18,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			'BINOP' => 8,
			'INF' => 14,
			'UNIOP' => 9,
			"+" => 10,
			'NUM' => 11,
			'EULER' => 2,
			'NAN' => 1
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 39
		}
	},
	{#State 23
		ACTIONS => {
			'BINOP' => 8,
			"-" => 18,
			"(" => 7,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			'INF' => 14,
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'NAN' => 1,
			'EULER' => 2
		},
		GOTOS => {
			'expr' => 40,
			'constant' => 13
		}
	},
	{#State 24
		ACTIONS => {
			"!" => 30,
			"/" => 31,
			"^" => 28,
			"*" => 29
		},
		DEFAULT => -23
	},
	{#State 25
		ACTIONS => {
			"," => 41
		}
	},
	{#State 26
		ACTIONS => {
			'BINOP' => 8,
			'VAR' => 21,
			'PI' => 5,
			"delay" => 17,
			"-" => 18,
			"(" => 7,
			'UNIOP' => 9,
			'NUM' => 11,
			"+" => 10,
			'EULER' => 2,
			'NAN' => 1,
			'INF' => 14
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 42
		}
	},
	{#State 27
		ACTIONS => {
			'BINOP' => 8,
			"-" => 18,
			"(" => 7,
			"delay" => 17,
			'PI' => 5,
			'VAR' => 21,
			'INF' => 14,
			'NAN' => 1,
			'EULER' => 2,
			"+" => 10,
			'NUM' => 11,
			'UNIOP' => 9
		},
		GOTOS => {
			'expr' => 43,
			'constant' => 13
		}
	},
	{#State 28
		ACTIONS => {
			'BINOP' => 8,
			"-" => 18,
			"(" => 7,
			'VAR' => 21,
			'PI' => 5,
			"delay" => 17,
			'INF' => 14,
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'NAN' => 1,
			'EULER' => 2
		},
		GOTOS => {
			'expr' => 44,
			'constant' => 13
		}
	},
	{#State 29
		ACTIONS => {
			'VAR' => 21,
			'PI' => 5,
			"delay" => 17,
			"(" => 7,
			"-" => 18,
			'BINOP' => 8,
			"+" => 10,
			'NUM' => 11,
			'UNIOP' => 9,
			'EULER' => 2,
			'NAN' => 1,
			'INF' => 14
		},
		GOTOS => {
			'expr' => 45,
			'constant' => 13
		}
	},
	{#State 30
		DEFAULT => -22
	},
	{#State 31
		ACTIONS => {
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			"(" => 7,
			"-" => 18,
			'BINOP' => 8,
			'UNIOP' => 9,
			'NUM' => 11,
			"+" => 10,
			'EULER' => 2,
			'NAN' => 1,
			'INF' => 14
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 46
		}
	},
	{#State 32
		ACTIONS => {
			'INF' => 14,
			"+" => 10,
			'NUM' => 11,
			'UNIOP' => 9,
			'NAN' => 1,
			'EULER' => 2,
			"-" => 18,
			"(" => 7,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			'BINOP' => 8
		},
		GOTOS => {
			'expr' => 15,
			'constant' => 13,
			'equation' => 47
		}
	},
	{#State 33
		ACTIONS => {
			'BINOP' => 8,
			"delay" => 17,
			'VAR' => 21,
			'PI' => 5,
			"(" => 7,
			"-" => 18,
			'NAN' => 1,
			'EULER' => 2,
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'INF' => 14
		},
		GOTOS => {
			'expr' => 15,
			'constant' => 13,
			'equation' => 48
		}
	},
	{#State 34
		ACTIONS => {
			'VAR' => 49
		},
		GOTOS => {
			'varlist' => 51,
			'argpairlist' => 50
		}
	},
	{#State 35
		ACTIONS => {
			'VAR' => 52
		}
	},
	{#State 36
		DEFAULT => -24
	},
	{#State 37
		DEFAULT => -25
	},
	{#State 38
		ACTIONS => {
			'VAR' => 53
		},
		GOTOS => {
			'argpairlist' => 50
		}
	},
	{#State 39
		ACTIONS => {
			"^" => 28,
			"," => 54,
			"/" => 31,
			"*" => 29,
			"!" => 30,
			"-" => 26,
			"+" => 27
		}
	},
	{#State 40
		ACTIONS => {
			"^" => 28,
			"/" => 31,
			"*" => 29,
			"!" => 30,
			"-" => 26,
			")" => 55,
			"+" => 27
		}
	},
	{#State 41
		ACTIONS => {
			'VAR' => 56
		}
	},
	{#State 42
		ACTIONS => {
			"*" => 29,
			"^" => 28,
			"/" => 31,
			"!" => 30
		},
		DEFAULT => -16
	},
	{#State 43
		ACTIONS => {
			"!" => 30,
			"/" => 31,
			"*" => 29,
			"^" => 28
		},
		DEFAULT => -15
	},
	{#State 44
		ACTIONS => {
			"!" => 30,
			"^" => 28
		},
		DEFAULT => -19
	},
	{#State 45
		ACTIONS => {
			"!" => 30,
			"^" => 28
		},
		DEFAULT => -17
	},
	{#State 46
		ACTIONS => {
			"^" => 28,
			"!" => 30
		},
		DEFAULT => -18
	},
	{#State 47
		ACTIONS => {
			'DESCRIPTION' => 57
		},
		DEFAULT => -6,
		GOTOS => {
			'OPTIONAL-4' => 58
		}
	},
	{#State 48
		DEFAULT => -3
	},
	{#State 49
		ACTIONS => {
			"=" => 59
		},
		DEFAULT => -38
	},
	{#State 50
		ACTIONS => {
			"," => 61,
			")" => 60
		}
	},
	{#State 51
		ACTIONS => {
			"," => 62,
			"):=" => 63
		}
	},
	{#State 52
		ACTIONS => {
			"," => 64
		}
	},
	{#State 53
		ACTIONS => {
			"=" => 59
		}
	},
	{#State 54
		ACTIONS => {
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'EULER' => 2,
			'NAN' => 1,
			'INF' => 14,
			'BINOP' => 8,
			'VAR' => 21,
			'PI' => 5,
			"delay" => 17,
			"(" => 7,
			"-" => 18
		},
		GOTOS => {
			'constant' => 13,
			'expr' => 65
		}
	},
	{#State 55
		DEFAULT => -26
	},
	{#State 56
		ACTIONS => {
			")=" => 67,
			"):=" => 66
		}
	},
	{#State 57
		DEFAULT => -5
	},
	{#State 58
		DEFAULT => -11
	},
	{#State 59
		ACTIONS => {
			'NUM' => 11,
			"+" => 10,
			'UNIOP' => 9,
			'NAN' => 1,
			'EULER' => 2,
			'INF' => 14,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			"-" => 18,
			"(" => 7,
			'BINOP' => 8
		},
		GOTOS => {
			'constant' => 13,
			'equation' => 68,
			'expr' => 15
		}
	},
	{#State 60
		DEFAULT => -29
	},
	{#State 61
		ACTIONS => {
			'VAR' => 53
		},
		GOTOS => {
			'argpairlist' => 69
		}
	},
	{#State 62
		ACTIONS => {
			'VAR' => 70
		},
		GOTOS => {
			'varlist' => 71
		}
	},
	{#State 63
		ACTIONS => {
			'INF' => 14,
			'NAN' => 1,
			'EULER' => 2,
			"+" => 10,
			'UNIOP' => 9,
			'NUM' => 11,
			'BINOP' => 8,
			"-" => 18,
			"(" => 7,
			"delay" => 17,
			'VAR' => 21,
			'PI' => 5
		},
		GOTOS => {
			'expr' => 15,
			'constant' => 13,
			'equation' => 72
		}
	},
	{#State 64
		ACTIONS => {
			'VAR' => 73
		}
	},
	{#State 65
		ACTIONS => {
			"!" => 30,
			"^" => 28,
			"/" => 31,
			"*" => 29,
			")" => 74,
			"+" => 27,
			"-" => 26
		}
	},
	{#State 66
		ACTIONS => {
			'NAN' => 1,
			'EULER' => 2,
			'UNIOP' => 9,
			"+" => 10,
			'NUM' => 11,
			'INF' => 14,
			'BINOP' => 8,
			"delay" => 17,
			'VAR' => 21,
			'PI' => 5,
			"-" => 18,
			"(" => 7
		},
		GOTOS => {
			'equation' => 75,
			'constant' => 13,
			'expr' => 15
		}
	},
	{#State 67
		ACTIONS => {
			"+" => 10,
			'UNIOP' => 9,
			'NUM' => 11,
			'NAN' => 1,
			'EULER' => 2,
			'INF' => 14,
			'PI' => 5,
			'VAR' => 21,
			"delay" => 17,
			"(" => 7,
			"-" => 18,
			'BINOP' => 8
		},
		GOTOS => {
			'equation' => 76,
			'constant' => 13,
			'expr' => 15
		}
	},
	{#State 68
		DEFAULT => -36
	},
	{#State 69
		DEFAULT => -35
	},
	{#State 70
		DEFAULT => -38
	},
	{#State 71
		DEFAULT => -37
	},
	{#State 72
		DEFAULT => -4
	},
	{#State 73
		ACTIONS => {
			")" => 77
		}
	},
	{#State 74
		DEFAULT => -27
	},
	{#State 75
		ACTIONS => {
			'DESCRIPTION' => 78
		},
		DEFAULT => -10,
		GOTOS => {
			'OPTIONAL-6' => 79
		}
	},
	{#State 76
		ACTIONS => {
			'DESCRIPTION' => 80
		},
		DEFAULT => -8,
		GOTOS => {
			'OPTIONAL-5' => 81
		}
	},
	{#State 77
		DEFAULT => -28
	},
	{#State 78
		DEFAULT => -9
	},
	{#State 79
		DEFAULT => -13
	},
	{#State 80
		DEFAULT => -7
	},
	{#State 81
		DEFAULT => -12
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 4315 ./infix2pharmml_statement.pm
	],
	[#Rule statement_1
		 'statement', 1, undef
#line 4319 ./infix2pharmml_statement.pm
	],
	[#Rule statement_2
		 'statement', 1, undef
#line 4323 ./infix2pharmml_statement.pm
	],
	[#Rule statement_3
		 'statement', 3,
sub {
#line 59 "infix2pharmml_statement.eyp"
infix2pharmml::varass($_[1],$_[3])}
#line 4330 ./infix2pharmml_statement.pm
	],
	[#Rule statement_4
		 'statement', 5,
sub {
#line 60 "infix2pharmml_statement.eyp"
infix2pharmml::funcdef($_[1],$_[3],$_[5])}
#line 4337 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 1,
sub {
#line 65 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4344 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-4', 0,
sub {
#line 65 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4351 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 1,
sub {
#line 66 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4358 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-5', 0,
sub {
#line 66 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4365 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 1,
sub {
#line 68 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4372 ./infix2pharmml_statement.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-6', 0,
sub {
#line 68 "infix2pharmml_statement.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4379 ./infix2pharmml_statement.pm
	],
	[#Rule common_11
		 'common', 4,
sub {
#line 65 "infix2pharmml_statement.eyp"
infix2pharmml::vardef($_[1],$_[3],$_[4])}
#line 4386 ./infix2pharmml_statement.pm
	],
	[#Rule common_12
		 'common', 7,
sub {
#line 67 "infix2pharmml_statement.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 4393 ./infix2pharmml_statement.pm
	],
	[#Rule common_13
		 'common', 7,
sub {
#line 69 "infix2pharmml_statement.eyp"
infix2pharmml::diff($_[2],$_[4],$_[6],$_[7])}
#line 4400 ./infix2pharmml_statement.pm
	],
	[#Rule equation_14
		 'equation', 1,
sub {
#line 75 "infix2pharmml_statement.eyp"
infix2pharmml::eqn($_[1])}
#line 4407 ./infix2pharmml_statement.pm
	],
	[#Rule expr_15
		 'expr', 3,
sub {
#line 79 "infix2pharmml_statement.eyp"
infix2pharmml::b("plus",  $_[1], $_[3])}
#line 4414 ./infix2pharmml_statement.pm
	],
	[#Rule expr_16
		 'expr', 3,
sub {
#line 80 "infix2pharmml_statement.eyp"
infix2pharmml::b("minus", $_[1], $_[3])}
#line 4421 ./infix2pharmml_statement.pm
	],
	[#Rule expr_17
		 'expr', 3,
sub {
#line 81 "infix2pharmml_statement.eyp"
infix2pharmml::b("times", $_[1], $_[3])}
#line 4428 ./infix2pharmml_statement.pm
	],
	[#Rule expr_18
		 'expr', 3,
sub {
#line 82 "infix2pharmml_statement.eyp"
infix2pharmml::b("divide",$_[1], $_[3])}
#line 4435 ./infix2pharmml_statement.pm
	],
	[#Rule expr_19
		 'expr', 3,
sub {
#line 83 "infix2pharmml_statement.eyp"
infix2pharmml::b("power", $_[1], $_[3])}
#line 4442 ./infix2pharmml_statement.pm
	],
	[#Rule expr_20
		 'expr', 1,
sub {
#line 84 "infix2pharmml_statement.eyp"
infix2pharmml::e("ct:Real",$_[1])}
#line 4449 ./infix2pharmml_statement.pm
	],
	[#Rule expr_21
		 'expr', 1,
sub {
#line 85 "infix2pharmml_statement.eyp"
infix2pharmml::const($_[1])}
#line 4456 ./infix2pharmml_statement.pm
	],
	[#Rule expr_22
		 'expr', 2,
sub {
#line 86 "infix2pharmml_statement.eyp"
infix2pharmml::u("factorial",$_[1])}
#line 4463 ./infix2pharmml_statement.pm
	],
	[#Rule expr_23
		 'expr', 2,
sub {
#line 87 "infix2pharmml_statement.eyp"
$_[2]}
#line 4470 ./infix2pharmml_statement.pm
	],
	[#Rule expr_24
		 'expr', 2,
sub {
#line 88 "infix2pharmml_statement.eyp"
infix2pharmml::u("minus",$_[2])}
#line 4477 ./infix2pharmml_statement.pm
	],
	[#Rule expr_25
		 'expr', 3,
sub {
#line 89 "infix2pharmml_statement.eyp"
$_[2]}
#line 4484 ./infix2pharmml_statement.pm
	],
	[#Rule expr_26
		 'expr', 4,
sub {
#line 90 "infix2pharmml_statement.eyp"
infix2pharmml::u($_[1],$_[3])}
#line 4491 ./infix2pharmml_statement.pm
	],
	[#Rule expr_27
		 'expr', 6,
sub {
#line 91 "infix2pharmml_statement.eyp"
infix2pharmml::b($_[1],$_[3],$_[5])}
#line 4498 ./infix2pharmml_statement.pm
	],
	[#Rule expr_28
		 'expr', 6,
sub {
#line 92 "infix2pharmml_statement.eyp"
my $v = $_[3]; my $d = $_[5]; infix2pharmml::delay($v,$d)}
#line 4505 ./infix2pharmml_statement.pm
	],
	[#Rule expr_29
		 'expr', 4,
sub {
#line 93 "infix2pharmml_statement.eyp"
infix2pharmml::fc($_[1],$_[3])}
#line 4512 ./infix2pharmml_statement.pm
	],
	[#Rule expr_30
		 'expr', 1,
sub {
#line 94 "infix2pharmml_statement.eyp"
infix2pharmml::symbref($_[1])}
#line 4519 ./infix2pharmml_statement.pm
	],
	[#Rule constant_31
		 'constant', 1,
sub {
#line 102 "infix2pharmml_statement.eyp"
"notanumber"}
#line 4526 ./infix2pharmml_statement.pm
	],
	[#Rule constant_32
		 'constant', 1,
sub {
#line 103 "infix2pharmml_statement.eyp"
"pi"}
#line 4533 ./infix2pharmml_statement.pm
	],
	[#Rule constant_33
		 'constant', 1,
sub {
#line 104 "infix2pharmml_statement.eyp"
"exponentiale"}
#line 4540 ./infix2pharmml_statement.pm
	],
	[#Rule constant_34
		 'constant', 1,
sub {
#line 105 "infix2pharmml_statement.eyp"
"infinity"}
#line 4547 ./infix2pharmml_statement.pm
	],
	[#Rule argpairlist_35
		 'argpairlist', 3,
sub {
#line 109 "infix2pharmml_statement.eyp"
 $_[1].$_[3] }
#line 4554 ./infix2pharmml_statement.pm
	],
	[#Rule argpairlist_36
		 'argpairlist', 3,
sub {
#line 110 "infix2pharmml_statement.eyp"
infix2pharmml::fa($_[1],$_[3]) }
#line 4561 ./infix2pharmml_statement.pm
	],
	[#Rule varlist_37
		 'varlist', 3,
sub {
#line 114 "infix2pharmml_statement.eyp"
$_[1].$_[3]}
#line 4568 ./infix2pharmml_statement.pm
	],
	[#Rule varlist_38
		 'varlist', 1,
sub {
#line 115 "infix2pharmml_statement.eyp"
infix2pharmml::funcarg($_[1])}
#line 4575 ./infix2pharmml_statement.pm
	]
],
#line 4578 ./infix2pharmml_statement.pm
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
         'statement_1', 
         'statement_2', 
         'statement_3', 
         'statement_4', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'common_11', 
         'common_12', 
         'common_13', 
         'equation_14', 
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
         'expr_28', 
         'expr_29', 
         'expr_30', 
         'constant_31', 
         'constant_32', 
         'constant_33', 
         'constant_34', 
         'argpairlist_35', 
         'argpairlist_36', 
         'varlist_37', 
         'varlist_38', );
  $self;
}

#line 132 "infix2pharmml_statement.eyp"



=for None

=cut


#line 4643 ./infix2pharmml_statement.pm



1;
