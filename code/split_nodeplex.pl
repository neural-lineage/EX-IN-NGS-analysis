#!/usr/bin/perl -w
use warnings;
use strict;
use File::Copy;
my $usage = qq{Usage: perl $0 fq_dir read_len barcode_len index_len sample_name};
die "$usage\n" if scalar @ARGV != 5;
my ($fq, $trim_length,$bc_len,$id_len,$n) = @ARGV;
system("mkdir $n");
my $fq1=<$fq/*_1.fq.gz>;
my $fq2=<$fq/*_2.fq.gz>;
open(FASTQ, "zcat -dc $fq2|") or die "Can't open $fq2\n";
open(O1, "|gzip >$n/${n}_S1_L001_R3_001.fastq.gz");
open(O2, "|gzip >$n/${n}_S1_L001_R2_001.fastq.gz");
open(O3, "|gzip >$n/${n}_S1_L001_I1_001.fastq.gz");
while (my $readid = <FASTQ>) {
        chomp $readid;
        $readid=~s/\// /;
        chomp (my $sequence  = <FASTQ>);
        chomp (my $comment   = <FASTQ>);
        chomp (my $quality   = <FASTQ>);
        
        my $sub_seq      =  substr $sequence, 0, $trim_length;	
        my $sub_quality  = substr $quality,  0, $trim_length;
        print O1"$readid\n$sub_seq\n$comment\n$sub_quality\n";
        $sub_seq      =  substr $sequence, $trim_length+8, $bc_len;
	$sub_seq =~tr/atcguATCGU/tagcaTAGCA/;
 	$sub_seq      = reverse $sub_seq; 
        $sub_quality  = substr $quality,  $trim_length+8, $bc_len;
        $sub_quality  = reverse $sub_quality;
        print O2"$readid\n$sub_seq\n$comment\n$sub_quality\n";
        $sub_seq      =  substr $sequence, 0-$id_len, $id_len;
        $sub_quality  = substr $quality,  0-$id_len, $id_len;
        print O3"$readid\n$sub_seq\n$comment\n$sub_quality\n";
}
close FASTQ;
open(FASTQ, "zcat -dc $fq1|") or die "Can't open $fq1\n";
open(O4, "|gzip >$n/${n}_S1_L001_R1_001.fastq.gz");
while (my $readid = <FASTQ>) {
        chomp $readid;
        $readid=~s/\// /;
        chomp (my $sequence  = <FASTQ>);
        chomp (my $comment   = <FASTQ>);
        chomp (my $quality   = <FASTQ>);
        print O4"$readid\n$sequence\n$comment\n$quality\n";
}
#copy($fq1,"out/${n}_S1_L001_R1_001.fastq.gz")||warn "could not copy files :$!";
