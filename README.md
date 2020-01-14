# interleafq

Interleave and deinterleave FASTQ files, supporting gzipped input (and output, when deinterleaving)

[![Build Status](https://travis-ci.org/quadram-institute-bioscience/interleafq.svg?branch=master)](https://travis-ci.org/quadram-institute-bioscience/interleafq)
[![Install with Conda](https://anaconda.org/bioconda/interleafq/badges/installer/conda.svg)](https://anaconda.org/bioconda/interleafq)
![Conda version](https://anaconda.org/bioconda/interleafq/badges/version.svg)

![InterleaFQ](img/interleafq_banner.png)


## Usage (short)

To interleave (2 input files):

    interleafq [options] reads_R1.fq reads_R2.fq > reads_interleaved.fq

To deinterleave (1 input file):

    interleafq [options] -o prefix reads_interleaved.fq 
    interleafq [options] -1 file_R1.fq -2 file_R2.fq reads_interleaved.fq 

## Description

**interleafq** can read FASTQ file, gzipped or not, and interleave or deinterleave them. 
When receiving two files, it will _interleave_ them, if receiving a single file it will _deinterleave_ it. 
It is designed to perform some internal checks to minimize the occurrences of malformed output, 
if compared with popular Bash alternatives (like [this](https://gist.github.com/nathanhaigh/3521724)).

The performance is also better than the Bash script (see `test/bench.pl`):
```
     s/iter bash perl
bash   28.6   -- -82%
perl   5.23 447%   --
```

## Parameters

- **-o**, **--output-prefix** STRING

    Basename for the output file when deinterleaving. Will produce by default `{prefix}_R1.fastq` and `{prefix}_R2.fastq`. 

- **-1**, **--first-pair** FILE

    Filename for the first pair produced when deinterleaving. 
    Alternative to `-o`. If the filename ends by `.gz`, the file will be saved compressed.

- **-2**, **--second-pair** FILE

    Filename for the second pair produced when deinterleaving. 
    Alternative to `-o`. If the filename ends by `.gz`, the file will be saved compressed.

- **-s**, **--strip-comments**

    Will remove comments from the sequence headers (_i. e._ any string after the first space character in the read name line).

- **-r**, **--relaxed**

    Will **not** check for inconsistencies in read names and sequence/quality length. The read names should be equal until the first '/'.
    
- **-z**, **--gzip-output**

    Will save deinterleaved files compressed (adding .gz to the filename). To be used with `-o`.
   
- **-i**, **--force-interleave**

    When supplying only one filename, will try to guess the name of the second paired-end replacing `_R1` with `_R2`.
 
- **-v**, **--verbose**

    Enable verbose output, will print number of printed sequences at the end (can be less than total if there are errors).
    
- **-h**, **--help**

    Display manual page
    
- **--version**

    Display version number and exit


## Bugs

Please open an [issue](https://github.com/quadram-institute-bioscience/interleafq/issues).
 

## Author

Andrea Telatin <andrea@telatin.com>

## Copyright

Copyright (C) 2020 Andrea Telatin 

This program is free software: you can redistribute it and/or modify
it under the terms of the [MIT LICENSE](LICENSE).

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
