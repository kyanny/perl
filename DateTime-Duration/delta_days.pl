#!/usr/local/bin/perl
# $Id$
use strict;
use warnings;

use Perl6::Say;
use DateTime;
use DateTime::Duration;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
GetOptions(\my %opt,
           "help",
           'start=s',
           'end=s',
       );
pod2usage(2) if $opt{help};
pod2usage(2) unless ($opt{start} and $opt{end});

my $start = parse_datetime($opt{start});
my $end   = parse_datetime($opt{end});


my $duration = $end->delta_days($start);
say $duration->in_units('days');


sub parse_datetime {
    my $datetime = shift;
    chomp $datetime;
    if ($datetime =~ /^(\d{4})-(\d{2})-(\d{2})$/) {
        return DateTime->new(year => $1, month => $2, day => $3, time_zone => 'local');
    }
}


1;

__END__

=head1 NAME

delta_days.pl - calculate delta days

=head1 SYNOPSIS

  $ perl ./delta_days.pl --start=YYYY-MM-DD --end=YYYY-MM-DD

=head1 DESCRIPTION



=cut

