#!/usr/bin/env perl
############################################################################
# SCRIPT NAME:  make_slurm_EM.pl
# DESCRIPTION:  Make slurm scripts for running EM pipeline on supercomputer
#
#
# DATE WRITTEN: April 19, 2020
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

my $sbatch_file = "run_sbatch_all.sh";
open (SBATCH, ">$sbatch_file") || die "Missing $sbatch_file\n";

# parameters for different slurm runs

my %EM_error_vals = (
  "E8" => 1e-8,
  "E7" => 1e-7,
  "E6" => 1e-6
);

my %greedy_reinterp_vals = (
  "G999" => 0.999,
  "G99" => 0.99,
  "G9" => 0.9
);

foreach my $pop (@pops) {

  foreach my $gr_reinterp_key (sort keys %greedy_reinterp_vals) {

    my $gr_reinterp = $greedy_reinterp_vals{$gr_reinterp_key};

    if ($pop eq "CAU") {
      print STDERR "mkdir ./greedy_$gr_reinterp_key/\n";
    }

    foreach my $EM_error_key (sort keys %EM_error_vals) { 

      my $EM_error = $EM_error_vals{$EM_error_key};

      my $job = $pop . "_" . $gr_reinterp_key . "_" . $EM_error_key;
      my $folder = $gr_reinterp_key . "_" . $EM_error_key;

      my $slurm_file = "./slurm/run_slurm_" . $job . ".sh";
      open (SLURM, ">$slurm_file") || die "Missing $slurm_file\n";

      print SBATCH "jid_$job=\$(sbatch $slurm_file)\n";
      print SBATCH "echo \$jid_$job \n";
      print SBATCH "echo \${jid_$job\#\#\* }\n";

      # spit out directories to make - one time only
      if ($pop eq "CAU") {
        print STDERR "mkdir ./CB_$folder/\n";
        print STDERR "mkdir ./ACB_$folder/\n";
        print STDERR "mkdir ./DRB1DQB1_$folder/\n";
        print STDERR "mkdir ./ACBDRB1DQB1_$folder/\n";
      }

      print SLURM "#!/bin/bash\n";
      print SLURM "#SBATCH --job-name=$job   ### Job Name\n";
      print SLURM "#SBATCH --output=./logs/NEMO_val_$job.out       ### File in which to store job output\n";
      print SLURM "#SBATCH --error=./logs/NEMO_val_$job.err        ### File in which to store job error messages\n";
      print SLURM "#SBATCH --qos=normal          ### Quality of Service (like a queue in PBS)\n";
      print SLURM "#SBATCH --time=0-24:00:00     ### Wall clock time limit in Days-HH:MM:SS\n"; 
      print SLURM "#SBATCH --mem=64000          ### Memory in MB (default memory is 64000 - 64GB)\n";
      print SLURM "#SBATCH --nodes=1             ### Node count required for the job\n";
      print SLURM "#SBATCH --ntasks-per-node=1   ### Number of tasks to be launched per Node\n\n\n";

      print SLURM "SECONDS=0 # $job\n";

      # Greedy

      print SLURM "cat ./pull/glid.$pop.txt | perl gl_greedy_5loc.pl $pop ./pull/pull.$pop.txt ./greedy_$gr_reinterp_key/ ./cfg/ $gr_reinterp 0.9999\n";

      # Class I Block

      print SLURM "python3 make_blocks.py $pop C B C B greedy_$gr_reinterp_key CB_$folder 0.01\n";
      print SLURM "python3 nemo.py ./CB_$folder/nemo.$pop.txt ./CB_$folder/glid.$pop.txt ./CB_$folder/freqs.$pop.csv $EM_error\n";
      print SLURM "python3 impute_GL.py ./CB_$folder/pull.$pop.txt ./CB_$folder/glid.$pop.txt ./CB_$folder/freqs.$pop.csv ./CB_$folder/impute.$pop.csv.gz 0.99 1000\n";
      print SLURM "python3 make_blocks.py $pop A C~B A CB_$folder greedy_$gr_reinterp_key ACB_$folder 0.01\n";
      print SLURM "rm ./CB_$folder/impute.$pop.csv.gz\n";
      print SLURM "python3 nemo.py ./ACB_$folder/nemo.$pop.txt ./ACB_$folder/glid.$pop.txt ./ACB_$folder/freqs.$pop.csv $EM_error\n";
      print SLURM "python3 impute_GL.py ./ACB_$folder/pull.$pop.txt ./ACB_$folder/glid.$pop.txt ./ACB_$folder/freqs.$pop.csv ./ACB_$folder/impute.$pop.csv.gz 0.99 1000\n";

      # Class II Block

      print SLURM "python3 make_blocks.py $pop DRB1 DQB1 DRB1 DQB1 greedy_$gr_reinterp_key DRB1DQB1_$folder 0.01\n";
      print SLURM "python3 nemo.py ./DRB1DQB1_$folder/nemo.$pop.txt ./DRB1DQB1_$folder/glid.$pop.txt ./DRB1DQB1_$folder/freqs.$pop.csv $EM_error\n";
      print SLURM "python3 impute_GL.py ./DRB1DQB1_$folder/pull.$pop.txt ./DRB1DQB1_$folder/glid.$pop.txt ./DRB1DQB1_$folder/freqs.$pop.csv ./DRB1DQB1_$folder/impute.$pop.csv.gz 0.99 1000\n";

      # 5-locus

      print SLURM "python3 make_blocks.py $pop A~C~B DRB1~DQB1 ACB_$folder DRB1DQB1_$folder greedy_$gr_reinterp_key ACBDRB1DQB1_$folder 0.01\n";
      print SLURM "rm ./ACB_$folder/impute.$pop.csv.gz\n";
      print SLURM "rm ./DRB1DQB1_$folder/impute.$pop.csv.gz\n";
      print SLURM "python3 nemo.py ./ACBDRB1DQB1_$folder/nemo.$pop.txt ./ACBDRB1DQB1_$folder/glid.$pop.txt ./ACBDRB1DQB1_$folder/freqs.$pop.csv $EM_error\n";
      print SLURM "python3 impute_GL.py ./ACBDRB1DQB1_$folder/pull.$pop.txt ./ACBDRB1DQB1_$folder/glid.$pop.txt ./ACBDRB1DQB1_$folder/freqs.$pop.csv ./ACBDRB1DQB1_$folder/impute.$pop.csv.gz 0.99 1000\n";

      print SLURM "ELAPSED=\"Elapsed $job: \$((\$SECONDS / 3600))hrs \$(((\$SECONDS / 60) % 60))min \$((\$SECONDS % 60))sec\"\n";
      print SLURM "echo \$ELAPSED # $job \n\n\n";
    }

  }

}

close SLURM;
close SBATCH;