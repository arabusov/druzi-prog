#!/usr/bin/perl -w

use CGI;
use File::Temp qw/ tempfile tempdir /;
use File::Path qw( make_path );
use File::HomeDir;

my $query = new CGI;
my $upload_filehandle = $query->upload("program");

$home     = File::HomeDir->my_home;
my $homeworks=$home . '/druzi-homeworks';
make_path $homeworks;

my ($fh, $filename) = tempfile(DIR => $homeworks, SUFFIX => '.pas');

open (LOCAL, ">", $filename);

while ( <$upload_filehandle> )
{
    print LOCAL;
}

close LOCAL;

print $query->header ( );
print <<END_HTML;

<html>
<head>
<title>Uploaded.</title>
</head>

<body>
File stored under the 
END_HTML
print $filename;
print <<END_HTML;
 name.
<br>
<pre>
END_HTML

open (my $uh, $filename);
while ( <$uh> ) {
    print ;
}

print <<END_HTML;
</pre>
</body>
</html>

END_HTML

