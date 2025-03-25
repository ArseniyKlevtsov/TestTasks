use strict;
use warnings;
use SOAP::Lite;

my $soap = SOAP::Lite
    ->uri('StringHashServer')
    ->proxy('http://localhost:8080');

print "Enter string: ";
my $str = <STDIN>;
chomp $str;

print "Enter word to search: ";
my $word = <STDIN>;
chomp $word;

my $result = $soap->check_word($str, $word)->result;
print "$result\n";