#!/usr/bin/env perl
############################################################################
# SCRIPT NAME:  make_shell_EM.pl
# DESCRIPTION:  Make shell scripts for running EM pipeline 
#
# DATE WRITTEN: May 17, 2020
# WRITTEN BY:   Loren Gragert
#
# REVISION HISTORY:
# REVISION DATE         REVISED BY      DESCRIPTION
# ------- ----------    --------------  -------------------------------------
#
##############################################################################
use strict; # always
use warnings; # always
use POSIX;

my $pops = "CAU,AAFA_CARB,AAFA_NAMER,FILII_NAMER,MENAFC_NAMER,AAFA_CARB_3000,AAFA_NAMER_3000,FILII_NAMER_3000,MENAFC_NAMER_3000,MR,MR_1000,MR_3000,MR_10000";
my @pops = split /,/,$pops;

my $shell_file = "run_EM_all.sh";
open (SHELL, ">$shell_file") || die "Missing $shell_file\n";

foreach my $pop (@pops) {

  # Class I Block

  print SHELL "python3 make_blocks.py $pop C B greedy CB 0.01\n";
  print SHELL "python3 nemo.py ./CB/nemo.$pop.txt ./CB/glid.$pop.txt ./CB/freqs.$pop.csv 1e-7\n";
  print SHELL "python3 impute_GL.py ./CB/pull.$pop.txt ./CB/glid.$pop.txt ./CB/freqs.$pop.csv ./CB/impute.$pop.csv.gz 0.99 1000\n";
  print SHELL "python3 make_blocks.py $pop A C~B greedy ACB 0.01\n";
  print SHELL "rm ./CB/impute.$pop.csv.gz\n";
  print SHELL "python3 nemo.py ./ACB/nemo.$pop.txt ./ACB/glid.$pop.txt ./ACB/freqs.$pop.csv 1e-7\n";
  print SHELL "python3 impute_GL.py ./ACB/pull.$pop.txt ./ACB/glid.$pop.txt ./ACB/freqs.$pop.csv ./ACB/impute.$pop.csv.gz 0.99 1000\n";

  # Class II Block

  print SHELL "python3 make_blocks.py $pop DRB1 DQB1 greedy DRB1DQB1 0.01\n";
  print SHELL "python3 nemo.py ./DRB1DQB1/nemo.$pop.txt ./DRB1DQB1/glid.$pop.txt ./DRB1DQB1/freqs.$pop.csv 1e-7\n";
  print SHELL "python3 impute_GL.py ./DRB1DQB1/pull.$pop.txt ./DRB1DQB1/glid.$pop.txt ./DRB1DQB1/freqs.$pop.csv ./DRB1DQB1/impute.$pop.csv.gz 0.99 1000\n";

  # 5-locus

  print SHELL "python3 make_blocks.py $pop A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01\n";
  print SHELL "rm ./ACB/impute.$pop.csv.gz\n";
  print SHELL "rm ./DRB1DQB1/impute.$pop.csv.gz\n";
  print SHELL "python3 nemo.py ./ACBDRB1DQB1/nemo.$pop.txt ./ACBDRB1DQB1/glid.$pop.txt ./ACBDRB1DQB1/freqs.$pop.csv 1e-7\n";
  print SHELL "python3 impute_GL.py ./ACBDRB1DQB1/pull.$pop.txt ./ACBDRB1DQB1/glid.$pop.txt ./ACBDRB1DQB1/freqs.$pop.csv ./ACBDRB1DQB1/impute.$pop.csv.gz 0.99 1000\n";


}

close SHELL;