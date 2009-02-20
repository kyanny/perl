#!/usr/local/bin/perl
use strict;
use warnings;
use DateTime::Format::HTTP;
use Getopt::Long;
use Pod::Usage;

my $help;
my $reverse;
GetOptions(
    'help' => \$help,
    'reverse' => \$reverse,
);
pod2usage(2) if $help;
#pod2usage(2) if -t STDIN;

my $re = qr{^(\S+) (\S+) (\S+) \[(.*?)\] .*$};

print sort by_clf_httpdate <STDIN>;

sub by_clf_httpdate {
    my @a = $a =~ $re;
    my @b = $b =~ $re;
    my $dt_a = DateTime::Format::HTTP->parse_datetime($a[3]);
    my $dt_b = DateTime::Format::HTTP->parse_datetime($b[3]);
    $reverse
        ? $dt_b->epoch <=> $dt_a->epoch
        : $dt_a->epoch <=> $dt_b->epoch;
}


1;

__END__

=head1 NAME

sorter_datetime_format_http.pl - 

=head1 SYNOPSIS

  $ cat access_log | ./sorter_datetime_format_http.pl [--reverse]

=head1 DESCRIPTION



=cut

