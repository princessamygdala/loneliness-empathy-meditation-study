#!/usr/bin/env bash

# This script will extract mean values from 3dMVM maps using binary cluster masks for each subject for each test.
# It will output a CSV file with the following columns: SubjectID, TestName_EffectName, MeanValue.
# Last updated: 2024-12-07 by Marla Dressel

## ------------------------------------------------------------------
## 0) Setup
## ------------------------------------------------------------------
BASE_DIR="/my/path/fMRIData/2ndlevel_glm/3dMVM/clusterized_results_0-001"
OUTPUT_CSV="${BASE_DIR}/all_subject_values.csv"

# We'll store subject-level means in an associative array:
#   key = "SubjectID|TestName_EffectName"
#   val = mean_value
declare -A effect_values

# Keep track of columns (test+effect)
declare -a ALL_COLUMNS

# Keep a global set of subject IDs so we can output them in a consistent order
declare -A GLOBAL_SUBJECTS

## ------------------------------------------------------------------
## 1) get_data_dir_and_master: 
##    figure out data_dir & master_file from the test folder name
## ------------------------------------------------------------------
get_data_dir_and_master() {
    local test_folder="$1"
    local test_name="$(basename "$test_folder")"

    local data_dir=""
    local master_file=""

    # patternsim
    if [[ "$test_name" =~ patternsim-pain ]] && [[ "$test_name" =~ dACC ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain/dACC"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ patternsim-anticipation ]] && [[ "$test_name" =~ dACC ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/anticipation/dACC"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_anticipation_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ patternsim-pain ]] && [[ "$test_name" =~ leftAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain/leftAI"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ patternsim-anticipation ]] && [[ "$test_name" =~ leftAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/anticipation/leftAI"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_anticipation_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ patternsim-pain ]] && [[ "$test_name" =~ rightAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain/rightAI"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ patternsim-anticipation ]] && [[ "$test_name" =~ rightAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/anticipation/rightAI"
        master_file="${data_dir}/sub-001_rsatoolbox_rdm_map_anticipation_smoothed+tlrc.BRIK"

    # decoding
    elif [[ "$test_name" =~ decoding-pain ]] && [[ "$test_name" =~ dACC ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/pain/dACC"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ decoding-anticipation ]] && [[ "$test_name" =~ dACC ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/anticipation/dACC"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ decoding-pain ]] && [[ "$test_name" =~ rightAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/pain/rightAI"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ decoding-anticipation ]] && [[ "$test_name" =~ rightAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/anticipation/rightAI"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ decoding-pain ]] && [[ "$test_name" =~ leftAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/pain/leftAI"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    elif [[ "$test_name" =~ decoding-anticipation ]] && [[ "$test_name" =~ leftAI ]]; then
        data_dir="/my/path/fMRIData/mvpa/decoding/anticipation/leftAI"
        master_file="${data_dir}/sub-001/res_AUC_minus_chance_smoothed+tlrc.BRIK"

    # self/other
    elif [[ "$test_name" =~ self ]] || [[ "$test_name" =~ other ]]; then
        data_dir="/my/path/fMRIData/1stlevel_glm"
        # We'll still set a *default* master_file to something, e.g. "self-pain"
        # But we'll select sub-brick 20 for "pain" or 26 for "anticipation"
        # so we'll just pick the 'self' stats file as a reference for resampling:
        master_file="${data_dir}/sub-001/sub-001_task-empathy_glm-self_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"

    else
        echo "ERROR: Could not determine data_dir/master_file for test: ${test_name}"
        return 1
    fi

    echo "${data_dir}|${master_file}"
    return 0
}

## ------------------------------------------------------------------
## 2) gather_subjects_for_test:
##    we gather subject IDs differently depending on test name
## ------------------------------------------------------------------
gather_subjects_for_test() {
    local data_dir="$1"
    local test_name="$2"

    declare -a sub_list=()

    if [[ "$test_name" =~ patternsim ]]; then
        # e.g. sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD
        for headfile in "${data_dir}"/*_smoothed+tlrc.HEAD; do
            [[ -f "$headfile" ]] || continue
            local bname="$(basename "$headfile")"
            # sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.HEAD
            # subject_id = sub-001
            local subject_id="${bname%%_rsatoolbox_*}"
            sub_list+=( "$subject_id" )
        done

    elif [[ "$test_name" =~ decoding ]]; then
        # e.g. data_dir/sub-001/res_AUC_minus_chance_smoothed+tlrc.HEAD
        for sdir in "${data_dir}"/sub-*; do
            [[ -d "$sdir" ]] || continue
            local sbasename="$(basename "$sdir")"  # e.g. "sub-001"
            sub_list+=( "$sbasename" )
        done

    elif [[ "$test_name" =~ self ]] || [[ "$test_name" =~ other ]]; then
        # e.g. data_dir/sub-001/sub-001_task-empathy_glm-self_space-...stats.nii.gz
        for sdir in "${data_dir}"/sub-*; do
            [[ -d "$sdir" ]] || continue
            local sbasename="$(basename "$sdir")"
            sub_list+=( "$sbasename" )
        done
    else
        echo "WARNING: gather_subjects_for_test doesn't know how to gather for: $test_name"
    fi

    for sid in "${sub_list[@]}"; do
        echo "$sid"
    done
}

## ------------------------------------------------------------------
## 3) Main Loop over test folders
## ------------------------------------------------------------------
echo "Scanning test folders in ${BASE_DIR}..."
while IFS= read -r -d '' test_folder; do
    
    test_name=$(basename "${test_folder}")
    echo "======================================================"
    echo "Test Folder: $test_name"
    echo "======================================================"

    # (A) Figure out data_dir and master_file
    dm_out="$(get_data_dir_and_master "$test_folder")" || {
        echo "   -> Skipping test folder (no data_dir/master)."
        continue
    }
    data_dir="${dm_out%%|*}"
    master_file="${dm_out##*|}"
    echo "   data_dir   = $data_dir"
    echo "   master_file= $master_file"

    # (B) Gather subject IDs
    mapfile -t SUBJECT_LIST < <( gather_subjects_for_test "$data_dir" "$test_name" )
    echo "   Found ${#SUBJECT_LIST[@]} subjects."

    # (C) Find cluster_map HEAD/BRIK that do NOT contain "txt"
    map_files=()
    while IFS= read -r -d '' fname; do
        map_files+=( "$fname" )
    done < <(find "${test_folder}" -maxdepth 1 \
             \( -name "cluster_map*.HEAD" -o -name "cluster_map*.BRIK" \) \
             -not -iname "*txt*" -print0)

    # Group by the root name (strip .HEAD / .BRIK)
    declare -A effect_roots=()
    for f in "${map_files[@]}"; do
        root_no_ext="${f%.HEAD}"
        root_no_ext="${root_no_ext%.BRIK}"
        effect_roots["$root_no_ext"]=1
    done

    # (D) For each effect:
    for effect_root in "${!effect_roots[@]}"; do

        head_file="${effect_root}.HEAD"
        brik_file="${effect_root}.BRIK"
        if [[ ! -f "$head_file" || ! -f "$brik_file" ]]; then
            echo "   WARNING: Missing HEAD or BRIK for $effect_root"
            continue
        fi

        echo "   --> Found effect: $effect_root"

        # (1) Build short effect name
        effect_filename=$(basename "$effect_root")  # e.g. cluster_map_MainEffect_t+tlrc
        effect_short=$(echo "$effect_filename" \
                       | sed 's/^cluster_map_//' \
                       | sed 's/+.*//')

        # (2) Column name
        col_name="${test_name}_${effect_short}"
        ALL_COLUMNS+=( "$col_name" )

        # (3) Create cluster mask
        mask_01="${test_folder}/cluster_mask_${effect_short}.nii.gz"
        3dcalc -overwrite -a "$brik_file" -expr 'step(a)' \
               -prefix "$mask_01"

        # (4) Resample the mask
        mask_resampled="${test_folder}/cluster_mask_${effect_short}_resampled.nii.gz"
        3dresample \
          -master "$master_file" \
          -input  "$mask_01" \
          -prefix "$mask_resampled" \
          -overwrite

        # (5) Extract means for each subject
        for sub_id in "${SUBJECT_LIST[@]}"; do
            if [[ "$test_name" =~ patternsim ]]; then

                # *** Hardcode 'pain' or 'anticipation' instead of using a wildcard
                if [[ "$test_name" =~ pain_ ]]; then
                    subj_brik="${data_dir}/${sub_id}_rsatoolbox_rdm_map_pain_smoothed+tlrc.BRIK"
                elif [[ "$test_name" =~ anticipation_ ]]; then
                    subj_brik="${data_dir}/${sub_id}_rsatoolbox_rdm_map_anticipation_smoothed+tlrc.BRIK"
                else
                    echo "WARNING: 'patternsim' test but no 'pain' or 'anticipation' in test_name?"
                    continue
                fi

                echo "DEBUG: (patternsim) looking for $sub_id => $subj_brik"
                if [[ ! -f "$subj_brik" ]]; then
                    echo "WARNING: missing data for $sub_id at $subj_brik"
                    continue
                fi

                sub_brick="[0]"

            elif [[ "$test_name" =~ decoding ]]; then
                # decoding -> single sub-brick [0]
                subj_brik="${data_dir}/${sub_id}/res_AUC_minus_chance_smoothed+tlrc.BRIK"
                sub_brick="[0]"

            elif [[ "$test_name" =~ self ]] || [[ "$test_name" =~ other ]]; then
                # self/other -> need sub-brick #20 (pain) or #26 (anticipation)
                subj_brik="${data_dir}/${sub_id}/${sub_id}_task-empathy_glm-self_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
                [[ -f "$subj_brik" ]] || {
                    # maybe it's "other"? same path, different naming?
                    # If you name them the same except for _self_ vs _other_, 
                    # you'd do a quick check or fallback
                    subj_brik="${data_dir}/${sub_id}/${sub_id}_task-empathy_glm-other_space-MNI152NLin2009cAsym_smoothed_stats.nii.gz"
                }

                # decide pain (sub-brick 20) or anticipation (sub-brick 26)
                if [[ "$test_name" =~ pain_ ]]; then
                    sub_brick="[20]"
                elif [[ "$test_name" =~ anticipation_ ]]; then
                    sub_brick="[26]"
                else
                    # fallback
                    echo "       Skipping $sub_id because we don't see pain or anticipation in test_name."
                    continue
                fi

            else
                echo "       Don't know how to handle $test_name for subject file. Skipping $sub_id."
                continue
            fi

            # Confirm the subject BRIK actually exists:
            if [[ ! -f "$subj_brik" ]]; then
                echo "       WARNING: missing data for $sub_id at $subj_brik"
                continue
            fi

            # 3dROIstats (single line expected)
            stats_out=$(3dROIstats -quiet -mask "${mask_resampled}" "${subj_brik}${sub_brick}")
            mean_val=$(echo "$stats_out" | awk '{print $1}')

            # Save in effect_values
            effect_values["${sub_id}|${col_name}"]="$mean_val"
            GLOBAL_SUBJECTS["$sub_id"]=1

        done
    done

    # cleanup local arrays
    unset effect_roots
    unset map_files

done < <(find "${BASE_DIR}" -mindepth 1 -maxdepth 1 -type d -print0)


## ------------------------------------------------------------------
## 4) Output final CSV
## ------------------------------------------------------------------
echo "------------------------------------------------------"
echo "Writing results to ${OUTPUT_CSV}"
echo "------------------------------------------------------"

# Sort subject IDs for a consistent output
all_subjects_sorted=( $(printf "%s\n" "${!GLOBAL_SUBJECTS[@]}" | sort) )

{
  # Header
  echo -n "SubjectID"
  for col in "${ALL_COLUMNS[@]}"; do
    echo -n ",${col}"
  done
  echo

  # Rows
  for sid in "${all_subjects_sorted[@]}"; do
    echo -n "$sid"
    for col in "${ALL_COLUMNS[@]}"; do
      key="${sid}|${col}"
      val="${effect_values[$key]}"
      echo -n ",${val}"
    done
    echo
  done
} > "$OUTPUT_CSV"

echo "Done. Final CSV -> $OUTPUT_CSV"
