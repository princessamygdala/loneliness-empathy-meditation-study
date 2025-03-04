#!/bin/tcsh -xef

# Created by Marla Dressel: (March 19, 2024), example of how two-sample ttest is conducted, we did this for all masks and all outcomes 

# ---------------------- set process variables ----------------------

# Update this path to point to your specific mask dataset
set mask_dset = "/my/path/masks/MNI152-graymatter-thr50-3mm+tlrc.HEAD"

# Directory where your smoothed files are located (adjust this to your actual path)
set dirA = "/my/path/MVPAresults"

# Specify and possibly create the results directory
set results_dir = "./two_sample_ttest.results"
if ( ! -d $results_dir ) mkdir $results_dir

# ------------------------- process the data -------------------------

# Running the independent two-sample t-test
3dttest++ -prefix $results_dir/ML_AUC_2sample-ttest \
          -mask $mask_dset \
          -Clustsim \
          -setA lkm \
             sub-001 "$dirA/sub-001/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-008 "$dirA/sub-008/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-014 "$dirA/sub-014/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-018 "$dirA/sub-018/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-034 "$dirA/sub-034/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-050 "$dirA/sub-050/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-053 "$dirA/sub-053/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-063 "$dirA/sub-063/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-071 "$dirA/sub-071/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-081 "$dirA/sub-081/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-088 "$dirA/sub-088/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-102 "$dirA/sub-102/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-106 "$dirA/sub-106/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-109 "$dirA/sub-109/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-115 "$dirA/sub-115/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-119 "$dirA/sub-119/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-122 "$dirA/sub-122/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-130 "$dirA/sub-130/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-136 "$dirA/sub-136/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-139 "$dirA/sub-139/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-149 "$dirA/sub-149/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-154 "$dirA/sub-154/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-158 "$dirA/sub-158/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-169 "$dirA/sub-169/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-180 "$dirA/sub-180/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-191 "$dirA/sub-191/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-193 "$dirA/sub-193/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-195 "$dirA/sub-195/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-197 "$dirA/sub-197/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
          -setB control \
             sub-002 "$dirA/sub-002/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-003 "$dirA/sub-003/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-004 "$dirA/sub-004/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-005 "$dirA/sub-005/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-006 "$dirA/sub-006/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-007 "$dirA/sub-007/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-031 "$dirA/sub-031/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-039 "$dirA/sub-039/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-043 "$dirA/sub-043/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-052 "$dirA/sub-052/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-057 "$dirA/sub-057/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-058 "$dirA/sub-058/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-064 "$dirA/sub-064/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-067 "$dirA/sub-067/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-074 "$dirA/sub-074/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-075 "$dirA/sub-075/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-076 "$dirA/sub-076/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-156 "$dirA/sub-156/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-159 "$dirA/sub-159/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-167 "$dirA/sub-167/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-179 "$dirA/sub-179/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-187 "$dirA/sub-187/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-192 "$dirA/sub-192/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-194 "$dirA/sub-194/smoothed_res_AUC_minus_chance+tlrc.HEAD" \
             sub-196 "$dirA/sub-196/smoothed_res_AUC_minus_chance+tlrc.HEAD"
