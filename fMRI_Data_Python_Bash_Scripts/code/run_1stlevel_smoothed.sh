#!/bin/bash

# This script runs the first-level GLM analysis for the empathy task
# Last updated by MD: (November 19, 2024)
# Usage: ./run_1stlevel_smoothed.sh -s 031

usage() { echo "Usage: $0 [-s <subID>]" 1>&2; exit 1; }

while getopts ":s:" option; do
    case "${option}" in
        s)
            SUBID=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${SUBID}" ]; then
    usage
fi

echo $SUBID

# Set common parameters
task_id=empathy
INPUT_PATH=/my/path/fMRIData
OUTPUT_PATH=/my/path/fMRIData/1stlevel_glm

# Create directories for each subject
mkdir -p ${OUTPUT_PATH}/sub-${SUBID}/preproc/sub-${SUBID}

# Loop through conditions
for condition in self other; do
    glm_id=${condition}

    # Determine the run index based on the condition
    if [ "${condition}" == "self" ]; then
        runs=(1)
    elif [ "${condition}" == "other" ]; then
        runs=(2)
    fi

    # Loop through the specified run for the GLM analysis
    for run in "${runs[@]}"; do
        run_index=$(printf "%02d" $run)  # Format run index as two digits

        # SCALE AND SMOOTH
        3dTstat -prefix ${OUTPUT_PATH}/sub-${SUBID}/preproc/sub-${SUBID}_task-empathy_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_mean.nii.gz -overwrite "/my/path/fMRIData/subjects/derivatives/sub-${SUBID}/func/sub-${SUBID}_task-empathy_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_bold_smoothed+tlrc[3..292]" # calculate the mean
        3dcalc -a "/my/path/fMRIData/subjects/derivatives/sub-${SUBID}/func/sub-${SUBID}_task-empathy_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_bold_smoothed+tlrc[3..292]" -b ${OUTPUT_PATH}/sub-${SUBID}/preproc/sub-${SUBID}_task-empathy_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_mean.nii.gz -expr 'min(200, a/b*100)*step(a)*step(b)' -prefix ${OUTPUT_PATH}/sub-${SUBID}/preproc/sub-${SUBID}_task-empathy_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled_smoothed.nii.gz -overwrite # scale the data using the mean

        # FIRSTLEVEL GLM for each run and condition
        3dDeconvolve \
            -overwrite \
            -jobs 6 \
            -input ${OUTPUT_PATH}/sub-${SUBID}/preproc/sub-${SUBID}_task-${task_id}_run-${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled_smoothed.nii.gz \
            -polort A \
            -num_stimts 14 \
            -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}pain.txt 'dmBLOCK' -stim_label 1 "${condition}_pain" \
            -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}nopain.txt 'dmBLOCK' -stim_label 2 "${condition}_no_pain" \
            -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}painpaincue.txt 'dmBLOCK' -stim_label 3 "${condition}_pain_cue" \
            -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}neutralcue.txt 'dmBLOCK' -stim_label 4 "${condition}_neutral_cue" \
            -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}painanticipation.txt 'dmBLOCK' -stim_label 5 "${condition}_pain_anticipation" \
            -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_timing-${condition}neutralanticipation.txt 'dmBLOCK' -stim_label 6 "${condition}_neutral_anticipation" \
            -stim_file 7 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
            -stim_file 8 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
            -stim_file 9 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
            -stim_file 10 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
            -stim_file 11 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
            -stim_file 12 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
            -stim_file 13 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
            -stim_file 14 "${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
            -tout -rout \
            -num_glt 3 \
            -glt_label 1 ${condition}_pain-${condition}_no_pain \
            -gltsym "SYM: +${condition}_pain[0] -${condition}_no_pain[0]" \
            -glt_label 2 ${condition}_no_pain-${condition}_pain \
            -gltsym "SYM: -${condition}_pain[0] +${condition}_no_pain[0]" \
            -glt_label 3 ${condition}_pain_anticipation-${condition}_neutral_anticipation \
            -gltsym "SYM: +${condition}_pain_anticipation[0] -${condition}_neutral_anticipation[0]" \
            -censor ${INPUT_PATH}/events/sub-${SUBID}/regressors/sub-${SUBID}_task-${task_id}_run-${run_index}_outliers.txt \
            -x1D ${OUTPUT_PATH}/sub-${SUBID}/sub-${SUBID}_task-${task_id}_glm-${glm_id}_space-MNI152NLin2009cAsym_smoothed_univariate_xmat.1D \
            -bucket ${OUTPUT_PATH}/sub-${SUBID}/sub-${SUBID}_task-${task_id}_glm-${glm_id}_space-MNI152NLin2009cAsym_smoothed_univariate_stats.nii.gz \

    done  # End of loop over runs
done  # End of loop over conditions