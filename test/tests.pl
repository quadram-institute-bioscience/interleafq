#!/usr/bin/env perl
use 5.012;
use warnings;
use FindBin qw($RealBin);
use Data::Dumper;
my $data_dir = "$RealBin/../data/";
my $script   = "$RealBin/../scripts/interleafq.pl";

my %commands = (
    # Deinterleve: OK
    qq(perl $script -o "$data_dir/T_" "$data_dir/interleaved_suffix.fq")  => 0,
    qq(perl $script -1 "$data_dir/T_1.fq" -2 "$data_dir/T_2.fq"  "$data_dir/interleaved_suffix.fq")  => 0,
    qq(perl $script -o "$data_dir/T_" "$data_dir/interleaved_suffix.fq.gz")  => 0,
    qq(perl $script -o "$data_dir/T_" "$data_dir/interleaved_quality_error.fq")  => 0, # Error is tolerated but output will be truncated
    qq(perl $script -1 "$data_dir/T_1.fq.gz" -2 "$data_dir/T_2.fq.gz"  "$data_dir/interleaved_suffix.fq") => 0, # gzip

    # Deinterleave: KO    
    qq(perl $script -1 "$data_dir/T_1.fq" -1 "$data_dir/T_2.fq"  "$data_dir/interleaved_suffix.fq")  => 1,# Same parameter provided
    qq(perl $script -1 "$data_dir/T_1.fq" -1 "$data_dir/T_1.fq"  "$data_dir/interleaved_suffix.fq")  => 1,# Same output file provided
    qq(perl $script "$data_dir/non_existing_file.fq")  => 1,
    
    qq(perl $script -o "$data_dir/T_" "$data_dir/interleaved_error.fq")  => 1, #
    qq(perl $script "$data_dir/phi_reads_R1.fq.gz") => 1, # missing output parameters

    # Interleve: OK
    qq(perl $script   "$data_dir/phi_reads_R1.fq.gz" "$data_dir/phi_reads_R2.fq.gz")  => 0,
    qq(perl $script   "$data_dir/vir_reads1.fq" "$data_dir/vir_reads2.fq")  => 0,
     
    # Interleve: KO    
    qq(perl $script "$data_dir/error1_R1.fq" "$data_dir/error1_R2.fq")  => 1, # R1 has more reads than R2
    qq(perl $script "$data_dir/error2_R1.fq" "$data_dir/error2_R2.fq")  => 1, # Not exists
); 
my @delete_files = (
"$data_dir/T_1.fq.gz",
"$data_dir/T_1.fq",
"$data_dir/T_2.fq.gz",
"$data_dir/T_2.fq",
"$data_dir/T__R1.fastq",
"$data_dir/T__R2.fastq");

my $c = 0;
for my $command (sort { $commands{$a} <=> $commands{$b} } keys %commands) {
    $c++;
    my $expected = 'SUCCESS';
    $expected = 'FAIL' if ($commands{$command});
    say STDERR "[$c] $command (expecting $expected)";
    system("$command 2>/dev/null >/dev/null");

    if ($? and $commands{$command} == 0) {
        die "! $c FAILED: Expected success but returned $?\n";
    } elsif ($? == 0 and $commands{$command}) {
        die "! $c FAILED: Expected failure but returned 0\n";
    }

}

for my $file (@delete_files) {
    unlink "$file" if -e "$file";   
}

say 'OK';