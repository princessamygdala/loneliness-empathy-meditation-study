#!/bin/bash


# MAYBE THE PROBLEM IS IDAT 0 and ITHR 1

# Define masks for whole brain and AI-dACC
#WHOLEBRAIN_MASK="/mnt/LSANdata/MD/MindAndLife/fMRIData/masks/MNI152NLin2009cAsym-desc-graymatter-thr25_3mm-mask_resampled.nii.gz"
DACC_MASK="/mnt/LSANdata/MD/MindAndLife/fMRIData/masks/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"
LEFTAI_MASK="/mnt/LSANdata/MD/MindAndLife/fMRIData/masks/aal2_desc-left-AI_3mm-mask_resampled.nii.gz"
RIGHTAI_MASK="/mnt/LSANdata/MD/MindAndLife/fMRIData/masks/aal2_desc-right-AI_3mm-mask_resampled.nii.gz"
WHOLEBRAIN_MASK="/mnt/LSANdata/MD/MindAndLife/fMRIData/masks/MNI152NLin2009cAsym-desc-graymatter-thr25_3mm-mask_resampled.nii.gz"

# Define clustering parameters
P_VALUE=0.001
THRESHOLD_INDEX=7  # Corresponds to threshold alpha = 0.05 in the table (column 6)

# Define the directory containing the datasets
TTTEST_DIR="/mnt/LSANdata/MD/MindAndLife/fMRIData/2ndlevel_glm/ttests"

# Define the combined output file for all cluster tables
COMBINED_OUTPUT="${TTTEST_DIR}/combined_clusterize_results_0-001.txt"

# Clear the combined output file if it exists
> "$COMBINED_OUTPUT"

# Iterate through all datasets with +tlrc (ignores .HEAD and .BRIK extensions)
for DATASET in "$TTTEST_DIR"/*+tlrc.HEAD; do # change this line if you want to loop through only specific data sets
    # Extract the base name of the dataset (without extensions like .HEAD or .BRIK)
    BASE_NAME=$(basename "$DATASET" +tlrc.HEAD)
    # Define the input dataset
    INSET="${TTTEST_DIR}/${BASE_NAME}+tlrc"

    if [[ "$BASE_NAME" == *"dACC"* ]]; then
        MASK=$DACC_MASK
        echo "Processing $BASE_NAME as dACC dataset with mask: $MASK"
    elif [[ "$BASE_NAME" == *"leftAI"* ]]; then
        MASK=$LEFTAI_MASK
        echo "Processing $BASE_NAME as left AI dataset with mask: $MASK"
    elif [[ "$BASE_NAME" == *"rightAI"* ]]; then
        MASK=$RIGHTAI_MASK
        echo "Processing $BASE_NAME as right AI dataset with mask: $MASK"
    elif [[ "$BASE_NAME" == *"wholebrain"* ]]; then
        MASK=$WHOLEBRAIN_MASK
        echo "Processing $BASE_NAME as wholebrain dataset with mask: $MASK"
    else
        echo "Skipping $BASE_NAME: Dataset type not recognized."
        continue
    fi


    # Define the CSimA file path
    CSIM_FILE="${TTTEST_DIR}/${BASE_NAME}.CSimA.NN2_bisided.1D"

    # Check if the CSimA file exists
    if [[ ! -f "$CSIM_FILE" ]]; then
        echo "Error: CSimA file $CSIM_FILE does not exist for $BASE_NAME. Skipping..."
        continue
    fi

    # Extract the voxel number for p-value = 0.001 and alpha = 0.05
    VOXEL_NUMBER=$(awk -v p_value="$P_VALUE" -v threshold_index="$THRESHOLD_INDEX" '$1 == p_value {print $threshold_index}' "$CSIM_FILE")

    # Check if the voxel number was successfully extracted
    if [[ -z "$VOXEL_NUMBER" ]]; then
        echo "Error: Could not extract voxel number for $BASE_NAME from $CSIM_FILE. Skipping..."
        continue
    fi

    # Print the extracted voxel number
    echo "Processing $BASE_NAME: Extracted voxel number for p = $P_VALUE and alpha = 0.05: $VOXEL_NUMBER"

    # Run 3dClusterize with the extracted voxel number
    PREF_MAP="${TTTEST_DIR}/${BASE_NAME}_clusterized_map_0-001.nii.gz"
    OUTPUT_TABLE="${TTTEST_DIR}/${BASE_NAME}_cluster_table_0-001.txt"
    3dClusterize -inset $INSET -mask $MASK -bisided p=$P_VALUE -idat 0 -ithr 1 -NN 2 -clust_nvox $VOXEL_NUMBER -pref_map $PREF_MAP -overwrite > "$OUTPUT_TABLE"

    # Check if 3dClusterize was successful
    if [[ $? -eq 0 ]]; then
        echo "Clusterized map created for $BASE_NAME: $PREF_MAP"
        # Append the output table to the combined file
        echo "----- Results for $BASE_NAME -----" >> "$COMBINED_OUTPUT"
        cat "$OUTPUT_TABLE" >> "$COMBINED_OUTPUT"
        echo -e "\n" >> "$COMBINED_OUTPUT"
    else
        echo "Error: 3dClusterize failed for $BASE_NAME."
    fi
done

echo "All files processed. Combined results saved to $COMBINED_OUTPUT."
