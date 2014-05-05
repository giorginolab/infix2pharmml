package infix2pharmml;

#use Devel::SimpleTrace;
#use Carp::Always;
#use Data::Dumper;

use Math::Symbolic;
use Math::Symbolic::Parser;
use Math::Symbolic::ExportConstants qw/:all/;

use strict;


# indeed, not used
sub factorial {
    my $r = 1;
    $r *= $_ for 1..shift;
    $r;
}


our $using_call=0;
use constant U_CALL => 100;
$Math::Symbolic::Operator::Op_Symbols{'call'} = U_CALL;
$Math::Symbolic::Operator::Op_Types[U_CALL] = {
    	    infix_string  => undef,
	    prefix_string => 'call',
};

# Contrieved way to add an operator
use constant U_LN => 101;
$Math::Symbolic::Operator::Op_Symbols{'ln'} = U_LN;
$Math::Symbolic::Operator::Op_Types[U_LN] = {
    	    infix_string  => undef,
	    arity => 1,
	    prefix_string => 'ln',
	    application   => 'log($_[0])',
};

use constant U_FACTORIAL => 102;
$Math::Symbolic::Operator::Op_Symbols{'factorial'} = U_FACTORIAL;
$Math::Symbolic::Operator::Op_Types[U_FACTORIAL] = {
    	    infix_string  => undef,
	    arity => 1,
	    prefix_string => 'factorial',
	    application   => 'factorial($_[0])',
};



# This will extend all parser objects in your program:
# http://search.cpan.org/~smueller/Math-SymbolicX-ParserExtensionFactory-3.02/lib/Math/SymbolicX/ParserExtensionFactory.pm
use Math::SymbolicX::ParserExtensionFactory (
    call => sub {
	my $argumentstring = shift;
	my @as=split(',',$argumentstring);
	my $opname=shift @as;
	my @arguments=();
	my @operands=();
	$using_call++;
	foreach my $arg (@as) {
	    my ($arg,$val)=split('=',$arg);
	    push @arguments,$arg;
	    push @operands,$val;
	}
	my $result =  Math::Symbolic::Operator->new({
	    custom_op => 1,
	    custom_name => $opname,
	    custom_arguments => \@arguments,
	    custom_string => "$opname(@as)",
	    type => U_CALL,
	    operands => \@operands,
						    }); 
	return $result;
    },

    # http://search.cpan.org/~smueller/Math-Symbolic-0.606/lib/Math/Symbolic/Operator.pm
    ln => sub {
	my $arg=shift;
	my $result =  Math::Symbolic::Operator->new({
	    type => U_LN,
	    operands => [$arg],
						    });
    },

    factorial => sub {
	my $arg=shift;
	my $result =  Math::Symbolic::Operator->new({
	    type => U_FACTORIAL,
	    operands => [$arg],
						    });
    },
  
    );




sub myarity {
	my $x=shift;
	my $p;
	if($x->arity == 1) {
		$p="Uniop";
	} elsif($x->arity == 2) {
		$p="Binop";
	}
	return $p;
}

# In Table 12.9-12.10
# Math::Symbolic -> PharmML conversion table  
sub renameop {
	my $x=shift;
	my %ot=( 
		add=>'plus',
		subtract=>'minus',
		multiply=>'times',
		division=>'divide',
		exponentiate=>'power',
		'log'=>'logx',
		negate=>'minus', # pharmml minus is both arity-2 and arity-1
	);
	if(defined $ot{$x}) {
		$x=$ot{$x};
	} 
	return $x;
}

# XMLify a custom operator
sub function_call_open {
    my $x=shift;
    my $r="";
    $r.="<math:FunctionCall>\n";
    $r.="<!-- Translating: $x->{custom_string} -->\n";
    $r.="<ct:SymbRef symbIdRef=\"".$x->{custom_name}."\"/>\n";
    my $o=0;
    foreach my $arg (@{$x->{custom_arguments}}) {
	$r.="    <math:FunctionArgument symbId=\"$arg\">\n";
	$r.=xmlify($x->{operands}->[$o++]);
	$r.="    </math:FunctionArgument>\n";
    }
    return $r;
}

sub function_call_close {
    return "</math:FunctionCall>\n";
}



sub xmlify {
    my $tree=shift;
    my $r="";

    my $pre = sub {
	my $x=shift;
#	print Dumper($x);
	if (defined $x->{custom_op}) {
	    $r.= function_call_open($x);
	    return undef;
	} elsif($x->term_type == T_OPERATOR) {
	    my $p=myarity($x);
	    my $o=$x->type;
	    my $os=$Math::Symbolic::Operator::Op_Types[$o]->{prefix_string};
	    $os=renameop($os);
	    $r.= "  <$p op=\"$os\">";
	} elsif($x->term_type == T_VARIABLE) {
		my $a=$x->name;
		$r.= "  <ct:SymbRef symbIdRef=\"$a\"/>";
	} elsif($x->term_type == T_CONSTANT) {
		my $a=$x->to_string;
		$r.= "  <ct:Real>$a</ct:Real>";
	} else {
		$r.= "Unknown: ".$x->to_string;
	}
	$r.= "\n";
	return();
    };

    my $post = sub {
	my $x=shift;
	if (defined $x->{custom_op}) {
	    $r.= function_call_close($x);
	} elsif($x->term_type == T_OPERATOR) {
		my $p=myarity($x);
		$r.= "  </$p>\n";
	} 
	return();
    };

    $r.="<math:Equation xmlns=\"http://www.pharmml.org/2013/03/Maths\">\n";
    $tree->descend(before=>$pre,after=>$post);
    $r.="</math:Equation>\n";
    return $r;
}


1;


