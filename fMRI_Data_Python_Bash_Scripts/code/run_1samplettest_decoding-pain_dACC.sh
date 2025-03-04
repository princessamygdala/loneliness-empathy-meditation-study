#!/bin/tcsh -xef

# Created by Marla Dressel: (Updated November 21, 2024)

# ---------------------- set process variables ----------------------

# Update this path to point to your specific mask dataset
set mask_dset = "/my/path/fMRIData/masks/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"

# Directory where your decoding analysis files are located
set dirA = "/my/path/fMRIData/mvpa/decoding/pain/dACC"

# Specify and possibly create the results directory
set results_dir = "/my/path/fMRIData/2ndlevel_glm/ttests/"
if ( ! -d $results_dir ) mkdir $results_dir

# Change to the results directory
cd $results_dir

# ------------------------- process the data -------------------------

# Running the one-sample t-test
3dttest++ -prefix 1sample-ttest_decoding_pain_dACC \
          -mask $mask_dset \
          -Clustsim \
          -setA Decoding_pain \
             001 "$dirA/sub-001/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             002 "$dirA/sub-002/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             003 "$dirA/sub-003/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             004 "$dirA/sub-004/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             005 "$dirA/sub-005/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             006 "$dirA/sub-006/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             007 "$dirA/sub-007/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             008 "$dirA/sub-008/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             014 "$dirA/sub-014/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             018 "$dirA/sub-018/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             031 "$dirA/sub-031/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             034 "$dirA/sub-034/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             039 "$dirA/sub-039/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             043 "$dirA/sub-043/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             050 "$dirA/sub-050/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             052 "$dirA/sub-052/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             053 "$dirA/sub-053/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             057 "$dirA/sub-057/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             058 "$dirA/sub-058/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             063 "$dirA/sub-063/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             064 "$dirA/sub-064/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             067 "$dirA/sub-067/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             071 "$dirA/sub-071/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             074 "$dirA/sub-074/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             075 "$dirA/sub-075/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             076 "$dirA/sub-076/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             081 "$dirA/sub-081/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             088 "$dirA/sub-088/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             102 "$dirA/sub-102/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             106 "$dirA/sub-106/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             109 "$dirA/sub-109/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             115 "$dirA/sub-115/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             119 "$dirA/sub-119/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             122 "$dirA/sub-122/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             130 "$dirA/sub-130/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             136 "$dirA/sub-136/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             139 "$dirA/sub-139/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             149 "$dirA/sub-149/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             154 "$dirA/sub-154/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             156 "$dirA/sub-156/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             158 "$dirA/sub-158/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             159 "$dirA/sub-159/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             167 "$dirA/sub-167/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             169 "$dirA/sub-169/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             179 "$dirA/sub-179/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             180 "$dirA/sub-180/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             187 "$dirA/sub-187/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             191 "$dirA/sub-191/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             192 "$dirA/sub-192/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             193 "$dirA/sub-193/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             194 "$dirA/sub-194/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             195 "$dirA/sub-195/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             196 "$dirA/sub-196/res_AUC_minus_chance_smoothed+tlrc.HEAD" \
             197 "$dirA/sub-197/res_AUC_minus_chance_smoothed+tlrc.HEAD"
