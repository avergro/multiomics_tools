#!/usr/bin/perl -w

#Febrero 10 2017
#Author: Alexander Vergara

#PARSER AND FILTER OF ENRICHMENTS coming from GeneMerge Output tables
#This script is able to parse a GeneMerge enrichment output and based on the Bonferroni ajust Pvalue
#filter the rows =< thershold.
#The output is including:
#GOID, Freq in Genome, Universe, Counts (number of genes in DEG list with the tag), DEG_size_list, 
#Percentage, Bonferroni, Description, Comparasion (DE file)


use strict;
unless( @ARGV == 2 ){
   die "\n\nla idea es tomar las columna del pvalue ajust del archivo temp y cortar segun un cut-off, tomando los valores absolutos de dicha columna\n\ningresa el cutoff y el nombre del file\n\n";
}

my $cutoff = shift @ARGV;
my $file =  shift @ARGV ;

system("grep -E 'GO:[0-9]' $file | cut -f 1,3,4,6,11 | perl -p -e 's[\/][\t]g' > tmp_file");

open IN, "tmp_file";

print "GO_ID","\t","Freq_in_genome","\t","Universe","\t","Counts", "\t","DEGs_size_list","\t","Percentage","\t","Adjusted_Pvalue","\t","Description","\t","Comparison","\n";

while( my $line = <IN> )
{

#print $line;
#}

#exit;

 chomp( $line );
                
 my @line = split(/\t/, $line);

    if ($line[1] eq 'NA' ) {
        next ;
     }
    if ($line[2] eq 'NA' ) {
         next ;
     }
    if ($line[3] eq 'NA' ) {
         next ;
     }

    if ($line[4] eq 'NA' ) {
         next ;
     }

    if ($line[5] eq 'NA' ) {
         next ;
     }
   else {


print $line[0],"\t",$line[1],"\t",$line[2],"\t",$line[3],"\t",$line[4],"\t",100*($line[3]/$line[4]),"\t",$line[5],"\t",$line[6],"\t",$file,"\n", if ($cutoff) >= abs( $line[5] );
#print $line,"\n";
        }
}
