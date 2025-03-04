# This script is based on a script by Shawn Rhoads (social faces task) but adapted for empathic pain task (mind and life)
# Purpose: Run 3dLSS for each condition and run separately so we can use these LSS matrices as input when we run multivariate pattern analysis (MVPA) in another script using decoding toolbox in matlab. 
# Last modified by: Marla Dressel 2024-09-19


#/bin/bash
# ./run-3dLSS.sh -s 'sub-001' -c 'selfpain'
#subject_id='sub-001'
#cond_id='selfpain'

# Initialize options
usage() { echo "Invalid option: $0 [-s <Subject ID> -t <Task ID> -c <Condition ID> -r <Run ID> -i <Run Index>]" 1>&2; exit 1; }
while getopts ":s:c:" option; do
	case "${option}" in
		s)
			subject_id=${OPTARG}
			;;
		c)
			cond_id=${OPTARG}
			;;
		*) 
			usage
			;;
	esac
done
shift "$((OPTIND-1))"

task_id=empathy
INPUT_PATH=/my/path/fMRIData
OUTPUT_PATH=/my/path/fMRIData/mvpa/3dLSS
this_space=MNI152NLin2009cAsym

############ SELF ############       

if [ ${cond_id} == 'selfpain' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_IM 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop


elif [ ${cond_id} == 'selfnopain' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_IM 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'selfpaincue' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_IM 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'selfneutralcue' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_IM 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'selfpainanticipation' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_IM 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'selfneutralanticipation' ]; then
    run_index=1
    glm_id=self
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpain.txt 'dmBLOCK' -stim_label 1 "self_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfnopain.txt 'dmBLOCK' -stim_label 2 "self_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainpaincue.txt 'dmBLOCK' -stim_label 3 "self_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralcue.txt 'dmBLOCK' -stim_label 4 "self_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfpainanticipation.txt 'dmBLOCK' -stim_label 5 "self_pain_anticipation" \
        -stim_times_IM 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-selfneutralanticipation.txt 'dmBLOCK' -stim_label 6 "self_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop


############ OTHER ############       

elif [ ${cond_id} == 'otherpain' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_IM 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop


elif [ ${cond_id} == 'othernopain' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_IM 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'otherpaincue' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_IM 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'otherneutralcue' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_IM 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'otherpainanticipation' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_IM 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_AM1 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop

elif [ ${cond_id} == 'otherneutralanticipation' ]; then
    run_index=2
    glm_id=other
    # FIRSTLEVEL GLM for each run and condition
    3dDeconvolve \
        -overwrite \
        -jobs 6 \
        -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
        -polort A \
        -num_stimts 14 \
        -stim_times_AM1 1 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpain.txt 'dmBLOCK' -stim_label 1 "other_pain" \
        -stim_times_AM1 2 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-othernopain.txt 'dmBLOCK' -stim_label 2 "other_no_pain" \
        -stim_times_AM1 3 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainpaincue.txt 'dmBLOCK' -stim_label 3 "other_pain_cue" \
        -stim_times_AM1 4 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralcue.txt 'dmBLOCK' -stim_label 4 "other_neutral_cue" \
        -stim_times_AM1 5 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherpainanticipation.txt 'dmBLOCK' -stim_label 5 "other_pain_anticipation" \
        -stim_times_IM 6 ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_timing-otherneutralanticipation.txt 'dmBLOCK' -stim_label 6 "other_neutral_anticipation" \
        -stim_file 7 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[0]" -stim_base 7 -stim_label 7 csf \
        -stim_file 8 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[1]" -stim_base 8 -stim_label 8 white_matter \
        -stim_file 9 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[2]" -stim_base 9 -stim_label 9 rot_x \
        -stim_file 10 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[3]" -stim_base 10 -stim_label 10 rot_y \
        -stim_file 11 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[4]" -stim_base 11 -stim_label 11 rot_z \
        -stim_file 12 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[5]" -stim_base 12 -stim_label 12 trans_x \
        -stim_file 13 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[6]" -stim_base 13 -stim_label 13 trans_y \
        -stim_file 14 "${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_confounds.txt[7]" -stim_base 14 -stim_label 14 trans_z \
        -x1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
        -censor ${INPUT_PATH}/events/sub-${subject_id}/regressors/sub-${subject_id}_task-${task_id}_run-0${run_index}_outliers.txt \
        -x1D_stop
fi

mkdir -p ${OUTPUT_PATH}/sub-${subject_id}/

if [[ $cond_id == "selfpain" || $cond_id == "selfnopain" || $cond_id == "selfpaincue" || $cond_id == "selfnopaincue" || $cond_id == "selfpainanticipation" || $cond_id == "selfneutralanticipation" ]]; then
    run_index=1
elif [[ $cond_id == "otherpain" || $cond_id == "othernopain" || $cond_id == "otherpaincue" || $cond_id == "othernopaincue" || $cond_id == "otherpainanticipation" || $cond_id == "otherneutralanticipation" ]]; then
    run_index=2
fi

3dLSS -matrix ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS_xmat.1D \
    -input ${INPUT_PATH}/1stlevel_glm/sub-${subject_id}/preproc/sub-${subject_id}_task-${task_id}_run-0${run_index}_space-MNI152NLin2009cAsym_desc-preproc_scaled.nii.gz \
    -save1D ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_LSS.1D \
    -prefix ${OUTPUT_PATH}/sub-${subject_id}/sub-${subject_id}_task-${task_id}_${cond_id}_space-MNI152NLin2009cAsym_LSS.nii.gz \
    -overwrite
