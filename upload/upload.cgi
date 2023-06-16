#!/usr/bin/perl -w

use CGI;
use File::Temp qw/ tempfile tempdir /;

$upload_dir = "upload"

($fh, $filename) = tempfile( $template, DIR => $upload_dir, SUFFIX => '.dat');

$query = new CGI;

$upload_filehandle = $query->upload("program");

open my $fh, ">$upload_dir/$filename";

while ( <$upload_filehandle> )
{
    print my $fh;
}

close my $fh;

print $query->header ( );
print <<END_HTML;

<HTML>
<HEAD>
<TITLE>Thanks!</TITLE>
</HEAD>

<BODY>
Thanks.
</BODY>
</HTML>

END_HTML
