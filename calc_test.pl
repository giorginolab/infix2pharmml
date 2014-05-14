use calc;
use strict;

#eyapp calc

my $parser=calc->new();

$parser->input($ARGV[0]);
my $out=$parser->Run();

print $out;

1;
