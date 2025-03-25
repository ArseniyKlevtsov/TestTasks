use strict;
use warnings;
use SOAP::Transport::HTTP;

package StringHashServer;

sub new { bless {}, shift }

# Build frequency hash and check word
sub check_word {
    my ($self, $str, $word) = @_;
    
    # Create frequency hash
    my %hash;
    $hash{$_}++ for split(/\s+/, $str);
    print "Frequency hash created\n";

    # Check word existence
    if (exists $hash{$word}) {
        print "Word found\n";
        return "Word '$word' found. Count: $hash{$word}";
    } else {
        print "Word not found\n";
        return "Word '$word' not found";
    }
}

package main;

# Start SOAP server
my $daemon = SOAP::Transport::HTTP::Daemon
    ->new(LocalPort => 8080, ReuseAddr => 1)
    ->dispatch_to('StringHashServer');

print "Server started at URL: ", $daemon->url, "\n";
$daemon->handle;