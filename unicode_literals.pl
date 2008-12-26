#!/usr/local/bin/perl
# $Id$
use strict;
use warnings;

use Encode;
use Getopt::Long;
use Pod::Usage;
GetOptions(\my %opt,
           "help",
       );
pod2usage(2) if $opt{help};
pod2usage(2) unless scalar @ARGV;

my $octets   = join q{}, @ARGV;
my $encoding = 'utf-8';

print unicode_literals($octets, $encoding);


sub unicode_literals {
    my ($octets, $encoding) = @_;
    my $decoded = decode($encoding, $octets);
    my $unicode_literals = encode('ascii', $decoded, Encode::FB_PERLQQ);
    return $unicode_literals;
}


1;

__END__

=head1 NAME

unicode_literals.pl - 

=head1 SYNOPSIS

  $ perl ./unicode_literals.pl 餃子の王将

  Options:
    help     - print this message

=head1 DESCRIPTION

=head1 SEE ALSO

  L<Encode>
  L<http://www.unicode.org/charts/>

=cut


