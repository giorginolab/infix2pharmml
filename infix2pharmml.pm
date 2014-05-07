package infix2pharmml;

#use Devel::SimpleTrace;
#use Carp::Always;
use Data::Dumper;

use Math::Symbolic;
use Math::Symbolic::Parser;
use Math::Symbolic::ExportConstants qw/:all/;
use Math::SymbolicX::ParserExtensionFactory;

use strict;


# indeed, not used
sub factorial {
    my $r = 1;
    $r *= $_ for 1..shift;
    $r;
}


our $using_call=0;

# call ---------------------------------------- 
my $U=100;
my $parser = Math::Symbolic::Parser->new();


$Math::Symbolic::Operator::Op_Symbols{'call'} = $U;
$Math::Symbolic::Operator::Op_Types[$U] = {
    	    infix_string  => undef,
	    prefix_string => 'call',
};

Math::SymbolicX::ParserExtensionFactory->add_private_functions(
    $parser, 
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
	    type => $U,
	    operands => \@operands,
						    }); 
	return $result;
	     } );


{ my $Ut=$U;

  sub add_pharmml_function {
      my $fn=shift;
      my $arity=shift;

      $Ut++;
      print "add_pharmml_function: $fn is $Ut\n";
      $Math::Symbolic::Operator::Op_Symbols{$fn} = $Ut;
      $Math::Symbolic::Operator::Op_Types[$Ut] = {
#    	    infix_string  => undef,
	  arity => $arity,
	  prefix_string => $fn,
#	    application   => $fn.'(@_)',
      };
      { my $Utt=$Ut;
      Math::SymbolicX::ParserExtensionFactory->add_private_functions(
	  $parser, 
	  $fn => sub {
	      my $args=shift;
#	      print "temp_fun: args=$args, type=$Utt\n";
	      my $result =  Math::Symbolic::Operator->new({
		  type => $Utt,
		  operands => [$parser->parse($args)],
							  });
	  #    print Dumper($result);
	      return $result;
	  } );
      };
  }
};



add_pharmml_function("ln",1);
add_pharmml_function("factorial",1);
add_pharmml_function("gammaln",1);
#add_pharmml_function("min",2);



# This will extend all parser objects in your program:
# http://search.cpan.org/~smueller/Math-SymbolicX-ParserExtensionFactory-3.02/lib/Math/SymbolicX/ParserExtensionFactory.pm
#use Math::SymbolicX::ParserExtensionFactory (@PEF);


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


sub my_parse_from_string {
    return $parser->parse(shift);
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


