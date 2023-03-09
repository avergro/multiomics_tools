#!/usr/bin/perl

#Alexander Vergara

#This script parse enrichments files of GeneMerge 
#This take all the output of GeneMerge located in a directory and parse them based on a 
#input parameter (adjusted Pvale threshold) and create files called "_Parded"
#ommiting the html files


use strict;
use warnings;

# Set the threshold value
my $threshold = 0.05;

# Get a list of all files in the current directory
opendir(my $dh, '.') or die "Can't open directory: $!";
my @files = grep { !/^\./ && -f $_ && $_ !~ /\.html$/ } readdir($dh);
closedir $dh;

# Loop through each file in the list
foreach my $file (@files) {

  # Skip files that already have "_Parsed" in their name
  next if $file =~ /_Parsed/;

  # Set the input and output file names
  my $input_file = $file;
  my $output_file = $file;
  $output_file =~ s/\.[^.]+$//;
  $output_file .= '_Parsed';

  # Run the PARSER_Enrichments_Lists2.pl script with the appropriate arguments
  system("perl ../PARSER_Enrichments_Lists2.pl $threshold $input_file > $output_file");
}
