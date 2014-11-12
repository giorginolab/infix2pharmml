# infix2pharmml model generator
# Copyright (C) 2014 Toni Giorgino ISIB-CNR

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

if( $infix2pharmml::fullmodel ) {
    print "\n\nSimulx:\n";
    print infix2pharmml::getSimulxCode();
}


	

