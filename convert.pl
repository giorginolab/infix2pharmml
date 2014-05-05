use lib 'cgi-perl/lib/perl5';

use XML::Twig;
use infix2pharmml; 

use strict;

my $string=shift @ARGV;

if (!$string) {
    print "Enter the expression to convert:\n";
    $string=<>;
    chomp $string; 
} 


print "About to parse:              $string\n";
my $tree = Math::Symbolic->parse_from_string($string);
defined $tree or die "Parse failure";

print "Parsed [call() is broken]:   ".$tree->to_string."\n" ;#unless $infix2pharmml::using_call;

print "XML:\n\n";
my $xml= infix2pharmml::xmlify($tree);

my $twig=XML::Twig->new( pretty_print => 'indented'); 
$twig->parse($xml);
$twig->print;



	

