#!/usr/bin/env perl
use 5.012;
use warnings;
use Benchmark qw(:all);
use FindBin qw($RealBin);
my $datadir = "$RealBin/../data/";
my $scriptdir = "$RealBin/../scripts/";

my $count = 20;

say 'DEINTERLEAVE';

my $bigtmp = '/tmp/ilv.fq';
for (my $i = 1; $i <= 50; $i++) {
	system(qq (cat "$datadir/interleaved_suffix.fq" >> "$bigtmp") );
}
#'interleaved_suffix.fq.gz', 'interleaved_quality_error.fq', 'interleaved_error.fq'
for my $file ('interleaved_suffix.fq', "$bigtmp") {
 say " - $file";
 my $filepath = $file;
 $filepath = "$datadir$file" if (substr($file, 0, 1) ne '/');

 my $perl = qq(perl "$scriptdir/interleafq.pl" -o "$datadir/T_" "$filepath");
 #deinterleave_fastq.sh < interleaved.fastq f.fastq r.fastq [compress]
 my $bash = qq(bash "$scriptdir/deinterleave.sh" < "$filepath" "$datadir/T_1" "$datadir/T_2");
 my $results = timethese($count,
    {
        'perl' => sub {  system($perl) },
        'bash' => sub {  system($bash) },
    },
    'none'
 );

 cmpthese( $results ) ;
}

__END__
error1_R1.fq
error1_R2.fq
interleaved_error.fq
interleaved_quality_error.fq
interleaved_suffix.fq
interleaved_suffix.fq.gz
phi_reads_R1.fq.gz
phi_reads_R2.fq.gz
vir_reads1.fq
vir_reads2.fq
