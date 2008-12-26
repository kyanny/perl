#!/usr/local/bin/perl
# $Id$
use strict;
use warnings;

use Regexp::Log::Common;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
GetOptions(\my %opt,
           "help",
       );
pod2usage(2) if $opt{help};
pod2usage(2) if -t STDIN;

$| = 1;

my $foo = Regexp::Log::Common->new(
    format  => ':extended',
    capture => [qw(host rfc authuser date request status bytes referer useragent)],
);
my $re = $foo->regexp;
my @fields = $foo->capture;

while (<>) {
    my %data;
    @data{@fields} = /$re/;

    # do something
    print Dumper \%data;
}


1;

__END__

=head1 NAME

regexp_log_common.pl - 

=head1 SYNOPSIS

  $ perl ./regexp_log_common.pl < access_log

  Options:
    help - print this message

=head1 DESCRIPTION

Regexp::Log::Common の使い方のサンプルです。
以下のフォーマット文字列で記録されたログファイルをパースできます。

  NCSA extended/combined ログ書式
    "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\""

  LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"" combined

=cut

