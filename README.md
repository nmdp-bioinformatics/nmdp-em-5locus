# NMDP 5-locus EM Algorithm

### Introduction:

This repository contains the NMDP EM algorithm implementation for estimation of HLA haplotype frequency data from ambiguous genotyping data. This implementation computes up to 5-locus haplotype frequencies (`A~C~B~DRB1~DQB1`) and has no known limitations on typing ambiguity or sample size. The NEMO acronym expands to - "N-locus Expectation-Maximization algorithm for Oligonucleotide data". This refines a previous 6-locus EM algorithm implemented in Perl that was used to compute haplotype frequencies estimates for NMDP HapLogic 3 in 2011. The dataset was described in a paper in *Human Immunology* (Gragert et al. 2013). The EM uses a single-race model.



### Input Files of HLA Genotyping data:

The input files contain genotype are very large and are not included in GitHub repository.

These must be manually copied to the `/pull/` subdirectory after the repo is checked out.

Input GL String flat file format:

```
ID,GL_String,Race1,Race2
D0,A*02:01+A*01:01^C*15:02+C*07:01^B*51:01+B*08:01^DRB1*12:01+DRB1*03:01^DQB1*03:01+DQB1*02:01,CAU,CAU
```

These input files are separated into `pull` and `GLID` files using the script `gl_expand_all.sh`, which calls the Perl script `gl_expand_5loc.pl`

`glid.*.txt` - genotype list IDs (GLIDs) with genotype lists in GL string format (Milius et al. 2013). Each GLID is a single locus. 

GLID format (program expects no header): 

```
GLID,GL_String
3,B*35:03+B*51:01
```

`pull.*.txt` - extract of donor data - contains race information and the genotype list IDs for each locus.

Pull format (program expects no header):

```
ID,Race1,Race2,HLA-A,HLA-B,HLA-C,HLA-DRB1,HLA-DQB1
D27,CAU,CAU,98,126,127,128,129
```



### Key Scripts in EM Pipeline:

If the format of input files differs from above, many of these scripts will need to be modified.

`gl_expand_5loc.pl` - Expands GL String flat files to   `glid.*.txt` and `pull.*.txt` files in `/pull/` subdirectory. 

`gl_greedy_5loc.py` - Reduces typing ambiguity by using a greedy algorithm to generate a minimum list of alleles required to interpret every HLA typing in a population.  Outputs reduced `glid.*.txt` and `pull.*.txt` files in `/greedy/` subdirectory. Key command line parameters include thresholds for reinterpretation of genotype lists up to a cumulative probability threshold of percentage of subject typings at a given locus that can be interpreted using the allele list.  Previous version of gl_greedy used a seed list of common alleles (>1/2000 frequency in Maiers et al. 2007). This greedy algorithm implementation does not assume prior knowledge of HLA frequency and builds allele lists tabula rasa starting with the IMGT/HLA reference allele at each locus, adding alleles one at the time until all subjects in the population can be interpreted.

`make_blocks.py` - Generates 2-locus genotype input files for EM step which are populated in subdirectories for locus combination. Blocks refers to multi-locus haplotype pairs from imputation output being treated as a single locus. When one of the locus blocks is a single locus, input files comes from `glid.*.txt` and `pull.*.txt` files in `/greedy/` subdirectory. When one of the locus blocks is a multi-locus block, input files comes from imputation output  `impute.*.csv.gz` in a locus combo subdirectory. Outputs 

`nemo.py` - Two-locus expectation-maximization (EM) algorithm. Input files are `nemo.*.txt` and  `glid.*.txt` files. `pull.*.txt` files differ from`nemo.*.txt` because they have a row per subject ID instead of a count for each unique combinations of GLIDs. Generates a haplotype frequency output files `freqs.*.csv`.

`impute_GL.py` - Generates imputation output for each subject, trimmed at a cumulative probability threshold to reduce typing ambiguity for the next step. Input files are `nemo.*.txt`,  `glid.*.txt` , `pull.*.txt`, and `freqs.*.csv` from the EM step. Output file `impute.*.csv.gz` is a list of haplotype pairs and probabilities for each subject. Imputation output is used for make_blocks to add the next locus and can also be used for loading into graph imputation database for GRaph IMputation and Matching (GRIMM), random realization, or winner-take-all realization to an unambiguous high resolution genotype per subject.



### Running EM Pipeline using Bash script:

We provide Bash scripts to run through the EM pipeline sequentially for all population sequentially.

Execute Bash script:

```
bash gl_expand_all.sh
bash gl_greedy_all.sh
perl make_shell_EM.pl
bash run_EM_all.sh
```

If this pipeline has inadequate performance, use the Slurm scripts to run in parallel on a supercomputer.



### Running EM Pipeline using Slurm Scripts:

For some populations, some steps of the EM algorithm pipeline require nodes with 128GB of memory.

This pipeline has been run successfully on the Tulane Cypress supercomputer. https://wiki.hpc.tulane.edu/trac/wiki/cypress

To load the EM jobs into the Slurm queuing system, execute these Bash shell scripts:

```
bash gl_expand_all.sh
bash gl_greedy_all.sh
perl make_slurm_EM.sh
bash run_sbatch_all.sh
```

The Slurm scripts are set up to run the experiments for varying greedy allele list reinterpretation thresholds and error threshold for EM.

Slurm scripts will appear in `/slurm/` directory and log files will be written to the `/logs/` directory.



### Output Haplotype Frequencies:

After the Bash script or all the Slurm jobs complete, 5-locus  `A~C~B~DRB1~DQB1` haplotype frequencies will be computed as `freqs.*.csv` files in subdirectory `/ACBDRB1DQB1/` .  The Slurm scripts generate alternative output folders for different parameters for when to stop reinterpreting allele lists in the greedy algorithm (G9,G99,G999) and error thresholds for the EM (E6,E7,E8).

Freqs file format:

```
Haplo,Count,Freq
```



### References:

- Gragert L, Madbouly A, Freeman J, Maiers M. Six-locus high resolution HLA haplotype frequencies derived from mixed-resolution DNA typing for the entire US donor registry. Hum Immunol 2013;74:1313–20 PMID: 23806270.
- Hollenbach JA, Madbouly A, Gragert L, Vierra-Green C, Flesch S, Spellman S, et al. A combined `DPA1∼DPB1` amino acid epitope is the primary unit of selection on the HLA-DP heterodimer. *Immunogenetics* 2012;64:559–69 PMCID: PMC3395342.
- Kwok WW, Kovats S, Thurtle P, Nepom GT. HLA-DQ allelic polymorphisms constrain patterns of class II heterodimer formation. *J Immunol* 1993;150:2263–72 PMID: 8450211.
- Maiers, M., Gragert, L., Klitz, W. High-resolution HLA alleles and haplotypes in the United States population. *Human Immunology* 68, 779–788 (2007).
- Milius, R.P., Mack, S.J., Hollenbach, J. a, Pollack, J., Heuer, M.L., Gragert, L., Spellman, S., Guethlein, L. a, Trachtenberg, E. a, Cooley, S., Bochtler, W., Mueller, C.R., Robinson, J., Marsh, S.G.E., Maiers, M. Genotype List String: a grammar for describing HLA and KIR genotyping results in a text string. *Tissue antigens* 82, 106–112 (2013). [PMCID:PMC3715123]
- Robinson J, Barker DJ, Georgiou X, Cooper MA, Flicek P, Marsh SGE. IPD-IMGT/HLA Database. *Nucleic Acids Res* 2019:1–8.
