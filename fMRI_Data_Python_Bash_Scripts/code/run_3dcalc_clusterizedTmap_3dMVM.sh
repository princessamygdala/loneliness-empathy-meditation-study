#!/bin/bash
# This script processes clusterized 3dMVM effect maps:
#  - It creates a binary cluster mask directly from the original effect map,
#  - Resamples that mask to a master map, and
#  - Extracts T-scores from the corresponding 3dMVM map.

# Directory containing clusterized results (each folder contains a BRIK/HEAD dataset)
CLUSTER_RESULTS_DIR="/my/path/fMRIData/2ndlevel_glm/3dMVM/clusterized_results_0-001"

# Directory containing the full 3dMVM maps
MVM_MAPS_DIR="/my/path/fMRIData/2ndlevel_glm/3dMVM"

# Master map to which the cluster mask will be resampled (same for everyone)
MASTER_MAP="/my/path/fMRIData/mvpa/pattern_similarity/rsatoolbox/pain/wholebrain/sub-001_rsatoolbox_rdm_map_pain_smoothed+tlrc.BRIK"

# Loop through each subfolder in the cluster results directory
for folder in "$CLUSTER_RESULTS_DIR"/*; do
    # Only process directories
    if [[ ! -d "$folder" ]]; then
        continue
    fi

    echo "-------------------------------------"
    echo "Processing folder: $folder"

    # Search for a BRIK file (ignoring .txt files) that contains one of the keywords.
    effect_file=$(find "$folder" -maxdepth 1 -type f -name "*+tlrc.BRIK" ! -name "*.txt*" \
                   | grep -E "MainEffect|Interaction|LKM" | head -n 1)

    if [[ -z "$effect_file" ]]; then
        echo "No valid effect map found in $folder. Skipping."
        continue
    fi

    echo "Found effect map: $effect_file"

    # Create a binary cluster mask by thresholding the original effect map
    cluster_mask="${folder}/cluster_mask.nii.gz"
    echo "Creating cluster mask..."
    3dcalc -a "$effect_file" -expr 'step(a)' -prefix "$cluster_mask"

    # Resample the cluster mask to match the master map’s resolution
    cluster_mask_resampled="${folder}/cluster_mask_resampled.nii.gz"
    echo "Resampling cluster mask to match master map..."
    3dresample -master "$MASTER_MAP" -input "$cluster_mask" -prefix "$cluster_mask_resampled"

    # Determine the corresponding 3dMVM map:
    # Assume the folder name includes a unique identifier.
    folder_basename=$(basename "$folder")
    # Remove trailing parts (e.g., "_p0-001") to form a search pattern.
    mvm_pattern=$(echo "$folder_basename" | sed 's/_p.*//')
    mvm_map=$(find "$MVM_MAPS_DIR" -maxdepth 1 -type f -name "*${mvm_pattern}*.nii.gz" | head -n 1)
    if [[ -z "$mvm_map" ]]; then
        echo "No corresponding 3dMVM map found for pattern ${mvm_pattern}. Skipping T-score extraction."
        continue
    fi
    echo "Found corresponding 3dMVM map: $mvm_map"

    # Convert the 3dMVM map to NIfTI if it is in AFNI BRIK/HEAD format
    if [[ "$mvm_map" == *+tlrc* ]]; then
        mvm_map_nifti="${mvm_map%+tlrc*}.nii.gz"
        echo "Converting 3dMVM map from AFNI to NIfTI..."
        3dAFNItoNIFTI -prefix "$mvm_map_nifti" "$mvm_map"
        mvm_map="$mvm_map_nifti"
    fi

    # Define output file for the T-score map
    tscore_map="${folder}/${mvm_pattern}_Tscoremap.nii.gz"
    echo "Extracting T-scores into $tscore_map..."
    3dcalc -a "$mvm_map" -b "$cluster_mask_resampled" -expr 'a*step(b)' -prefix "$tscore_map"

    echo "Finished processing folder: $folder"
done

echo "-------------------------------------"
echo "All processing completed."
