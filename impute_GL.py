#!/usr/bin/env python
# impute_GL - impute genotype lists in NEMO pipeline

from collections import defaultdict
import sys
import copy
import time
import os
import gzip

pull_filename = sys.argv[1]
glid_filename = sys.argv[2]
HF_filename = sys.argv[3]
impute_filename = sys.argv[4]
impute_threshold = sys.argv[5]
max_genos = sys.argv[6]

sys.stderr = os.fdopen(sys.stderr.fileno(), 'w', buffering=1)

start_time = time.time()

# load GLIDs

glstring = {} # stores GL String for each GLID
glid_file = open (glid_filename,'r')
for line in glid_file:
  line = line.rstrip('\r\n')
  (glid,gl) = line.split(',')
  glstring[glid] = gl

glid_file.close()

# get IDs from pull file
genos = {}
genos_ID = defaultdict(list)
GL = defaultdict(lambda: defaultdict(dict))
pull_file = open(pull_filename,'r')
for line in pull_file:
  line = line.rstrip('\r\n')
  (id, glidlist) = line.split(',')
  (glid1,glid2) = glidlist.split(':')
  genos[id] = glidlist
  genos_ID[glidlist].append(id) 
  gl1 = glstring[glid1].split('|')
  for geno in gl1:
    if ("1" not in GL):
      GL["1"] = {}
    if (glid1 not in GL["1"]):
      GL["1"][glid1] = {}
    if (geno not in GL["1"][glid1]):
      GL["1"][glid1][geno] = 0
    GL["1"][glid1][geno] += 1

  gl2 = glstring[glid2].split('|')
  for geno in gl2:
    if ("2" not in GL):
      GL["2"] = {}
    if (glid2 not in GL["2"]):
      GL["2"][glid2] = {}
    if (geno not in GL["2"][glid2]):
      GL["2"][glid2][geno] = 0
    GL["2"][glid2][geno] += 1

pull_file.close()

# load HF
HF = {}
HF_file = open(HF_filename,'r')
for line in HF_file:
  (haplo,count,freq) = line.split(',')
  if (haplo == "Haplo"):
    continue
  HF[haplo] = float(freq)

HF_file.close()

sys.stderr.write("Imputation Input File: " + pull_filename + "\n")
sys.stderr.write("Load Time: %s seconds\n" % (time.time() - start_time))

# imputation output
impute_file = gzip.open (impute_filename,'wt')
for glidlist in genos_ID:

  # geno = genos[id]
  (glid1,glid2) = glidlist.split(":")
  haplo_pair_freq = defaultdict(float)
  haplo_pair_total = 0
  for geno1 in GL["1"][glid1]:

    (a1,a2) = geno1.split("+")

    for geno2 in GL["2"][glid2]:

      (b1,b2) = geno2.split("+")

      hap_11 = a1 + "~" + b1
      hap_12 = a1 + "~" + b2
      hap_21 = a2 + "~" + b1
      hap_22 = a2 + "~" + b2

      # DRB1DQB1 and DQA1:
      if (b1[0:4] == "DQA1") & (a1[0:4] == "DRB1"):
        dqa1_1 = b1
        dqa1_2 = b2
        (drb1_1,dqb1_1) = a1.split("~")
        (drb1_2,dqb1_2) = a2.split("~") 
        hap_11 = '~'.join([drb1_1,dqa1_1,dqb1_1])
        hap_12 = '~'.join([drb1_1,dqa1_2,dqb1_1])
        hap_21 = '~'.join([drb1_2,dqa1_1,dqb1_2])
        hap_22 = '~'.join([drb1_2,dqa1_2,dqb1_2])

      # DRBXDRB1DQB1 and DQA1
      if ((b1[0:4] == "DQA1") & (a1[0:4] in ["DRB3","DRB4","DRB5","DRBX"])):
        dqa1_1 = b1
        dqa1_2 = b2
        (drbx_1,drb1_1,dqb1_1) = a1.split("~")
        (drbx_2,drb1_2,dqb1_2) = a2.split("~") 
        hap_11 = '~'.join([drbx_1,drb1_1,dqa1_1,dqb1_1])
        hap_12 = '~'.join([drbx_1,drb1_1,dqa1_2,dqb1_1])
        hap_21 = '~'.join([drbx_2,drb1_2,dqa1_1,dqb1_2])
        hap_22 = '~'.join([drbx_2,drb1_2,dqa1_2,dqb1_2])

      # DRBXDRB1DQA1DQB1DPB1 and DPA1
      if (b1[0:4] == "DPA1"):
        dpa1_1 = b1
        dpa1_2 = b2
        (drbx_1,drb1_1,dqa1_1,dqb1_1,dpb1_1) = a1.split("~")
        (drbx_2,drb1_2,dqa1_2,dqb1_2,dpb1_2) = a2.split("~") 
        hap_11 = '~'.join([drbx_1,drb1_1,dqa1_1,dqb1_1,dpa1_1,dpb1_1])
        hap_12 = '~'.join([drbx_1,drb1_1,dqa1_1,dqb1_1,dpa1_2,dpb1_1])
        hap_21 = '~'.join([drbx_2,drb1_2,dqa1_2,dqb1_2,dpa1_1,dpb1_2])
        hap_22 = '~'.join([drbx_2,drb1_2,dqa1_2,dqb1_2,dpa1_2,dpb1_2])

      # hap_11 = "~".join([a1,b1])
      # hap_12 = "~".join([a1,b2])
      # hap_21 = "~".join([a2,b1])
      # hap_22 = "~".join([a2,b2])

      if (hap_11 > hap_22):
        (hap_11, hap_22) = (hap_22, hap_11)

      if (hap_12 > hap_21):
        (hap_12, hap_21) = (hap_21, hap_12)        

      # two possible pairs of genotypes
      if (hap_11 != hap_22):
        freq = 2 * HF[hap_11] * HF[hap_22]
      else:
        freq = HF[hap_11] ** 2

      haplo_pair_freq[hap_11 + "+" + hap_22] += freq
      haplo_pair_total += freq

      if (hap_12 != hap_21):
        freq = 2 * HF[hap_12] * HF[hap_21]
      else:
        freq = HF[hap_12] ** 2

      haplo_pair_freq[hap_12 + "+" + hap_21] += freq

      # print (id + " " + geno1 + " " + geno2 + " " + hap_11 + " " + hap_12 + " " + hap_21 + " " + hap_22 + " " + str(freq))

      haplo_pair_total += freq

  geno_count = 0
  prob_cumul = 0

  impute_out_array = []
  for hap_pair, GF in sorted(haplo_pair_freq.items(), key=lambda item: item[1], reverse=True):
    if (prob_cumul > float(impute_threshold)):
      # print ("Impute threshold reached: " + str(prob_cumul))
      continue
    if (geno_count > int(max_genos)):
      continue
    prob = GF / haplo_pair_total
    # print (hap_pair)
    (hap1, hap2) = hap_pair.split('+')
    prob_cumul += prob
    geno_count += 1
    # print (id + ',' + geno + "," + str(geno_count) + "," + hap_pair + "," + str(GF) + "," + hap1 + "," 
    #       + str(HF[hap1]) + "," + hap2 + "," + str(HF[hap2]) + "," + str(prob) + "," + str(prob_cumul))
    impute_out_array.append(str(geno_count) + "," + hap1 + "," + hap2 + "," + str(prob))

  for id in genos_ID[glidlist]:
    for impute_out_line in impute_out_array:
      impute_file.write(id + "," + impute_out_line + "\n")

impute_file.close()

sys.stderr.write("--- %s seconds ---\n" % (time.time() - start_time))

exit (0)