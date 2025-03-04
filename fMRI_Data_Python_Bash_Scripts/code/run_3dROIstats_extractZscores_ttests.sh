#!/bin/bash

# This script extracts z-scores from t-test maps using 3dROIstats by applying the clusterized map as a mask to the ttest map. 
# The output is saved in a CSV file with the following columns: File, Cluster_Label, Z_Score.
# The script assumes that the clusterized maps are saved in the same directory as the t-test maps with the suffix "_clusterized_map.nii.gz".
# The script iterates through all t-test maps in the directory and extracts the z-scores for each cluster in the clusterized map.
# The output is saved in a file named "combined_roi_stats.csv" in the same directory as the t-test maps.
# The script is intended to be run after running 3dClusterize on the t-test maps to create the clusterized maps.
# Last updated: 2024-11-26 by Marla Dressel

# Directories
TTESTS_DIR="/my/path/fMRIData/2ndlevel_glm/ttests"
OUTPUT_FILE="${TTESTS_DIR}/combined_roi_stats_ttests.csv"

# Prepare output with headers
echo "File,Cluster_Label,Z_Score" > "$OUTPUT_FILE"

# Process files
for TEST_MAP in "$TTESTS_DIR"/*+tlrc.HEAD; do
    BASE_NAME=$(basename "$TEST_MAP" +tlrc.HEAD)
    CLUSTER_MAP="${TTESTS_DIR}/${BASE_NAME}_clusterized_map_0-001.nii.gz"
    
    if [[ -f "$CLUSTER_MAP" ]]; then
        echo "Processing: $TEST_MAP with mask $CLUSTER_MAP"
        
        # Run 3dROIstats and capture the output
        OUTPUT=$(3dROIstats -mask "$CLUSTER_MAP" "$TEST_MAP[1]")
        
        # Read the output lines into an array
        readarray -t lines <<< "$OUTPUT"
        
        # Check if there are at least two lines (header and data)
        if [[ ${#lines[@]} -ge 2 ]]; then
            # The first line is the header
            header_line="${lines[0]}"
            # The second line is the data
            data_line="${lines[1]}"
            
            # Split the header and data lines into arrays
            IFS=$'\t' read -ra headers <<< "$header_line"
            IFS=$'\t' read -ra data <<< "$data_line"
            
            # Loop over the headers and data
            # Start from index 2 to skip 'File' and 'Sub-brick'
            for ((i=2; i<${#headers[@]}; i++)); do
                cluster_label="${headers[i]}"
                z_score="${data[i]}"
                # Append results to the output CSV
                echo "${BASE_NAME},${cluster_label},${z_score}" >> "$OUTPUT_FILE"
            done
        else
            echo "Unexpected output format from 3dROIstats for: $BASE_NAME"
        fi
    else
        echo "Clusterized map not found for: $BASE_NAME"
    fi
done

echo "Processing completed. Results saved to $OUTPUT_FILE"
