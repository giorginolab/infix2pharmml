#!/usr/bin/perl

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
