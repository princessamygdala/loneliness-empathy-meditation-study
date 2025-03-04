#!/bin/bash

# Input files
mask="/my/path/fMRIData/history/ML_masks/mni152.nii.gz"
reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
output_dir="/my/path/fMRIData/masks"

# Output files
output_nii_gz="${output_dir}/mni152_desc-wholebrain_3mm-template_resampled.nii.gz"
output_brik="${output_dir}/mni152_desc-wholebrain_3mm-template_resampled"

# Resample to match the reference image
3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# Convert the resampled NIfTI file to BRIK/HEAD format
3dcopy "$output_nii_gz" "$output_brik"

# # This script resamples the AAL right AI mask to match the resolution of the univariate reference image
# # Input files
# mask="/my/path/fMRIData/code/Right_AI+tlrc"
# reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
# output_dir="/my/path/fMRIData/masks"

# # Output files
# output_nii_gz="${output_dir}/aal2_desc-right-AI_3mm-mask_resampled.nii.gz"
# output_brik="${output_dir}/aal2_desc-right-AI_3mm-mask_resampled"

# # Resample to match the reference image
# 3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# # Convert the resampled NIfTI file to BRIK/HEAD format
# 3dcopy "$output_nii_gz" "$output_brik"

# # This script resamples the AAL left AI mask to match the resolution of the univariate reference image
# # Input files
# mask="/my/path/fMRIData/code/Left_AI+tlrc"
# reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
# output_dir="/my/path/fMRIData/masks"

# # Output files
# output_nii_gz="${output_dir}/aal2_desc-left-AI_3mm-mask_resampled.nii.gz"
# output_brik="${output_dir}/aal2_desc-left-AI_3mm-mask_resampled"

# # Resample to match the reference image
# 3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# # Convert the resampled NIfTI file to BRIK/HEAD format
# 3dcopy "$output_nii_gz" "$output_brik"


# # This script resamples the AAL dACC mask to match the resolution of the univariate reference image
# # Input files
# mask="/my/path/fMRIData/code/aal2_antmidCingulate_anteriorY0+tlrc"
# reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
# output_dir="/my/path/fMRIData/masks"

# # Output files
# output_nii_gz="${output_dir}/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"
# output_brik="${output_dir}/aal2_desc-dACC-anteriorY0_3mm-mask_resampled"

# # Resample to match the reference image
# 3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# # Convert the resampled NIfTI file to BRIK/HEAD format
# 3dcopy "$output_nii_gz" "$output_brik"


# # This script resamples the MNI152NLin2009c-graymatter-thr25_3mm.nii.gz mask to match the resolution of the univariate reference image
# # Input files
# mask="/my/path/fMRIData/code/MNI152NLin2009cAsym_desc-thr25gray3mm_mask.nii"
# reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
# output_dir="/my/path/fMRIData/masks"

# # Output files
# output_nii_gz="${output_dir}/MNI152NLin2009cAsym-desc-graymatter-thr25_3mm-mask_resampled.nii.gz"
# output_brik="${output_dir}/MNI152NLin2009cAsym-desc-graymatter-thr25_3mm-mask_resampled"

# # Resample to match the reference image
# 3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# # Convert the resampled NIfTI file to BRIK/HEAD format
# 3dcopy "$output_nii_gz" "$output_brik"


#######################

# Nov 19, 2024

# # This script resamples the MNI152NLin2009cAsym_desc-brain_mask.nii whole brain mask from SR to match the resolution of the univariate reference image
# # Input files
# mask="/my/path/fMRIData/code/MNI152NLin2009cAsym_desc-brain_mask.nii"
# reference="/my/path/fMRIData/1stlevel_glm/sub-001/sub-001_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
# output_dir="/my/path/fMRIData/masks"

# # Output files
# output_nii_gz="${output_dir}/MNI152NLin2009cAsym_desc-wholebrain-mask_resampled.nii.gz"
# output_brik="${output_dir}/MNI152NLin2009cAsym_desc-wholebrain-mask_resampled"

# # Resample to match the reference image
# 3dresample -master "$reference" -input "$mask" -prefix "$output_nii_gz"

# # Convert the resampled NIfTI file to BRIK/HEAD format
# 3dcopy "$output_nii_gz" "$output_brik"
