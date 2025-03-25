use strict;
use warnings;
use SOAP::Lite;

my $soap = SOAP::Lite
    ->uri('StringServer')
    ->proxy('http://localhost:8080');

print "Enter your string: ";
my $str = <STDIN>;
chomp $str;

print "Choose operation:\n";
print "1. Count punctuation marks\n";
print "2. Count total characters\n";
print "3. Check substring presence\n> ";

my $choice = <STDIN>;
chomp $choice;

if ($choice == 1) {
    my $result = $soap->count_punctuation($str)->result;
    print "Punctuation marks: $result\n";
}
elsif ($choice == 2) {
    my $result = $soap->count_chars($str)->result;
    print "Total characters: $result\n";
}
elsif ($choice == 3) {
    print "Enter substring to search: ";
    my $substr = <STDIN>;
    chomp $substr;
    my $result = $soap->contains_substring($str, $substr)->result;
    print $result ? "Substring found!\n" : "Substring not found.\n";
}
else {
    die "Error: Invalid operation choice!";
}