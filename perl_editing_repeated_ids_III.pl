use strict;
use warnings;

# Get the input file name
my $input_file = shift;

my %seen;

# Open the input file
open my $fh, "<", $input_file or die $!;

# Read the input file line by line
while (my $line = <$fh>) {
    chomp $line;
    my @fields = split /,/, $line;
    if (exists $seen{$fields[0]}) {
        $fields[0] = "$fields[0]"."_".$seen{$fields[0]}++;
    } else {
        $seen{$fields[0]} = "A";
    }
    my $new_line = join "\t", @fields;
    print "$new_line\n";
}

# Close the file
close $fh;
