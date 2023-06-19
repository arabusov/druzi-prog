#!/usr/bin/perl
use CGI::AuthRegister;

&import_dir_and_config;
$CGI::AuthRegister::AllowSignup = 1;
&require_https;
&require_login;

print "<html><body>Logged as $UserEmail\n";
print "<p><a href=\"$ENV{SCRIPT_NAME}?logout\">Logout</a>\n";
