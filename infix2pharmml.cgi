#!/usr/bin/perl

use lib 'cgi-perl/lib/perl5';


use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use XML::Twig;
use Math::Symbolic;
# use FindBin qw($Bin); 
# use Cwd;

use infix2pharmml; 

use strict;


my $string = param('math') || '<i>(No input)</i>';

my $Bin=$ENV{SCRIPT_FILENAME};
my $Rem=$ENV{HTTP_X_REMOTE_ADDR};
open LOG,">>$Bin.log" or die "Error opening log file $Bin.log: $!";
print LOG scalar localtime,"\t$Rem\t$string\n";
close LOG;

print header(-expires=>'now'),
        start_html('Infix notation to PharmML math'),
	h1('Infix notation to PharmML math online converter'),
	i('Toni Giorgino at isib.cnr.it');
	
# print h2('Env:');  foreach my $key (sort(keys(%ENV))) {     print "$key = $ENV{$key}<br>\n";     }

print h2('You entered:'),$string;

my $tree = Math::Symbolic->parse_from_string($string);

if (!defined $tree) {
	print h2("Parse failure, sorry."), end_html;
	exit;
}

print h2("Parsing result:"),$tree->to_string."\n" unless $infix2pharmml::using_call;

my $xml= infix2pharmml::xmlify($tree);

my $twig=XML::Twig->new( pretty_print => 'indented',
			 output_filter => 'html' ); 
$twig->safe_parse($xml);

my $xml_indented=$twig->sprint;
print h2("PharmML:"),pre($xml_indented);

print end_html;

exit;


