#!/usr/bin/perl

use lib 'cgi-perl/lib/perl5';


use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use XML::Twig;

# use FindBin qw($Bin); 
# use Cwd;

use infix2pharmml; 

use strict;

my $analytics=<<'END';
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-3201754-5', 'auto');
  ga('send', 'pageview');
END

my $string = param('math') || '<i>(No input)</i>';
my $standalone = param('standalone') eq "true";

my $Bin=$ENV{SCRIPT_FILENAME};
my $Rem=$ENV{HTTP_X_REMOTE_ADDR};
open LOG,">>$Bin.log" or die "Error opening log file $Bin.log: $!";
print LOG scalar localtime,"\t$Rem\t$string\n";
close LOG;

print header(-expires=>'now'),
        start_html(-title=>'Infix notation to PharmML math',
		   -style=>{-src=>'/prism/prism.css',
			    -code=>'body {margin:2em}'},
		   -script=> [ {-language => 'javascript',-src => "/prism/prism.js"},
			       {-code => $analytics} ],
	    ),
        img({alt=>"Logo CNR",style=>"float:right",src=>"/CNR_logo_100.png"}),
	h1('Infix notation to PharmML math online converter'),
	i('Toni Giorgino at isib.cnr.it');
	
# print h2('Env:');  foreach my $key (sort(keys(%ENV))) {     print "$key = $ENV{$key}<br>\n";     }

print h2('Your input'),pre(code({-class=>"language-javascript"},$string));

print h2('Stand-alone mode'), $standalone?'Enabled':'Disabled';


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
    print h2("Generated PharmML"),pre({-class=>"line-numbers"},code({-class=>"language-markup"},$xml_indented));
}

print end_html;

exit;


