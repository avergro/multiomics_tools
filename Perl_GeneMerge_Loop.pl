#!/usr/bin/perl

use strict;
use warnings;

# Set the name of the input file containing the list of files to process
my $input_file = "community_files_names_TEST.txt";

# Set the name of the GeneMerge1.4.pl script
my $gene_merge_script = "GeneMerge1.4.pl";

# Open the input file
open my $input_fh, "<", $input_file or die "Could not open input file $input_file: $!";

# Loop over the lines of the input file
while (my $input_file_name = <$input_fh>) {
    # Remove any leading or trailing whitespace from the input file name
    chomp $input_file_name;
    $input_file_name =~ s/^\s+//;
    $input_file_name =~ s/\s+$//;

    # Set the name of the output file
    my $output_file_name = $input_file_name . ".out";

    # Run the GeneMerge1.4.pl script with the input and output file names
    my $cmd = "perl $gene_merge_script ATH_GO_from_TAIR_2021-01-01_GeneMerge_format_OK_without_repeated_GOs_OK GO.XX.use Araport11_20190402_AGIs_38204.txt $input_file_name $output_file_name";
    system($cmd) == 0 or die "Command failed: $cmd: $!";
}

# Close the input file
close $input_fh;