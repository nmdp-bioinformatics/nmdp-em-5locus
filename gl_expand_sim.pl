#!/usr/bin/env perl
############################################################################
# SCRIPT NAME:  gl_expand_5loc.pl
# DESCRIPTION:  EM simulation .txt files split into 
#               Pull and GLID files to expand '/' to '+'
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

my $txt_file = shift @ARGV || die;
my $glid_file = shift @ARGV || die;
my $pull_file = shift @ARGV || die;

# load genotype list IDs and fully enumerate genotype lists
my %GLID; # genotype lists by ID
my %GLID_locus; # locus for genotype list
my %glstrings; # unique GL Strings
my %numglids; # number of glids at each locus
my $numgenos = 0; # number of genotypes

$glstrings{"UUUU+UUUU"} = 0;

# create unique GLIDs
my $glid_index = 1;
open (TXT,"$txt_file") || die "Can't open $txt_file";
open (PULL,">$pull_file") || die "Can't open $pull_file";
while (<TXT>) {
  chomp;

  my ($id,$glstring,$race1,$race2);
  if ($_ =~ m/[,]/) {
    ($id,$glstring,$race1,$race2)= split /,/,$_;
  }
  else {
    ($id,$glstring,$race1,$race2)= split /\%/,$_;    
  }

  # array of GLs - not all loci are included
  my (@glstrings) = split /\^/,$glstring;

  # default GLID is 0 if locus is missing
  my $gl_a = "UUUU+UUUU";
  my $gl_c = "UUUU+UUUU";
  my $gl_b = "UUUU+UUUU";
  my $gl_drb1 = "UUUU+UUUU";
  my $gl_dqb1 = "UUUU+UUUU";

  for my $gl (@glstrings) {
    if ($gl eq "C*UUUU+C*UUUU") { $gl = "UUUU+UUUU"}
    if ($gl eq "DRB1*UUUU+DRB1*UUUU") { $gl = "UUUU+UUUU"}
    if ($gl eq "DQB1*UUUU+DQB1*UUUU") { $gl = "UUUU+UUUU"}
    my ($loc,$string) = split /\*/,$gl;
    $GLID_locus{$glid_index} = $loc;
    # $glstrings{$gl} = $glid_index;
    # $glid_index++;
    if ($loc eq "A") { $gl_a = $gl; }
    if ($loc eq "C") { $gl_c = $gl; }
    if ($loc eq "B") { $gl_b = $gl; }
    if ($loc eq "DRB1") { $gl_drb1 = $gl; }
    if ($loc eq "DQB1") { $gl_dqb1 = $gl; }
  }

  # print STDERR "GL $gl_a $gl_c $gl_b $gl_drb1 $gl_dqb1\n";

  if (!exists $glstrings{$gl_a}) {
    $glstrings{$gl_a} = $glid_index;
    $GLID_locus{$glid_index} = "A";
    $glid_index++;
  }
  if (!exists $glstrings{$gl_c}) {
    $glstrings{$gl_c} = $glid_index;
    $GLID_locus{$glid_index} = "C";
    $glid_index++;
  }
  if (!exists $glstrings{$gl_b}) {
    $glstrings{$gl_b} = $glid_index;
    $GLID_locus{$glid_index} = "B";
    $glid_index++;
  }
  if (!exists $glstrings{$gl_drb1}) {
    $glstrings{$gl_drb1} = $glid_index;
    $GLID_locus{$glid_index} = "DRB1";
    $glid_index++;
  }
  if (!exists $glstrings{$gl_dqb1}) {
    $glstrings{$gl_dqb1} = $glid_index;
    $GLID_locus{$glid_index} = "DQB1";
    $glid_index++;
  }

  print PULL "$id,$race1,$race2,$glstrings{$gl_a},$glstrings{$gl_c},$glstrings{$gl_b},$glstrings{$gl_drb1},$glstrings{$gl_dqb1}\n";

} # end while txt 
close TXT;

open (GLID,">$glid_file") || die "Can't open $glid_file";

foreach my $glstring (sort keys %glstrings) {

  my $glid = $glstrings{$glstring};
  # print STDERR "GLID: $glid GLString: $glstring\n";

  my @genos_full; # array of genotypes with '+'
  my %unique_genos; # list of unique genotypes

  # GLID #0 is untyped
  if ($glid == 0) { 
    push @genos_full, "UUUU+UUUU";
    print GLID ("0,UUUU+UUUU\n");
    print STDERR "Blank GL String GLID 0 $glstring\n";
    next;
  }

  # make intermediate genotype list
  my @genos_inter = split /'|'/, $glstring;
  # make fully enumerated genotype
  foreach my $geno (@genos_inter) {
    my ($l1,$l2) = split /\+/, $geno;
    if (!defined $l2) { $l2 = $l1; }
    if ($l1 eq "") { $l1 = $l2; } # 73354:+DRB1*15:01
    # strip out DRB345
    my ($l1_drb1,$l1_drb345) = split /\~/,$l1; 
    my ($l2_drb1,$l2_drb345) = split /\~/,$l2;
    my @l1 = split /\//,$l1_drb1;
    my @l2 = split /\//,$l2_drb1;

    foreach my $loctyp1 (@l1) {
      foreach my $loctyp2 (@l2) {

        $numgenos++;
        # sort alleles to avoid duplicate genotypes
        # if ($loctyp1 gt $loctyp2) {
        #   ($loctyp1, $loctyp2) = ($loctyp2, $loctyp1);
        # }
        push @genos_full, "$loctyp1+$loctyp2";

        # no dupe genos were found
        # $geno = "$loctyp1+$loctyp2"
        # if (!exists $unique_genos{$geno}) {
        #   $unique_genos{$geno};
        #   push @genos_full, "$loctyp1+$loctyp2";
        # }
        # else {
        #   print STDERR "Dupe geno $geno\n";
        # }
      }
    }
  }

  $glstring = join "|",@genos_full;

  # store locus for GLID
  # if ($glstring =~ m/^A/) { $GLID_locus{$glid} = "A"; }
  # if ($glstring =~ m/^C/) { $GLID_locus{$glid} = "C"; }
  # if ($glstring =~ m/^B/) { $GLID_locus{$glid} = "B"; }
  # if ($glstring =~ m/^DRB1/) { $GLID_locus{$glid} = "DRB1"; }
  # if ($glstring =~ m/^DQB1/) { $GLID_locus{$glid} = "DQB1"; }
  # if ($glstring =~ m/^DRB3/) { $GLID_locus{$glid} = "DRBX"; }
  # if ($glstring =~ m/^DRB4/) { $GLID_locus{$glid} = "DRBX"; }
  # if ($glstring =~ m/^DRB5/) { $GLID_locus{$glid} = "DRBX"; }
  # if ($glstring =~ m/^DRBX/) { $GLID_locus{$glid} = "DRBX"; }
  # if ($glstring =~ m/^DQA1/) { $GLID_locus{$glid} = "DQA1"; }
  # if ($glstring =~ m/^DPB1/) { $GLID_locus{$glid} = "DPB1"; }
  # if ($glstring =~ m/^DPA1/) { $GLID_locus{$glid} = "DPA1"; }

  # $numglids{$GLID_locus{$glid}}++;
  # if (!exists $GLID_locus{$glid}) { print STDERR "GLID has no locus: $_\n"; }

  print GLID "$glid,$glstring\n";

}
close GLID;

print STDERR "Number of genotypes in GLID file: $numgenos\n";

exit(0);