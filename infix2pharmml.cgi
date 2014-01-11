#!/usr/bin/perl

use CGI;
use XML::Twig;
use infix2pharmml; 

use strict;


use CGI qw(:standard);
$data = param('math') || '<i>(No input)</i>';

print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<title>Echoing user input</title>
<h1>Echoing user input</h1>
<p>You typed: $data</p>
END

exit;



my $string=shift @ARGV;

if (!$string) {
    print "Enter the expression to convert:\n";
    $string=<>;
    chomp $string; 
} 


print "About to parse:              $string\n";
my $tree = Math::Symbolic->parse_from_string($string);
defined $tree or die "Parse failure";

print "Parsed [call() is broken]:   ".$tree->to_string."\n" unless $infix2pharmml::using_call;

print "XML:\n\n";
my $xml= infix2pharmml::xmlify($tree);

my $twig=XML::Twig->new( pretty_print => 'indented'); 
$twig->parse($xml);
$twig->print;



	

