use strict;
use warnings;
use SOAP::Lite;

my $soap = SOAP::Lite
    ->uri('HashServer')
    ->proxy('http://localhost:8080');

print "Enter key to search: ";
my $key = <STDIN>;
chomp $key;

my $result = $soap->check_key($key)->result;
print "$result\n";