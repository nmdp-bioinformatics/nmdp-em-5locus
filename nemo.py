#!/usr/bin/env python
# NEMO - EM algorithm in Python

from collections import defaultdict
import sys
import copy
import time
import os

nemo_filename = sys.argv[1]
glid_filename = sys.argv[2]
HF_filename = sys.argv[3]
error_threshold = sys.argv[4]

start_time = time.time()

sys.stderr = os.fdopen(sys.stderr.fileno(), 'w', buffering=1)

# loci do not need to be stored anywhere

# load GLIDs

glstring = {} # stores GL String for each GLID
glid_file = open (glid_filename,'r')
for line in glid_file:
  line = line.rstrip('\r\n')
  (glid,gl) = line.split(',')
  glstring[glid] = gl
glid_file.close()

# load NEMO file with counts
genos = defaultdict(int) # stores genotypes
GL = defaultdict(lambda: defaultdict(dict))
ndonor = 0
nemo_file = open (nemo_filename,'r')
for line in nemo_file:
  line = line.rstrip('\r\n')
  (glidlist,count) = line.split(',')
  (glid1,glid2) = glidlist.split(':')
  gl1 = glstring[glid1].split('|')
  for geno in gl1:
    if ("1" not in GL):
      GL["1"] = {}
    if (glid1 not in GL["1"]):
      GL["1"][glid1] = {}
    if (geno not in GL["1"][glid1]):
      GL["1"][glid1][geno] = 0
    GL["1"][glid1][geno] += int(count)
  gl2 = glstring[glid2].split('|')
  for geno in gl2:
    if ("2" not in GL):
      GL["2"] = {}
    if (glid2 not in GL["2"]):
      GL["2"][glid2] = {}
    if (geno not in GL["2"][glid2]):
      GL["2"][glid2][geno] = 0
    GL["2"][glid2][geno] += int(count)
    # print (geno)
  genos[glidlist] += int(count)
  ndonor += int(count)
nemo_file.close()

GLsize = len(GL)

genos_unique = len(genos)

HF = defaultdict(float) # old estimate
H = defaultdict(float) # new estimate

# initialize haplotype frequency hash
alleles1 = {}
alleles2 = {}
for glid1 in GL["1"]:
  for geno in GL["1"][glid1]:
    (allele1,allele2) = geno.split('+')
    alleles1[allele1] = 1
    alleles1[allele2] = 1
for glid2 in GL["2"]:
  for geno in GL["2"][glid2]:
    (allele1,allele2) = geno.split('+')
    alleles2[allele1] = 1
    alleles2[allele2] = 1


nalleles1 = len(alleles1)
nalleles2 = len(alleles2)

poss_haplos = nalleles1 * nalleles2

numhaplos = 0
for geno in genos:

  (glid1,glid2) = geno.split(":")

  for geno1 in GL["1"][glid1]:

    (a1,a2) = geno1.split("+")

    for geno2 in GL["2"][glid2]:
      
      (b1,b2) = geno2.split("+")
      hap_11 = a1 + "~" + b1
      hap_12 = a1 + "~" + b2
      hap_21 = a2 + "~" + b1
      hap_22 = a2 + "~" + b2
      if hap_11 not in HF:
        HF[hap_11] = 0
        numhaplos+=1
      if hap_12 not in HF:
        HF[hap_12] = 0
        numhaplos+=1
      if hap_21 not in HF:
        HF[hap_21] = 0
        numhaplos+=1        
      if hap_22 not in HF:
        HF[hap_22] = 0
        numhaplos+=1

    # print (haplo + " " + str(HF[haplo]))

sys.stderr.write("NEMO Input File: " + nemo_filename + "\n")
sys.stderr.write("Number of Donors: " + str(ndonor) + "\n")
sys.stderr.write("Number of Unique Genotypes: " + (str(len(genos))) + "\n")
sys.stderr.write("Number of Possible Haplotypes: " + str(poss_haplos) + "\n")
sys.stderr.write("Number of Haplotypes: " + str(numhaplos) + "\n")
sys.stderr.write("Number of Locus 1 Alleles: " + str(nalleles1) + "\n")
sys.stderr.write("Number of Locus 2 Alleles: " + str(nalleles2) + "\n")
sys.stderr.write("Error Threshold: " + error_threshold + "\n")

for haplo in HF:
  HF[haplo] = 1/numhaplos


# initialize new HF
H = copy.deepcopy(HF)
for haplo in H:
  H[haplo] = 0

# perform EM iterations
max_iter = 1000
stop = 0
i = 1

sys.stderr.write("Data Load Runtime %s seconds\n" % (time.time() - start_time))

while ((i < max_iter) & (stop == 0)):

  iter_start = time.time()

  for geno in genos:
    weight = genos[geno] * 0.5 / ndonor

    total = 0

    (glid1,glid2) = geno.split(":")

    expect_start = time.time()
    # expectation
    for geno1 in GL["1"][glid1]:

      (a1,a2) = geno1.split("+")

      for geno2 in GL["2"][glid2]:
        
        (b1,b2) = geno2.split("+")
        
        total += HF[a1 + "~" + b1] * HF[a2 + "~" + b2]
        total += HF[a1 + "~" + b2] * HF[a2 + "~" + b1]    
    # print ("Expect_Time : %s " % (time.time() - expect_start))


    # calculate adjust term
    term = 0
    if (total != 0):
      term = weight / total
    # print ("Total: " + str(total) + " Term: " + str(term) + " Weight: " + str(weight))
  
    # maximization
    max_start = time.time()
    for geno1 in GL["1"][glid1]:

      (a1,a2) = geno1.split("+")

      for geno2 in GL["2"][glid2]:

        (b1,b2) = geno2.split("+")

        hap_11 = a1 + "~" + b1
        hap_12 = a1 + "~" + b2
        hap_21 = a2 + "~" + b1
        hap_22 = a2 + "~" + b2

        fwd = HF[hap_11] * HF[hap_22] * term
        xwd = HF[hap_12] * HF[hap_21] * term
        H[hap_11] += fwd
        H[hap_22] += fwd
        H[hap_12] += xwd
        H[hap_21] += xwd        

      # hap_11 = "~".join([a1,b1])
      # hap_12 = "~".join([a1,b2])
      # hap_21 = "~".join([a2,b1])
      # hap_22 = "~".join([a2,b2])

    # print ("Max_Time : %s " % (time.time() - max_start))


  # calculate error across all genos
  err = 0
  for haplo in H:
    err += abs(H[haplo] - HF[haplo])
  
  adj_err = err / numhaplos * 1000 # scale total error by number of haplos
  if (err < (float(error_threshold) * numhaplos / 1000)):
    stop = 1

  iter_time = time.time() - iter_start
  sys.stderr.write("Iter: " + str(i) + " Err: " + str(adj_err) + " Iter_Time : " + str(iter_time) + "\n")

  # update HF estimates
  HF = copy.deepcopy(H)
  for haplo in H:
    H[haplo] = 0

  i+=1

# end iterations

# print haplotype freqs
HF_file = open(HF_filename,'w')
HF_file.write("Haplo,Count,Freq\n")
for haplo in sorted(HF.keys()):
  count = HF[haplo]*2*ndonor

  # can't skip zeroes because missing key in DRBXDRB1 restricted result
  # if (str(count) == "0.0"):
  #   continue

  # output all haplotypes otherwise impute can fail
  HF_file.write(haplo + "," + str(count) + "," + str(HF[haplo]) + "\n")

HF_file.close()

sys.stderr.write("--- %s seconds ---\n" % (time.time() - start_time))

exit(0)