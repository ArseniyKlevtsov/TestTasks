use strict;
use warnings;
use SOAP::Lite;

# --- Configuring the SOAP client ---
my $soap = SOAP::Lite
    ->uri('MatrixServer')                  
    ->proxy('http://localhost:8080');      

# --- random matrix generation ---
print "Enter the size of the matrix (rows and columns): ";
my ($rows, $cols) = split /\s+/, <STDIN>;
chomp($rows, $cols);

my $matrix = generate_matrix($rows, $cols);
print "\nMatrix generated $rows x $cols:\n";
print_matrix($matrix);

# --- Operation selection ---
print "\nSelect operation:\n1. Transpose \n2. Exponentiation\n> ";
my $choice = <STDIN>;
chomp $choice;

if ($choice == 1) {
    # Transpose
    my $result = $soap->transpose($matrix)->result;
    print "\nThe result of the transposition:\n";
    print_matrix($result);
}
elsif ($choice == 2) {
    # Exponentiation
    print "Enter the degree: ";
    my $exponent = <STDIN>;
    chomp $exponent;
    my $result = $soap->power($matrix, $exponent)->result;
    print "\nThe result of exponentiation $exponent:\n";
    print_matrix($result);
}
else {
    die "Error: incorrect choice of operation!";
}

# Matrix generator
sub generate_matrix {
    my ($rows, $cols) = @_;
    my @matrix;
    for my $i (1..$rows) {
        my @row = map { int(rand(10)) } 1..$cols; 
        push @matrix, \@row;
    }
    return \@matrix;
}

# Matrix print
sub print_matrix {
    my ($matrix) = @_;
    for my $row (@$matrix) {
        print join(" ", @$row), "\n";
    }
}