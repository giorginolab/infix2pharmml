#!/usr/bin/perl

use lib 'cgi-perl/lib/perl5';


use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use XML::Twig;
use Math::Symbolic;

use infix2pharmml; 

use strict;


my $string = param('math') || '<i>(No input)</i>';

<<<<<<< HEAD
print header,start_html('Infix notation to PharmML math'),
	h1('Infix notation to PharmML math online converter'),
=======
print header,start_html('Infix notation to PharmML math XML'),
	h1('Infix notation to PharmML math XML online converter'),
>>>>>>> 58f4d959ebe39f34478e44949e4d215fe3e087ae
	i('Toni Giorgino at isib.cnr.it');

print h2('You entered:'),$string;

my $tree = Math::Symbolic->parse_from_string($string);

if (!defined $tree) {
	print h2("Parse failure, sorry."), end_html;
	exit;
}

<<<<<<< HEAD
print h2("Parsing result:"),$tree->to_string."\n" unless $infix2pharmml::using_call;
=======
print h2("Parsed [call() is broken]:   "),$tree->to_string."\n" unless $infix2pharmml::using_call;
>>>>>>> 58f4d959ebe39f34478e44949e4d215fe3e087ae

my $xml= infix2pharmml::xmlify($tree);

my $twig=XML::Twig->new( pretty_print => 'indented',
			  output_filter => 'html' ); 
$twig->safe_parse($xml);

my $xml_indented=$twig->sprint;
<<<<<<< HEAD
print h2("PharmML:"),pre($xml_indented);
=======
print h2("XML:"),pre($xml_indented);
>>>>>>> 58f4d959ebe39f34478e44949e4d215fe3e087ae

print end_html;

exit;


