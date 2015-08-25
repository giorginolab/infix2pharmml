# infix2pharmml model generator
# Copyright (C) 2015 Toni Giorgino ISIB-CNR

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



# Please note that this is a quick hack. 

# This is not how XML or PharmML should be generated. Generating
# strings from the grammar skips the AST. This means that the code
# generator can not reason on the objects after they are
# generated. The problem is clear e.g. in par(), which cannot store
# the "float" value, because it is decorated by the XML stuff.

# The code is totally non-reentrant. It should be made into a proper
# class.




package infix2pharmml;

use strict;
use Carp;
use infix2pharmml_statement;
use infix2pharmml_model;
use warnings;
use File::Basename;

our $fullmodel=0;		# Set this to 1 to get a full model
our $noinput=0;			# Do not replace input, for testing


my %localSymbols=("t"=>2);
my %allSymbols=("t"=>2);
my %parametrizableSymbols=();

my @derivativeVariableList=();
my @variableList=();
my @functionList=();
my @macroText=();


# Start from scratch
sub init {
    %localSymbols=("t"=>2);
    %allSymbols=("t"=>2);
    %parametrizableSymbols=();
    @derivativeVariableList=();
    @variableList=();
    @functionList=();
    @macroText=();
}


# Hash to EOL comment. Does nothing actually.
sub comment {
    my $c=shift;
    my $out="<!-- USER $c -->";
    return $out;
}


# Top-level declarations
sub funcdef {
    my ($id,$al,$eq)=@_;
    my $desc="Function: $id";

    croak "Function definitions not allowed in stand-alone mode yet" if $fullmodel;

    my $out= "<ct:FunctionDefinition symbId=\"$id\" symbolType=\"real\">".
	e("ct:Description",$desc).
	$al.
	e("ct:Definition",assign($eq)).
	"</ct:FunctionDefinition>";
    push @functionList,$out;
    return $out;
}

# Can't be in StructuralModel.
sub varass {
    my ($id,$y)=@_;
    croak "Variable assignments not allowed in stand-alone mode yet" if $fullmodel;
    $localSymbols{$id}=1;
    return e("ct:VariableAssignment",
	     symbref($id),
	     assign($y));
}

# P. 42
sub vardef {
    my ($id,$y,$c)=@_;
    my $comm="$id (Variable)";
    my $desc=(defined $c->[0])?"<ct:Description>$c->[0]</ct:Description>" : "" ;
    my $out=
	"<!-- $comm -->".
	"<ct:Variable symbId=\"$id\" symbolType=\"real\">".
	$desc.
	assign($y).
	"</ct:Variable>";
    push @variableList,$out;
    $localSymbols{$id}=1;
    return $out;
}


sub diff {
    my ($id,$t,$y,$c)=@_;
    my $desc=(defined $c->[0])?"<ct:Description>$c->[0]</ct:Description>" : "" ;
    my $out=
	"<!-- $id' (ODE) -->".
	"<ct:DerivativeVariable symbId=\"$id\" symbolType=\"real\">".
	$desc.
	assign($y).
	e("ct:IndependentVariable",symbref($t)).
	e("ct:InitialCondition",
	  e("ct:InitialValue",
#	assign(eqn(symbref("${id}_init"))).
	    assign(symbref("${id}_init")) 
	    )
	).
	"</ct:DerivativeVariable>";
    push @derivativeVariableList,$out;
    $localSymbols{$id}=1;
    return $out;
}
    

sub par {
    my ($id,$y)=@_;
    $allSymbols{$id}=$y;
}

sub par_n {
    my ($id,$y)=@_;
    $allSymbols{$id}=e("ct:Real",$y);
    $parametrizableSymbols{$id}=$y;
}



sub assign {
    return e("ct:Assign",shift);
}


# Delay
sub delay {
    my ($v,$d)=@_;
    return e("ct:Delay",symbref($v),
	      e("ct:DelayVariable",symbref($d)));
}

# Macro call (name, args). Symbref should not be pushed in symbol table.
sub macro {
    my ($id,$args)=@_;
    my $o="<$id>$args</$id>";
    push @macroText,$o;
}

# Function arguments
sub macroarg {
    if (scalar @_==2) {
	my ($id,$ref)=@_;
	return "<Value argument=\"$id\">$ref</Value>";
    } else {
	my $ref=shift;
	return "<Value>$ref</Value>";
    }	
}


# Function call (name, args). Symbref should not be pushed in symbol table.
sub fc {
    my ($id,$args)=@_;
    return "<math:FunctionCall>".
    "<ct:SymbRef symbIdRef=\"$id\"/>".
    $args.
    "</math:FunctionCall>";
}

sub funcarg {
    my $id=shift;
    return "<ct:FunctionArgument symbId=\"$id\" symbolType=\"real\"/>"
}

# Function arguments
sub fa {
    my ($id,$ref)=@_;
    return "<math:FunctionArgument symbId=\"$id\">".
	assign($ref).
      "</math:FunctionArgument>";
}

# Symbol - will be substituted later. This is tricky because we need
# to figure out at the end whether each symbol was local or
# not. Local: appears in localSymbols.
sub symbref {
    my $id=shift;
    $allSymbols{$id} //= undef;	# set to undefined if not already set
    return "INFIX2PHARMML_SYMBREF:$id:"
}



# Constant
sub const {
    my $id=shift;
    return "<math:Constant op=\"$id\"/>";
}


# -------------------

# Generic attribute-less tag
sub e {
    my $tag=shift;
    my $c=join('',@_);
    return "<$tag>$c</$tag>\n";
}

# Uniop or binop (1st arg), operator name (2nd arg)
sub op {
    my $tag=shift;
    my $op=shift;
    my $c=join('',@_);
    return "<$tag op=\"$op\">$c</$tag>\n";
}

# Binop
sub b {
    return op("math:Binop",@_);
}

# Uniop
sub u {
    return op("math:Uniop",@_);
}


#######################

# Out of the list of all symbols encountered, return only those which
# were not defined by the user.
sub getParameterModel {
    my $out="<ParameterModel blkId=\"p\">";
    foreach my $s (keys %allSymbols) {
	if(! defined $localSymbols{$s}) {
	    my $y=$allSymbols{$s};

	    if(defined $y) {
		my $a=assign($y);
		$out.="<PopulationParameter symbId=\"$s\">$a</PopulationParameter>";
	    } else {
		$out.="<PopulationParameter symbId=\"$s\" />";
	    }
	}
    }
    $out.="</ParameterModel>";
}



# The main entry point.

sub xmlify {
    my $in=shift;
    my $parser;
    
    if(!$fullmodel) {
	$parser=infix2pharmml_statement->new() or die "Building grammar"; 
    } else {
	$parser=infix2pharmml_model->new() or die "Building grammar"; 
    }

    $parser->input($in) or die "At grammar input()";
    my $err;
    my $out;

    {
	 local $SIG{__WARN__} = sub { $err=$_[0]; };
	 $out=$parser->Run;
    }

    if (my $ne = $parser->YYNberr > 0) {
	croak "There were $ne errors during parsing: $err\n";
    } 


    if(!$fullmodel) {
	$out=~s|INFIX2PHARMML_SYMBREF:(.+?):|<ct:SymbRef symbIdRef="$1"/>|g;
	return $out;
    } else {
	my $here=dirname(__FILE__);
	open F,"< $here/emptyModel.xml" or die "Can't open template in $here: $!";
	my $tmpl=join("", <F>);
	close F;

	my $pm=getParameterModel();
	$tmpl =~ s/INFIX2PHARMML_PARAMETERMODEL/$pm/;

	my $dv=join "",@derivativeVariableList;
	$tmpl =~ s/INFIX2PHARMML_DERIVATIVEVARIABLE/$dv/;

	my $vl=join "",@variableList;
	$tmpl =~ s/INFIX2PHARMML_VARIABLE/$vl/;

	my $mac="";
	if(scalar @macroText) {
	    $mac="<PKmacros>@macroText</PKmacros>";
	} 
	$tmpl =~ s/INFIX2PHARMML_MACROS/$mac/;

	unless($noinput) {
	    my $dt=localtime;
	    $tmpl =~ s/INFIX2PHARMML_DATE/$dt/g;
	    $tmpl =~ s/INFIX2PHARMML_INPUT/$in/g;
	}

	while($tmpl =~ m|INFIX2PHARMML_SYMBREF:(.+?):|) {
	    my $m=quotemeta $&;
	    my $p=$1;
	    my $blk="";
	    if(! defined $localSymbols{$p}) {
		$blk='blkIdRef="p"';
	    } 
	    my $r=sprintf('<ct:SymbRef symbIdRef="%s" %s />',$p,$blk);
	    $tmpl =~ s/$m/$r/g;
	}

	return $tmpl;
    }
}



# p <- list( name  = c('k'), 
#            value = c(.1))


# A <- list(name=c('A'),time=seq(0,5,length=20))
# B <- list(name=c('B'),time=seq(0,5,length=20))

# out <- list(A,B)

# res <- simulx( model     = 'model/test.xml',
#                parameter = p,
#                output    = out
#          );


# Only valid after the model has been xmlified
sub getSimulxCode {
    my @par;
    my @parq;
    my @parv;
    my $np=0;
    foreach my $s (keys %allSymbols) {
	if(! defined $localSymbols{$s}) {
	    push @par,$s;
	    push @parq,qq("$s"); # quoted parameter name
	    push @parv,$parametrizableSymbols{$s}//"NA";
	    $np++;
	}
    }

    my $out= "p <- list( name  = c(" . join(",",@parq). "),\n";
    $out.=   "           value = c(" . join(",",@parv) .")) # FIXME\n";

    my %localVars=%localSymbols;
    delete $localVars{"t"};

    $out.="\n";
    $out.="out.times<-seq(0,5,length=51) # FIXME\n";

    my @tmp=();
    foreach my $s (keys %localVars) {
	push @tmp,sprintf(qq(  list(name=c('%s'),time=out.times)),$s);
    }

    $out.="\n";
    $out.="out <- list(\n".join(",\n",@tmp)."\n)\n";

    $out.=<<EOF;

res <- simulx( model     = 'model/test.xml',
               parameter = p,
               output    = out  );
EOF

}


1;
