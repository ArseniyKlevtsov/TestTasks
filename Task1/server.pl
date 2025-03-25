use strict;
use warnings;
use SOAP::Transport::HTTP;

# Сlass with matrix methods
package MatrixServer;

sub new { bless {}, shift }

# Matrix transposition
sub transpose {
    my ($self, $matrix) = @_;
    my @transposed;
    for my $i (0 .. $#{$matrix->[0]}) {
        push @transposed, [ map { $_->[$i] } @$matrix ];
    }
    print "Matrix transposition is performed\n";
    return \@transposed;
}

# Matrix exponentiation
sub power {
    my ($self, $matrix, $exponent) = @_;
    my @result;
    for my $row (@$matrix) {
        push @result, [ map { $_ ** $exponent } @$row ];
    }
    print "Exponentiation of the matrix is performed $exponent\n";
    return \@result;
}

package main;

my $daemon = SOAP::Transport::HTTP::Daemon
    ->new(
        LocalPort => 8080,
        ReuseAddr => 1,
    )
    ->dispatch_to('MatrixServer');

print "server started on URL: ", $daemon->url, "\n";
print "Waiting connections...\n";


$daemon->handle;