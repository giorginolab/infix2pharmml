use Parse::RecDescent;
use strict;
use Data::Dumper;

open FILE, "grammar.g" or die "Couldn't open file: $!"; 
my $grammar = join("", <FILE>); 
close FILE;

$::RD_ERRORS++;
    $::RD_WARN++;
    $::RD_HINT++;

my $parser = Parse::RecDescent->new($grammar) or die "Bad grammar";

my $out=$parser->parse($ARGV[0]);

defined $out or die "Parse error";

print Dumper($out);


