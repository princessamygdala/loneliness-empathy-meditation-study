#!/bin/tcsh -xef

# Created by Marla Dressel: (Updated November 21, 2024)

# ---------------------- set process variables ----------------------

# Update this path to point to your specific mask dataset
set mask_dset = "/my/path/fMRIData/masks/MNI152NLin2009cAsym-desc-graymatter-thr25_3mm-mask_resampled.nii.gz"

# Directory where your pattern similarity files are located
set dirA = "/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain/wholebrain"

# Specify and possibly create the results directory
set results_dir = "/my/path/fMRIData/2ndlevel_glm/ttests/"
if ( ! -d $results_dir ) mkdir $results_dir

# Change to the results directory
cd $results_dir

# ------------------------- process the data -------------------------

# Running the one-sample t-test
3dttest++ -prefix 1sample-ttest_rdm_pain_wholebrain \
          -mask $mask_dset \
          -Clustsim \
          -setA RDM_Pain \
             001 "$dirA/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             002 "$dirA/sub-002_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             003 "$dirA/sub-003_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             004 "$dirA/sub-004_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             005 "$dirA/sub-005_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             006 "$dirA/sub-006_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             007 "$dirA/sub-007_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             008 "$dirA/sub-008_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             014 "$dirA/sub-014_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             018 "$dirA/sub-018_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             031 "$dirA/sub-031_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             034 "$dirA/sub-034_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             039 "$dirA/sub-039_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             043 "$dirA/sub-043_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             050 "$dirA/sub-050_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             052 "$dirA/sub-052_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             053 "$dirA/sub-053_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             057 "$dirA/sub-057_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             058 "$dirA/sub-058_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             063 "$dirA/sub-063_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             064 "$dirA/sub-064_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             067 "$dirA/sub-067_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             071 "$dirA/sub-071_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             074 "$dirA/sub-074_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             075 "$dirA/sub-075_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             076 "$dirA/sub-076_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             081 "$dirA/sub-081_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             088 "$dirA/sub-088_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             102 "$dirA/sub-102_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             106 "$dirA/sub-106_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             109 "$dirA/sub-109_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             115 "$dirA/sub-115_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             119 "$dirA/sub-119_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             122 "$dirA/sub-122_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             130 "$dirA/sub-130_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             136 "$dirA/sub-136_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             139 "$dirA/sub-139_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             149 "$dirA/sub-149_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             154 "$dirA/sub-154_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             156 "$dirA/sub-156_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             158 "$dirA/sub-158_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             159 "$dirA/sub-159_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             167 "$dirA/sub-167_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             169 "$dirA/sub-169_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             179 "$dirA/sub-179_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             180 "$dirA/sub-180_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             187 "$dirA/sub-187_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             191 "$dirA/sub-191_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             192 "$dirA/sub-192_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             193 "$dirA/sub-193_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             194 "$dirA/sub-194_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             195 "$dirA/sub-195_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             196 "$dirA/sub-196_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD" \
             197 "$dirA/sub-197_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
