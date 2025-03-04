#!/bin/tcsh

# Define paths
set dirA = "/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain"

# input paths
set dACC_dir = "${dirA}/dACC"
set leftAI_dir = "${dirA}/leftAI"
set rightAI_dir = "${dirA}/rightAI"

# mask paths
set mask_dACC = "/my/path/fMRIData/masks/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"
set mask_leftAI = "/my/path/fMRIData/masks/aal2_desc-left-AI_3mm-mask_resampled.nii.gz"
set mask_rightAI = "/my/path/fMRIData/masks/aal2_desc-right-AI_3mm-mask_resampled.nii.gz"

# Define output paths
set output_dir = "/my/path/fMRIData/2ndlevel_glm/3dMVM"
set output_dACC_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_dACC.nii.gz"
set resid_dACC_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_dACC_residuals.nii.gz"

set output_dACC_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_dACC.nii.gz"
set resid_dACC_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_dACC_residuals.nii.gz"

set output_leftAI_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_leftAI_residuals.nii.gz"

set output_leftAI_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_leftAI_residuals.nii.gz"

set output_rightAI_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_loneliness = "${output_dir}/3dMVM_GroupLoneliness_patternsim-pain_rightAI_residuals.nii.gz"

set output_rightAI_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_EC = "${output_dir}/3dMVM_GroupEC_patternsim-pain_rightAI_residuals.nii.gz"

set output_dACC_PT = "${output_dir}/3dMVM_GroupPT_patternsim-pain_dACC.nii.gz"
set resid_dACC_PT  = "${output_dir}/3dMVM_GroupPT_patternsim-pain_dACC_residuals.nii.gz"

set output_dACC_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_dACC.nii.gz"
set resid_dACC_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_dACC_residuals.nii.gz"

set output_dACC_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_dACC.nii.gz"
set resid_dACC_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_dACC_residuals.nii.gz"

set output_dACC_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_dACC.nii.gz"
set resid_dACC_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_dACC_residuals.nii.gz"

set output_leftAI_PT = "${output_dir}/3dMVM_GroupPT_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_PT = "${output_dir}/3dMVM_GroupPT_patternsim-pain_leftAI_residuals.nii.gz"

set output_leftAI_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_leftAI_residuals.nii.gz"

set output_leftAI_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_leftAI_residuals.nii.gz"

set output_leftAI_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_leftAI.nii.gz"
set resid_leftAI_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_leftAI_residuals.nii.gz"

set output_rightAI_PT = "${output_dir}/3dMVM_GroupPT_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_PT = "${output_dir}/3dMVM_GroupPT_patternsim-pain_rightAI_residuals.nii.gz"

set output_rightAI_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_mc_stateEmp_fear = "${output_dir}/3dMVM_Groupmc_stateEmp_fear_patternsim-pain_rightAI_residuals.nii.gz"

set output_rightAI_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_mc_stateEmp_painUnpleasant = "${output_dir}/3dMVM_Groupmc_stateEmp_painUnpleasant_patternsim-pain_rightAI_residuals.nii.gz"

set output_rightAI_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_rightAI.nii.gz"
set resid_rightAI_mc_stateEmp_painRating = "${output_dir}/3dMVM_Groupmc_stateEmp_painRating_patternsim-pain_rightAI_residuals.nii.gz"

if ( ! -d "$output_dir" ) then
    mkdir -p "$output_dir"
endif

# Create the data table for 3dMVM
cat << EOF > ${output_dir}/3dMVM_table_patternsim-pain_dACC.txt
Subj   GroupID   mc_loneliness_mean_T2   mc_traitEmpathyIRI_EC_mean_T2   mc_traitEmpathyIRI_PT_mean_T2   mc_stateEmp_fear   mc_stateEmp_painUnpleasant   mc_stateEmp_painRating   InputFile
001    LKM        -0.23981481              0.05555556                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
002    PMR         0.21018519              0.76984127                     -0.04497354                     -1.2407407         -0.96296296                   0.1203704               "${dACC_dir}/sub-002_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
003    PMR         0.51018519              0.34126984                      0.09788360                      0.7592593          0.03703704                  -0.8796296               "${dACC_dir}/sub-003_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
004    PMR         0.06018519              0.05555556                     -1.47354497                     -0.2407407          0.03703704                   0.1203704               "${dACC_dir}/sub-004_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
005    PMR        -0.13981481              0.62698413                      0.52645503                      0.7592593          1.03703704                   0.1203704               "${dACC_dir}/sub-005_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
006    PMR        -0.23981481             -1.37301587                     -0.47354497                      0.7592593          1.03703704                  -0.3796296               "${dACC_dir}/sub-006_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
007    PMR        -0.68981481              0.76984127                      0.81216931                      0.7592593          1.03703704                   0.1203704               "${dACC_dir}/sub-007_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
008    LKM         0.11018519             -0.80158730                     -0.61640212                      0.7592593          0.03703704                  -1.8796296               "${dACC_dir}/sub-008_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
014    LKM         0.51018519             -0.08730159                     -0.04497354                     -0.2407407          0.03703704                   0.1203704               "${dACC_dir}/sub-014_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
018    LKM        -0.13981481              0.62698413                     -0.33068783                      0.7592593          1.03703704                   1.1203704               "${dACC_dir}/sub-018_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
031    PMR        -0.18981481              0.19841270                      0.81216931                     -0.2407407          1.03703704                   1.1203704               "${dACC_dir}/sub-031_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
034    LKM        -0.63981481              0.76984127                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${dACC_dir}/sub-034_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
039    PMR        -0.73981481             -0.37301587                     -1.04497354                     -0.2407407         -1.96296296                  -0.8796296               "${dACC_dir}/sub-039_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
043    PMR         0.26018519              0.34126984                      0.09788360                     -0.2407407          0.03703704                   1.1203704               "${dACC_dir}/sub-043_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
050    LKM         0.61018519              0.34126984                     -0.75925926                     -0.2407407          0.03703704                  -0.3796296               "${dACC_dir}/sub-050_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
052    PMR        -0.48981481              0.62698413                     -1.04497354                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-052_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
053    LKM        -0.18981481              0.34126984                     -1.18783069                     -0.2407407          0.03703704                   0.1203704               "${dACC_dir}/sub-053_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
057    PMR        -0.33981481              0.19841270                     -0.18783069                     -1.2407407          0.03703704                  -0.8796296               "${dACC_dir}/sub-057_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
058    PMR        -0.58981481              0.62698413                      0.38359788                      0.7592593          1.03703704                   1.1203704               "${dACC_dir}/sub-058_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
063    LKM        -0.58981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                  -0.8796296               "${dACC_dir}/sub-063_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
064    PMR        -0.53981481              0.19841270                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${dACC_dir}/sub-064_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
067    PMR         0.21018519             -0.23015873                      0.24074074                     -1.2407407          0.03703704                   1.1203704               "${dACC_dir}/sub-067_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
071    LKM         0.06018519             -0.37301587                     -0.75925926                     -1.2407407          0.03703704                  -0.8796296               "${dACC_dir}/sub-071_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
074    PMR        -0.33981481             -0.51587302                     -0.61640212                      0.7592593         -0.96296296                   0.1203704               "${dACC_dir}/sub-074_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
075    PMR        -0.58981481              0.05555556                      0.52645503                     -0.2407407          0.03703704                  -0.8796296               "${dACC_dir}/sub-075_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
076    PMR         0.46018519              0.62698413                     -0.18783069                     -0.2407407          0.03703704                   0.1203704               "${dACC_dir}/sub-076_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
081    LKM         0.76018519              0.62698413                      1.09788360                      0.7592593          1.03703704                   1.1203704               "${dACC_dir}/sub-081_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
088    LKM        -0.08981481              0.48412698                      0.52645503                      0.7592593          1.03703704                  -0.8796296               "${dACC_dir}/sub-088_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
102    LKM         0.61018519              0.62698413                      0.81216931                      0.04444444        -3.2407407                   -2.96296296              "${dACC_dir}/sub-102_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
106    LKM         0.46018519             -0.23015873                     -0.47354497                     -1.2407407          0.03703704                  -0.8796296               "${dACC_dir}/sub-106_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
109    LKM         0.11018519             -0.94444444                     -1.33068783                     -0.55555556         0.7592593                   -0.96296296              "${dACC_dir}/sub-109_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
115    LKM         0.71018519             -0.08730159                      0.09788360                      0.24444444        -2.1111111                    0.7592593               "${dACC_dir}/sub-115_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
119    LKM         0.51018519              0.05555556                     -0.33068783                     -0.2407407          1.03703704                  -0.8796296               "${dACC_dir}/sub-119_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
122    LKM        -0.03981481             -1.23015873                     -0.75925926                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-122_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
130    LKM         0.01018519             -1.08730159                     -0.61640212                     -0.2407407          1.03703704                   0.1203704               "${dACC_dir}/sub-130_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
136    LKM        -0.13981481              0.05555556                     -0.18783069                      0.7592593          0.03703704                  -0.8796296               "${dACC_dir}/sub-136_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
139    LKM         0.31018519             -0.37301587                     -0.47354497                     -1.2407407         -1.96296296                  -0.8796296               "${dACC_dir}/sub-139_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
149    LKM        -0.83981481              0.62698413                      0.81216931                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-149_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
154    LKM         0.31018519             -1.37301587                     -0.47354497                     -1.2407407         -0.96296296                   0.1203704               "${dACC_dir}/sub-154_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
156    PMR        -0.43981481              0.34126984                      0.95502646                      0.7592593          1.03703704                  -0.3796296               "${dACC_dir}/sub-156_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
158    LKM        -0.23981481             -0.51587302                     -0.47354497                      0.7592593          0.03703704                   1.1203704               "${dACC_dir}/sub-158_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
159    PMR        -0.13981481             -0.80158730                     -0.18783069                      0.7592593          0.03703704                   1.1203704               "${dACC_dir}/sub-159_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
167    PMR        -0.03981481              0.91269841                      0.81216931                     -0.2407407         -0.96296296                  -1.8796296               "${dACC_dir}/sub-167_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
169    LKM        -0.38981481             -0.08730159                     -0.04497354                     -0.55555556         0.8888889                    0.7592593               "${dACC_dir}/sub-169_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
179    PMR         0.51018519             -0.51587302                     -0.04497354                     -1.2407407          0.03703704                  -0.8796296               "${dACC_dir}/sub-179_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
180    LKM         0.26018519             -0.23015873                     -0.47354497                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-180_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
187    PMR        -0.03981481             -0.37301587                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-187_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
191    LKM         0.36018519              0.91269841                      0.38359788                     -2.2407407         -0.96296296                   1.1203704               "${dACC_dir}/sub-191_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
192    PMR         0.16018519             -0.37301587                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${dACC_dir}/sub-192_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
193    LKM         0.56018519             -0.23015873                      1.09788360                     -1.2407407         -1.96296296                   0.1203704               "${dACC_dir}/sub-193_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
194    PMR        -0.18981481             -0.23015873                      0.66931217                     -1.2407407         -0.96296296                   1.1203704               "${dACC_dir}/sub-194_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
195    LKM        -0.18981481              0.05555556                      0.24074074                      0.7592593          0.03703704                  -0.8796296               "${dACC_dir}/sub-195_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
196    PMR         0.91018519              0.62698413                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${dACC_dir}/sub-196_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
197    LKM        -0.08981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                   0.1203704               "${dACC_dir}/sub-197_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
EOF

cat << EOF > ${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt
Subj   GroupID   mc_loneliness_mean_T2   mc_traitEmpathyIRI_EC_mean_T2   mc_traitEmpathyIRI_PT_mean_T2   mc_stateEmp_fear   mc_stateEmp_painUnpleasant   mc_stateEmp_painRating   InputFile
001    LKM        -0.23981481              0.05555556                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
002    PMR         0.21018519              0.76984127                     -0.04497354                     -1.2407407         -0.96296296                   0.1203704               "${leftAI_dir}/sub-002_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
003    PMR         0.51018519              0.34126984                      0.09788360                      0.7592593          0.03703704                  -0.8796296               "${leftAI_dir}/sub-003_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
004    PMR         0.06018519              0.05555556                     -1.47354497                     -0.2407407          0.03703704                   0.1203704               "${leftAI_dir}/sub-004_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
005    PMR        -0.13981481              0.62698413                      0.52645503                      0.7592593          1.03703704                   0.1203704               "${leftAI_dir}/sub-005_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
006    PMR        -0.23981481             -1.37301587                     -0.47354497                      0.7592593          1.03703704                  -0.3796296               "${leftAI_dir}/sub-006_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
007    PMR        -0.68981481              0.76984127                      0.81216931                      0.7592593          1.03703704                   0.1203704               "${leftAI_dir}/sub-007_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
008    LKM         0.11018519             -0.80158730                     -0.61640212                      0.7592593          0.03703704                  -1.8796296               "${leftAI_dir}/sub-008_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
014    LKM         0.51018519             -0.08730159                     -0.04497354                     -0.2407407          0.03703704                   0.1203704               "${leftAI_dir}/sub-014_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
018    LKM        -0.13981481              0.62698413                     -0.33068783                      0.7592593          1.03703704                   1.1203704               "${leftAI_dir}/sub-018_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
031    PMR        -0.18981481              0.19841270                      0.81216931                     -0.2407407          1.03703704                   1.1203704               "${leftAI_dir}/sub-031_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
034    LKM        -0.63981481              0.76984127                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${leftAI_dir}/sub-034_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
039    PMR        -0.73981481             -0.37301587                     -1.04497354                     -0.2407407         -1.96296296                  -0.8796296               "${leftAI_dir}/sub-039_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
043    PMR         0.26018519              0.34126984                      0.09788360                     -0.2407407          0.03703704                   1.1203704               "${leftAI_dir}/sub-043_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
050    LKM         0.61018519              0.34126984                     -0.75925926                     -0.2407407          0.03703704                  -0.3796296               "${leftAI_dir}/sub-050_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
052    PMR        -0.48981481              0.62698413                     -1.04497354                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-052_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
053    LKM        -0.18981481              0.34126984                     -1.18783069                     -0.2407407          0.03703704                   0.1203704               "${leftAI_dir}/sub-053_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
057    PMR        -0.33981481              0.19841270                     -0.18783069                     -1.2407407          0.03703704                  -0.8796296               "${leftAI_dir}/sub-057_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
058    PMR        -0.58981481              0.62698413                      0.38359788                      0.7592593          1.03703704                   1.1203704               "${leftAI_dir}/sub-058_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
063    LKM        -0.58981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                  -0.8796296               "${leftAI_dir}/sub-063_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
064    PMR        -0.53981481              0.19841270                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${leftAI_dir}/sub-064_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
067    PMR         0.21018519             -0.23015873                      0.24074074                     -1.2407407          0.03703704                   1.1203704               "${leftAI_dir}/sub-067_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
071    LKM         0.06018519             -0.37301587                     -0.75925926                     -1.2407407          0.03703704                  -0.8796296               "${leftAI_dir}/sub-071_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
074    PMR        -0.33981481             -0.51587302                     -0.61640212                      0.7592593         -0.96296296                   0.1203704               "${leftAI_dir}/sub-074_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
075    PMR        -0.58981481              0.05555556                      0.52645503                     -0.2407407          0.03703704                  -0.8796296               "${leftAI_dir}/sub-075_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
076    PMR         0.46018519              0.62698413                     -0.18783069                     -0.2407407          0.03703704                   0.1203704               "${leftAI_dir}/sub-076_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
081    LKM         0.76018519              0.62698413                      1.09788360                      0.7592593          1.03703704                   1.1203704               "${leftAI_dir}/sub-081_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
088    LKM        -0.08981481              0.48412698                      0.52645503                      0.7592593          1.03703704                  -0.8796296               "${leftAI_dir}/sub-088_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
102    LKM         0.61018519              0.62698413                      0.81216931                      0.04444444        -3.2407407                   -2.96296296              "${leftAI_dir}/sub-102_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
106    LKM         0.46018519             -0.23015873                     -0.47354497                     -1.2407407          0.03703704                  -0.8796296               "${leftAI_dir}/sub-106_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
109    LKM         0.11018519             -0.94444444                     -1.33068783                     -0.55555556         0.7592593                   -0.96296296              "${leftAI_dir}/sub-109_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
115    LKM         0.71018519             -0.08730159                      0.09788360                      0.24444444        -2.1111111                    0.7592593               "${leftAI_dir}/sub-115_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
119    LKM         0.51018519              0.05555556                     -0.33068783                     -0.2407407          1.03703704                  -0.8796296               "${leftAI_dir}/sub-119_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
122    LKM        -0.03981481             -1.23015873                     -0.75925926                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-122_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
130    LKM         0.01018519             -1.08730159                     -0.61640212                     -0.2407407          1.03703704                   0.1203704               "${leftAI_dir}/sub-130_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
136    LKM        -0.13981481              0.05555556                     -0.18783069                      0.7592593          0.03703704                  -0.8796296               "${leftAI_dir}/sub-136_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
139    LKM         0.31018519             -0.37301587                     -0.47354497                     -1.2407407         -1.96296296                  -0.8796296               "${leftAI_dir}/sub-139_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
149    LKM        -0.83981481              0.62698413                      0.81216931                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-149_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
154    LKM         0.31018519             -1.37301587                     -0.47354497                     -1.2407407         -0.96296296                   0.1203704               "${leftAI_dir}/sub-154_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
156    PMR        -0.43981481              0.34126984                      0.95502646                      0.7592593          1.03703704                  -0.3796296               "${leftAI_dir}/sub-156_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
158    LKM        -0.23981481             -0.51587302                     -0.47354497                      0.7592593          0.03703704                   1.1203704               "${leftAI_dir}/sub-158_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
159    PMR        -0.13981481             -0.80158730                     -0.18783069                      0.7592593          0.03703704                   1.1203704               "${leftAI_dir}/sub-159_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
167    PMR        -0.03981481              0.91269841                      0.81216931                     -0.2407407         -0.96296296                  -1.8796296               "${leftAI_dir}/sub-167_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
169    LKM        -0.38981481             -0.08730159                     -0.04497354                     -0.55555556         0.8888889                    0.7592593               "${leftAI_dir}/sub-169_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
179    PMR         0.51018519             -0.51587302                     -0.04497354                     -1.2407407          0.03703704                  -0.8796296               "${leftAI_dir}/sub-179_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
180    LKM         0.26018519             -0.23015873                     -0.47354497                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-180_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
187    PMR        -0.03981481             -0.37301587                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-187_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
191    LKM         0.36018519              0.91269841                      0.38359788                     -2.2407407         -0.96296296                   1.1203704               "${leftAI_dir}/sub-191_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
192    PMR         0.16018519             -0.37301587                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${leftAI_dir}/sub-192_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
193    LKM         0.56018519             -0.23015873                      1.09788360                     -1.2407407         -1.96296296                   0.1203704               "${leftAI_dir}/sub-193_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
194    PMR        -0.18981481             -0.23015873                      0.66931217                     -1.2407407         -0.96296296                   1.1203704               "${leftAI_dir}/sub-194_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
195    LKM        -0.18981481              0.05555556                      0.24074074                      0.7592593          0.03703704                  -0.8796296               "${leftAI_dir}/sub-195_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
196    PMR         0.91018519              0.62698413                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${leftAI_dir}/sub-196_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
197    LKM        -0.08981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                   0.1203704               "${leftAI_dir}/sub-197_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
EOF

cat << EOF > ${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt
Subj   GroupID   mc_loneliness_mean_T2   mc_traitEmpathyIRI_EC_mean_T2   mc_traitEmpathyIRI_PT_mean_T2   mc_stateEmp_fear   mc_stateEmp_painUnpleasant   mc_stateEmp_painRating   InputFile
001    LKM        -0.23981481              0.05555556                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
002    PMR         0.21018519              0.76984127                     -0.04497354                     -1.2407407         -0.96296296                   0.1203704               "${rightAI_dir}/sub-002_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
003    PMR         0.51018519              0.34126984                      0.09788360                      0.7592593          0.03703704                  -0.8796296               "${rightAI_dir}/sub-003_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
004    PMR         0.06018519              0.05555556                     -1.47354497                     -0.2407407          0.03703704                   0.1203704               "${rightAI_dir}/sub-004_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
005    PMR        -0.13981481              0.62698413                      0.52645503                      0.7592593          1.03703704                   0.1203704               "${rightAI_dir}/sub-005_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
006    PMR        -0.23981481             -1.37301587                     -0.47354497                      0.7592593          1.03703704                  -0.3796296               "${rightAI_dir}/sub-006_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
007    PMR        -0.68981481              0.76984127                      0.81216931                      0.7592593          1.03703704                   0.1203704               "${rightAI_dir}/sub-007_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
008    LKM         0.11018519             -0.80158730                     -0.61640212                      0.7592593          0.03703704                  -1.8796296               "${rightAI_dir}/sub-008_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
014    LKM         0.51018519             -0.08730159                     -0.04497354                     -0.2407407          0.03703704                   0.1203704               "${rightAI_dir}/sub-014_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
018    LKM        -0.13981481              0.62698413                     -0.33068783                      0.7592593          1.03703704                   1.1203704               "${rightAI_dir}/sub-018_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
031    PMR        -0.18981481              0.19841270                      0.81216931                     -0.2407407          1.03703704                   1.1203704               "${rightAI_dir}/sub-031_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
034    LKM        -0.63981481              0.76984127                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${rightAI_dir}/sub-034_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
039    PMR        -0.73981481             -0.37301587                     -1.04497354                     -0.2407407         -1.96296296                  -0.8796296               "${rightAI_dir}/sub-039_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
043    PMR         0.26018519              0.34126984                      0.09788360                     -0.2407407          0.03703704                   1.1203704               "${rightAI_dir}/sub-043_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
050    LKM         0.61018519              0.34126984                     -0.75925926                     -0.2407407          0.03703704                  -0.3796296               "${rightAI_dir}/sub-050_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
052    PMR        -0.48981481              0.62698413                     -1.04497354                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-052_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
053    LKM        -0.18981481              0.34126984                     -1.18783069                     -0.2407407          0.03703704                   0.1203704               "${rightAI_dir}/sub-053_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
057    PMR        -0.33981481              0.19841270                     -0.18783069                     -1.2407407          0.03703704                  -0.8796296               "${rightAI_dir}/sub-057_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
058    PMR        -0.58981481              0.62698413                      0.38359788                      0.7592593          1.03703704                   1.1203704               "${rightAI_dir}/sub-058_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
063    LKM        -0.58981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                  -0.8796296               "${rightAI_dir}/sub-063_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
064    PMR        -0.53981481              0.19841270                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${rightAI_dir}/sub-064_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
067    PMR         0.21018519             -0.23015873                      0.24074074                     -1.2407407          0.03703704                   1.1203704               "${rightAI_dir}/sub-067_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
071    LKM         0.06018519             -0.37301587                     -0.75925926                     -1.2407407          0.03703704                  -0.8796296               "${rightAI_dir}/sub-071_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
074    PMR        -0.33981481             -0.51587302                     -0.61640212                      0.7592593         -0.96296296                   0.1203704               "${rightAI_dir}/sub-074_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
075    PMR        -0.58981481              0.05555556                      0.52645503                     -0.2407407          0.03703704                  -0.8796296               "${rightAI_dir}/sub-075_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
076    PMR         0.46018519              0.62698413                     -0.18783069                     -0.2407407          0.03703704                   0.1203704               "${rightAI_dir}/sub-076_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
081    LKM         0.76018519              0.62698413                      1.09788360                      0.7592593          1.03703704                   1.1203704               "${rightAI_dir}/sub-081_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
088    LKM        -0.08981481              0.48412698                      0.52645503                      0.7592593          1.03703704                  -0.8796296               "${rightAI_dir}/sub-088_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
102    LKM         0.61018519              0.62698413                      0.81216931                      0.04444444        -3.2407407                   -2.96296296              "${rightAI_dir}/sub-102_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
106    LKM         0.46018519             -0.23015873                     -0.47354497                     -1.2407407          0.03703704                  -0.8796296               "${rightAI_dir}/sub-106_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
109    LKM         0.11018519             -0.94444444                     -1.33068783                     -0.55555556         0.7592593                   -0.96296296              "${rightAI_dir}/sub-109_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
115    LKM         0.71018519             -0.08730159                      0.09788360                      0.24444444        -2.1111111                    0.7592593               "${rightAI_dir}/sub-115_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
119    LKM         0.51018519              0.05555556                     -0.33068783                     -0.2407407          1.03703704                  -0.8796296               "${rightAI_dir}/sub-119_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
122    LKM        -0.03981481             -1.23015873                     -0.75925926                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-122_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
130    LKM         0.01018519             -1.08730159                     -0.61640212                     -0.2407407          1.03703704                   0.1203704               "${rightAI_dir}/sub-130_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
136    LKM        -0.13981481              0.05555556                     -0.18783069                      0.7592593          0.03703704                  -0.8796296               "${rightAI_dir}/sub-136_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
139    LKM         0.31018519             -0.37301587                     -0.47354497                     -1.2407407         -1.96296296                  -0.8796296               "${rightAI_dir}/sub-139_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
149    LKM        -0.83981481              0.62698413                      0.81216931                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-149_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
154    LKM         0.31018519             -1.37301587                     -0.47354497                     -1.2407407         -0.96296296                   0.1203704               "${rightAI_dir}/sub-154_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
156    PMR        -0.43981481              0.34126984                      0.95502646                      0.7592593          1.03703704                  -0.3796296               "${rightAI_dir}/sub-156_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
158    LKM        -0.23981481             -0.51587302                     -0.47354497                      0.7592593          0.03703704                   1.1203704               "${rightAI_dir}/sub-158_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
159    PMR        -0.13981481             -0.80158730                     -0.18783069                      0.7592593          0.03703704                   1.1203704               "${rightAI_dir}/sub-159_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
167    PMR        -0.03981481              0.91269841                      0.81216931                     -0.2407407         -0.96296296                  -1.8796296               "${rightAI_dir}/sub-167_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
169    LKM        -0.38981481             -0.08730159                     -0.04497354                     -0.55555556         0.8888889                    0.7592593               "${rightAI_dir}/sub-169_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
179    PMR         0.51018519             -0.51587302                     -0.04497354                     -1.2407407          0.03703704                  -0.8796296               "${rightAI_dir}/sub-179_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
180    LKM         0.26018519             -0.23015873                     -0.47354497                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-180_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
187    PMR        -0.03981481             -0.37301587                     -0.04497354                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-187_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
191    LKM         0.36018519              0.91269841                      0.38359788                     -2.2407407         -0.96296296                   1.1203704               "${rightAI_dir}/sub-191_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
192    PMR         0.16018519             -0.37301587                      0.24074074                      0.7592593          0.03703704                   1.1203704               "${rightAI_dir}/sub-192_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
193    LKM         0.56018519             -0.23015873                      1.09788360                     -1.2407407         -1.96296296                   0.1203704               "${rightAI_dir}/sub-193_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
194    PMR        -0.18981481             -0.23015873                      0.66931217                     -1.2407407         -0.96296296                   1.1203704               "${rightAI_dir}/sub-194_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
195    LKM        -0.18981481              0.05555556                      0.24074074                      0.7592593          0.03703704                  -0.8796296               "${rightAI_dir}/sub-195_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
196    PMR         0.91018519              0.62698413                      0.52645503                     -0.2407407          1.03703704                   0.1203704               "${rightAI_dir}/sub-196_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
197    LKM        -0.08981481             -0.23015873                      1.09788360                      0.7592593          0.03703704                   0.1203704               "${rightAI_dir}/sub-197_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD"
EOF

# Run 3dMVM for Loneliness with dACC Mask
3dMVM -prefix $output_dACC_loneliness \
      -resid $resid_dACC_loneliness \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_loneliness_mean_T2" \
      -qVars "mc_loneliness_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "Loneliness" -gltCode 2 'mc_loneliness_mean_T2 :' \
      -gltLabel 3 "Loneliness_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_loneliness_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for EC with dACC Mask
3dMVM -prefix $output_dACC_EC \
      -resid $resid_dACC_EC \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_EC_mean_T2" \
      -qVars "mc_traitEmpathyIRI_EC_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "EC" -gltCode 2 'mc_traitEmpathyIRI_EC_mean_T2 :' \
      -gltLabel 3 "EC_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_EC_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for PT with dACC Mask
3dMVM -prefix $output_dACC_PT \
      -resid $resid_dACC_PT \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_PT_mean_T2" \
      -qVars "mc_traitEmpathyIRI_PT_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "PT" -gltCode 2 'mc_traitEmpathyIRI_PT_mean_T2 :' \
      -gltLabel 3 "PT_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_PT_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for mc_stateEmp_fear with dACC Mask
3dMVM -prefix $output_dACC_mc_stateEmp_fear \
      -resid $resid_dACC_mc_stateEmp_fear \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_fear" \
      -qVars "mc_stateEmp_fear" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_fear" -gltCode 2 'mc_stateEmp_fear :' \
      -gltLabel 3 "mc_stateEmp_fear_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_fear :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for mc_stateEmp_painUnpleasant with dACC Mask
3dMVM -prefix $output_dACC_mc_stateEmp_painUnpleasant \
      -resid $resid_dACC_mc_stateEmp_painUnpleasant \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painUnpleasant" \
      -qVars "mc_stateEmp_painUnpleasant" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painUnpleasant" -gltCode 2 'mc_stateEmp_painUnpleasant :' \
      -gltLabel 3 "mc_stateEmp_painUnpleasant_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painUnpleasant :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for mc_stateEmp_painRating with dACC Mask
3dMVM -prefix $output_dACC_mc_stateEmp_painRating \
      -resid $resid_dACC_mc_stateEmp_painRating \
      -mask $mask_dACC \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painRating" \
      -qVars "mc_stateEmp_painRating" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painRating" -gltCode 2 'mc_stateEmp_painRating :' \
      -gltLabel 3 "mc_stateEmp_painRating_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painRating :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_dACC.txt

# Run 3dMVM for Loneliness with leftAI Mask
3dMVM -prefix $output_leftAI_loneliness \
      -resid $resid_leftAI_loneliness \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_loneliness_mean_T2" \
      -qVars "mc_loneliness_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "Loneliness" -gltCode 2 'mc_loneliness_mean_T2 :' \
      -gltLabel 3 "Loneliness_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_loneliness_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for EC with leftAI Mask
3dMVM -prefix $output_leftAI_EC \
      -resid $resid_leftAI_EC \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_EC_mean_T2" \
      -qVars "mc_traitEmpathyIRI_EC_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "EC" -gltCode 2 'mc_traitEmpathyIRI_EC_mean_T2 :' \
      -gltLabel 3 "EC_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_EC_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for PT with leftAI Mask
3dMVM -prefix $output_leftAI_PT \
      -resid $resid_leftAI_PT \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_PT_mean_T2" \
      -qVars "mc_traitEmpathyIRI_PT_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "PT" -gltCode 2 'mc_traitEmpathyIRI_PT_mean_T2 :' \
      -gltLabel 3 "PT_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_PT_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for mc_stateEmp_fear with leftAI Mask
3dMVM -prefix $output_leftAI_mc_stateEmp_fear \
      -resid $resid_leftAI_mc_stateEmp_fear \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_fear" \
      -qVars "mc_stateEmp_fear" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_fear" -gltCode 2 'mc_stateEmp_fear :' \
      -gltLabel 3 "mc_stateEmp_fear_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_fear :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for mc_stateEmp_painUnpleasant with leftAI Mask
3dMVM -prefix $output_leftAI_mc_stateEmp_painUnpleasant \
      -resid $resid_leftAI_mc_stateEmp_painUnpleasant \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painUnpleasant" \
      -qVars "mc_stateEmp_painUnpleasant" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painUnpleasant" -gltCode 2 'mc_stateEmp_painUnpleasant :' \
      -gltLabel 3 "mc_stateEmp_painUnpleasant_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painUnpleasant :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for mc_stateEmp_painRating with leftAI Mask
3dMVM -prefix $output_leftAI_mc_stateEmp_painRating \
      -resid $resid_leftAI_mc_stateEmp_painRating \
      -mask $mask_leftAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painRating" \
      -qVars "mc_stateEmp_painRating" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painRating" -gltCode 2 'mc_stateEmp_painRating :' \
      -gltLabel 3 "mc_stateEmp_painRating_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painRating :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_leftAI.txt

# Run 3dMVM for Loneliness with rightAI Mask    
3dMVM -prefix $output_rightAI_loneliness \
      -resid $resid_rightAI_loneliness \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_loneliness_mean_T2" \
      -qVars "mc_loneliness_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "Loneliness" -gltCode 2 'mc_loneliness_mean_T2 :' \
      -gltLabel 3 "Loneliness_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_loneliness_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt

# Run 3dMVM for EC with rightAI Mask
3dMVM -prefix $output_rightAI_EC \
      -resid $resid_rightAI_EC \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_EC_mean_T2" \
      -qVars "mc_traitEmpathyIRI_EC_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "EC" -gltCode 2 'mc_traitEmpathyIRI_EC_mean_T2 :' \
      -gltLabel 3 "EC_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_EC_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt

# Run 3dMVM for PT with rightAI Mask
3dMVM -prefix $output_rightAI_PT \
      -resid $resid_rightAI_PT \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_traitEmpathyIRI_PT_mean_T2" \
      -qVars "mc_traitEmpathyIRI_PT_mean_T2" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "PT" -gltCode 2 'mc_traitEmpathyIRI_PT_mean_T2 :' \
      -gltLabel 3 "PT_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_traitEmpathyIRI_PT_mean_T2 :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt

# Run 3dMVM for mc_stateEmp_fear with rightAI Mask
3dMVM -prefix $output_rightAI_mc_stateEmp_fear \
      -resid $resid_rightAI_mc_stateEmp_fear \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_fear" \
      -qVars "mc_stateEmp_fear" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_fear" -gltCode 2 'mc_stateEmp_fear :' \
      -gltLabel 3 "mc_stateEmp_fear_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_fear :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt

# Run 3dMVM for mc_stateEmp_painUnpleasant with rightAI Mask
3dMVM -prefix $output_rightAI_mc_stateEmp_painUnpleasant \
      -resid $resid_rightAI_mc_stateEmp_painUnpleasant \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painUnpleasant" \
      -qVars "mc_stateEmp_painUnpleasant" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painUnpleasant" -gltCode 2 'mc_stateEmp_painUnpleasant :' \
      -gltLabel 3 "mc_stateEmp_painUnpleasant_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painUnpleasant :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt

# Run 3dMVM for mc_stateEmp_painRating with rightAI Mask
3dMVM -prefix $output_rightAI_mc_stateEmp_painRating \
      -resid $resid_rightAI_mc_stateEmp_painRating \
      -mask $mask_rightAI \
      -jobs 4 \
      -bsVars "GroupID*mc_stateEmp_painRating" \
      -qVars "mc_stateEmp_painRating" \
      -num_glt 3 \
      -gltLabel 1 "LKM_vs_PMR" -gltCode 1 'GroupID : 1*LKM -1*PMR' \
      -gltLabel 2 "mc_stateEmp_painRating" -gltCode 2 'mc_stateEmp_painRating :' \
      -gltLabel 3 "mc_stateEmp_painRating_Interaction" -gltCode 3 'GroupID : 1*LKM -1*PMR mc_stateEmp_painRating :' \
      -dataTable @${output_dir}/3dMVM_table_patternsim-pain_rightAI.txt