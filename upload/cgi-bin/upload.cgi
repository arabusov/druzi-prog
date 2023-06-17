#!/usr/bin/perl -w

use CGI;
use File::Temp qw/ tempfile tempdir /;
use File::Path qw( make_path );
use File::HomeDir;

my $query = new CGI;
my $upload_filehandle = $query->upload("program");
my $name = $query->param("name");

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

print $query->header ();
print <<END_HTML;

<html>
<head>
<title>Uploaded.</title>
</head>

<body>
Your name: 
END_HTML
print $name;
print <<END_HTML;
<br>
Your program:
<pre>
END_HTML

open (my $uh, $filename);
while ( <$uh> ) {
    print ;
}

close $uh;

my $exename = $filename;
$exename =~ s/\.pas//;

print '<br>Compiler output:<br>';
system "fpc -vrewn $filename";
if (-e $exename)
{
    print '<br>Program output:<br>';
    system "echo | $exename";
    system "rm $exename";
    system "rm $exename.o";
}
else
{
    print '<br>Compile error.<br>';
}

if (-e $filename)
{
    system "rm $filename";
}

print <<END_HTML;
</pre>
</body>
</html>

END_HTML

