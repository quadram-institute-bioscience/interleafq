# interleafq

![InterleaFQ](img/interleafq_banner.png)


## Usage (short)

To interleave

    interleafq [options] reads_R1.fq reads_R2.fq > reads_interleaved.fq

To deinterleave:

    interleafq [options] -o prefix reads_interleaved.fq 
    interleafq [options] -1 file_R1.fq -2 file_R2.fq reads_interleaved.fq 

## Description

**interleafq** can read FASTQ file, gzipped or not, and interleave or deinterleave them. 
When receiving two files, it will _interleave_ them, if receiving a single file it will _deinterleave_ it. 
It is designed to perform some internal checks to minimize the occurrences of malformed output, 
if compared with popular Bash alternatives (like [this](https://gist.github.com/nathanhaigh/3521724)).

## Parameters

- **-o**, **--output-prefix** STRING

    Basename for the output file when deinterleaving. Will produce by default `{prefix}_R1.fastq` and `{prefix}_R2.fastq`.

- **-1**, **--first-pair** FILE

    Filename for the first pair produced when deinterleaving. Alternative to `-o`.

- **-2**, **--second-pair** FILE

    Filename for the second pair produced when deinterleaving. Alternative to `-o`.

- **-s**, **--strip-comments**

    Will remove comments from the sequence headers (_i. e._ any string after the first space character in the read name line).

- **-r**, **--relaxed**

    Will **not** check for inconsistencies in read names and sequence/quality length. The read names should be equal until the first '/'.

## Bugs

Please open an issue in GitHub [https://github.com/quadram-institute-bioscience/interleafq](https://github.com/quadram-institute-bioscience/interleafq).

The software is not actively maintained, but being open source it's possible to contribute to it.

## Author

Andrea Telatin <andrea@telatin.com>

## Copyright

Copyright (C) 2020 Andrea Telatin 

This program is free software: you can redistribute it and/or modify
it under the terms of the [MIT LICENSE](LICENSE).

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
