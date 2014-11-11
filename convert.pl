use lib 'cgi-perl/lib/perl5';

use XML::Twig;
use infix2pharmml; 
use strict;



if($ARGV[0] eq "-s") {
    shift @ARGV;
    $infix2pharmml::fullmodel=1;
}


my $string=shift @ARGV;

if (!$string) {
    print "Enter the expression to convert:\n";
    $string=<>;
    chomp $string; 
} 

print "About to parse:              $string\n";

my $xml= infix2pharmml::xmlify($string);
defined $xml or die "Parse failure";
print "\n\nRaw:\n$xml\n\n";

print "\n\nXML:\n";


my $twig=XML::Twig->new( pretty_print => 'indented'); 
$twig->parse($xml);
$twig->print;
print "\n\n";



	

