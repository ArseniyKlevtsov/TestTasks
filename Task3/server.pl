use strict;
use warnings;
use SOAP::Transport::HTTP;

my %static_hash = (
    "apple"  => "fruit",
    "carrot" => "vegetable",
    "steak"  => "meat",
    "milk"   => "dairy"
);

package HashServer;

sub new { bless {}, shift }

sub check_key {
    my ($self, $key) = @_;
    
    if (exists $static_hash{$key}) {
        print "Key '$key' found\n";
        return "Key '$key' found. Value: $static_hash{$key}";
    } else {
        print "Key '$key' not found\n";
        return "Key '$key' does not exist";
    }
}

package main;

my $daemon = SOAP::Transport::HTTP::Daemon
    ->new(LocalPort => 8080, ReuseAddr => 1)
    ->dispatch_to('HashServer');

print "Server started at URL: ", $daemon->url, "\n";
$daemon->handle;