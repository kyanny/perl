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
#pod2usage(2) if -t STDIN;

$| = 1;

my $format = q[%host %rfc %authuser %date %request %status %bytes %referer %useragent %provider %name];
my $capture = [qw(host rfc authuser date request status bytes referer useragent provider name)];

$Regexp::Log::Common::REGEXP{'%provider'} = '(?#=provider)(.*?)(?#!provider)';
$Regexp::Log::Common::REGEXP{'%name'} = '(?#=name)(.*?)(?#!name)';

my $foo = Regexp::Log::Common->new(
    format  => $format,
    capture => $capture,
);
my $re = $foo->regexp;
my @fields = $foo->capture;

print $re;

exit;

while (<>) {
    my %data;
    @data{@fields} = /$re/;

    # do something
    print Dumper \%data;
}


1;

__END__

=head1 NAME

regexp_log_common2.pl - 

=head1 SYNOPSIS

  $ perl ./regexp_log_common2.pl < access_log

  Options:
    help - print this message

=head1 DESCRIPTION

Regexp::Log::Common の使い方のサンプルです。
Regexp::Log::Common で定義済みの正規表現ではうまくマッチできない場合、 %Regexp::Log::Common::REGEXP で正規表現を定義することで正規表現の拡張が可能です。

  $Regexp::Log::Common::REGEXP{'%elapsed'} = '(?#=elapsed)(\d+)(?#!elapsed)';

(?#...) は Perl5 の拡張正規表現です。コメントなのでマッチング時には無視されますが、 Regexp::Log の仕様で (?#=...) と (?#!...) で囲まれた部分を ... という文字列でキャプチャできるようになっています。

以下のフォーマット文字列で記録されたログファイルをパースできます。

  LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\" %T" combined

=cut

