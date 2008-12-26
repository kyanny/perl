# $Id$
use strict;
use warnings;

use Test::Base tests => 1;

filters {
    input    => [qw(chomp unicode_literals lc)],
    expected => [qw(chomp lc)],
};

run_is input => 'expected';


sub unicode_literals {
    my $input = shift;
    qx{perl ./unicode_literals.pl $input};
}
sub lc { lc(shift) }


1;

__END__
===
--- input
あいうえお
--- expected
\x{3042}\x{3044}\x{3046}\x{3048}\x{304A}
