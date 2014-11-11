#!/usr/bin/perl

use lib 'cgi-perl/lib/perl5';


use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use XML::Twig;

# use FindBin qw($Bin); 
# use Cwd;

use infix2pharmml; 

use strict;


my $string = param('math') || '<i>(No input)</i>';
my $standalone = param('standalone') eq "true";

my $Bin=$ENV{SCRIPT_FILENAME};
my $Rem=$ENV{HTTP_X_REMOTE_ADDR};
open LOG,">>$Bin.log" or die "Error opening log file $Bin.log: $!";
print LOG scalar localtime,"\t$Rem\t$string\n";
close LOG;

print header(-expires=>'now'),
        start_html('Infix notation to PharmML math'),
        img({alt=>"Logo CNR",style=>"float:right",src=>"/CNR_logo_100.png"}),
	h1('Infix notation to PharmML math online converter'),
	i('Toni Giorgino at isib.cnr.it');
	
# print h2('Env:');  foreach my $key (sort(keys(%ENV))) {     print "$key = $ENV{$key}<br>\n";     }

print h2('You entered:'),pre($string);

print h2('Stand-alone mode:'), $standalone?'Yes':'No';


my $xml=eval {
    $infix2pharmml::fullmodel=$standalone;
    infix2pharmml::xmlify($string);
};

if ($@) {
    my $err=$@;
    $err =~ s/\n/<br\/>/g;
    print h2('Parse error:'),$err;
} else {
    my $twig=XML::Twig->new( pretty_print => 'indented',
			     output_filter => 'html' ); 
    $twig->safe_parse($xml);
    
    my $xml_indented=$twig->sprint;
    print h2("PharmML:"),pre($xml_indented);
}

print end_html;

exit;


