# interleafq

![InterleaFQ](img/interleafq_banner.png)


## SYNOPSIS

To interleave

    interleafq reads_R1.fq reads_R2.fq > reads_interleaved.fq

To deinterleave:

    interleafq -o prefix reads_interleaved.fq 

## DESCRIPTION

**interleafq** can read FASTQ file, gzipped or not, and interleave or deinterleave them. 
When receiving two files, it will _interleave_ them, if receiving a single file it will _deinterleave_ it. 
It is designed to perform some internal checks to minimize the occurrences of malformed output, 
if compared with popular Bash alternatives (like [this](https://gist.github.com/nathanhaigh/3521724)).

## PARAMETERS

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

## BUGS

Please open an issue in GitHub [https://github.com/quadram-institute-bioscience/interleafq](https://github.com/quadram-institute-bioscience/interleafq).

The software is not actively maintained, but being open source it's possible to contribute to it.

## AUTHOR

Andrea Telatin <andrea@telatin.com>

## COPYRIGHT

Copyright (C) 2020 Andrea Telatin 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see &lt;http://www.gnu.org/licenses/>.
