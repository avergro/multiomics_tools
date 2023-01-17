use strict;
use warnings;

my %seen;

# Open the input file
open my $fh, "<", "input.csv" or die $!;

# Open the output file
open my $out, ">", "output.csv" or die $!;

# Read the input file line by line
while (my $line = <$fh>) {
    chomp $line;
    my ($id) = split /,/, $line;
    if (exists $seen{$id}) {
        print $out "$id"."_".$seen{$id}++,",$line\n";
    } else {
        $seen{$id} = "A";
        print $out "$id,$line\n";
    }
}

# Close the files
close $fh;
close $out;
