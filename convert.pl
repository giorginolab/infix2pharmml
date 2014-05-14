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

print "XML:\n\n";
my $xml= infix2pharmml::xmlify($string);
defined $xml or die "Parse failure";

print "Raw: $xml\n\n";


my $twig=XML::Twig->new( pretty_print => 'indented'); 
$twig->parse($xml);
$twig->print;
print "\n\n";



	

