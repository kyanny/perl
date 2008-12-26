#!/usr/bin/perl
# $Id$
use strict;
use warnings;
use CGI;

my $cgi = CGI->new;

my $ret = `cd /home/kyanny/www/XXXX && export HOME=/home/kyanny && /home/kyanny/local/bin/git pull`;
print $cgi->header(-type => 'text/plain');
print $ret;


1;
