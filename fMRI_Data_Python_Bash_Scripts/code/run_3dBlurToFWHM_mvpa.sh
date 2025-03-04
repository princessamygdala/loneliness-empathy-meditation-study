#!/bin/bash

# This script applies spatial smoothing to univariate GLM results using 3dBlurToFWHM
# Last updated by MD: November 19, 2024

# Base directory where the mvpa folders are located
BASE_DIR="/my/path/fMRIData/mvpa"

# FWHM value you want to achieve
TARGET_FWHM=4.0

# Mask file paths
WHOLEBRAIN_MASK="/my/path/fMRIData/masks/MNI152NLin2009cAsym_desc-wholebrain_3mm-mask_resampled.nii.gz"
DACC_MASK="/my/path/fMRIData/masks/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"
LEFTAI_MASK="/my/path/fMRIData/masks/aal2_desc-left-AI_3mm-mask_resampled.nii.gz"
RIGHTAI_MASK="/my/path/fMRIData/masks/aal2_desc-right-AI_3mm-mask_resampled.nii.gz"

# Define main folders and subfolders to iterate over
MAIN_FOLDERS=("decoding" "pattern_similarity/rsatoolbox")
CONDITIONS=("anticipation" "pain")
SUBFOLDERS=("dACC" "wholebrain" "leftAI" "rightAI")

# Loop through each main folder
for MAIN_FOLDER in "${MAIN_FOLDERS[@]}"; do
    for CONDITION in "${CONDITIONS[@]}"; do
        for SUBFOLDER in "${SUBFOLDERS[@]}"; do
            
            # Set the appropriate mask based on the subfolder
            if [ "${SUBFOLDER}" == "AIdACC" ]; then
                MASK_FILE=${DACC_MASK}
            elif [ "${SUBFOLDER}" == "leftAI" ]; then
                MASK_FILE=${LEFTAI_MASK}
            elif [ "${SUBFOLDER}" == "rightAI" ]; then
                MASK_FILE=${RIGHTAI_MASK}
            else
                MASK_FILE=${WHOLEBRAIN_MASK}
            fi

            # Construct the path to the current subfolder
            CURRENT_DIR="${BASE_DIR}/${MAIN_FOLDER}/${CONDITION}/${SUBFOLDER}"

            # Check if the directory exists
            if [ ! -d "${CURRENT_DIR}" ]; then
                echo "Directory ${CURRENT_DIR} does not exist. Skipping..."
                continue
            fi

            # Determine whether the files are in subject folders
            if [[ "${MAIN_FOLDER}" == "decoding" ]]; then
                SUBJECT_FOLDERS="${CURRENT_DIR}/sub-*"
                for SUBJ_DIR in ${SUBJECT_FOLDERS}; do
                    echo "Processing ${SUBJ_DIR}..."
                    
                    # Extract subject ID from the directory name
                    SUBJ_ID=$(basename ${SUBJ_DIR})

                    # Construct the input file path
                    INPUT_FILE="${SUBJ_DIR}/res_AUC_minus_chance+tlrc"

                    # Skip if the input file does not exist
                    if [ ! -f "${INPUT_FILE}.HEAD" ]; then
                        echo "Input file ${INPUT_FILE}+tlrc.HEAD does not exist. Skipping..."
                        continue
                    fi

                    # Define the output file prefix
                    OUTPUT_PREFIX="${SUBJ_DIR}/res_AUC_minus_chance_smoothed"

                    # Check if the smoothed dataset already exists
                    if [ -f "${OUTPUT_PREFIX}+tlrc.HEAD" ] && [ -f "${OUTPUT_PREFIX}+tlrc.BRIK" ]; then
                        echo "Smoothed dataset for ${SUBJ_ID} already exists. Skipping..."
                        continue
                    fi

                    # Apply smoothing with the specified mask
                    3dBlurToFWHM -input ${INPUT_FILE} -prefix ${OUTPUT_PREFIX} -FWHM ${TARGET_FWHM} -mask ${MASK_FILE}

                    echo "Smoothing completed for ${SUBJ_DIR}"
                done

            elif [[ "${MAIN_FOLDER}" == "pattern_similarity/rsatoolbox" ]]; then
                for FILE in ${CURRENT_DIR}/*.nii.gz; do
                    echo "Processing ${FILE}..."

                    # Skip if the file does not exist
                    if [ ! -f "${FILE}" ]; then
                        echo "File ${FILE} does not exist. Skipping..."
                        continue
                    fi

                    # Define the output file prefix
                    OUTPUT_PREFIX="${FILE%.nii.gz}_smoothed"

                    # Check if the smoothed dataset already exists
                    if [ -f "${OUTPUT_PREFIX}.nii.gz" ]; then
                        echo "Smoothed dataset for ${FILE} already exists. Skipping..."
                        continue
                    fi

                    # Apply smoothing with the specified mask
                    3dBlurToFWHM -input ${FILE} -prefix ${OUTPUT_PREFIX} -FWHM ${TARGET_FWHM} -mask ${MASK_FILE}

                    echo "Smoothing completed for ${FILE}"
                done
            fi
        done
    done
done

echo "All smoothing operations completed!"
