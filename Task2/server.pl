use strict;
use warnings;
use SOAP::Transport::HTTP;

# Class with string operations
package StringServer;

sub new { bless {}, shift }

# 1. Count punctuation marks
sub count_punctuation {
    my ($self, $str) = @_;
    my $count = () = $str =~ /[.,!?;:]/g;
    print "Punctuation count operation executed\n";
    return $count;
}

# 2. Count total characters
sub count_chars {
    my ($self, $str) = @_;
    print "Character count operation executed\n";
    return length($str);
}

# 3. Check substring presence
sub contains_substring {
    my ($self, $str, $substr) = @_;
    print "Substring check operation executed\n";
    return index($str, $substr) != -1 ? 1 : 0;
}

package main;

# Start SOAP server
my $daemon = SOAP::Transport::HTTP::Daemon
    ->new(
        LocalPort => 8080,
        ReuseAddr => 1,
    )
    ->dispatch_to('StringServer');

print "Server started on URL: ", $daemon->url, "\n";
print "Waiting for connections...\n";

$daemon->handle;