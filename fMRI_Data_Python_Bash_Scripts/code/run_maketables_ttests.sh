#!/bin/bash

# Paths for input and output files
INPUT_FILE="/my/path/fMRIData/2ndlevel_glm/ttests/combined_clusterize_results_0-001.txt"
OUTPUT_FILE="/my/path/fMRIData/2ndlevel_glm/ttests/ttest_tables_without_zscores.csv"
TTESTS_DIR="/my/path/fMRIData/2ndlevel_glm/ttests"

# Write CSV header
echo "ttest,k,cluster threshold (NN),Volume,Volume (mm3),peak x,peak y,peak z,z score,Mean,SEM,region" > "$OUTPUT_FILE"

# Declare an associative array for z-scores
declare -A zscores

# Calculate z-scores and populate the array
echo "Calculating z-scores..."
for TEST_MAP in "$TTESTS_DIR"/*+tlrc.HEAD; do
    BASE_NAME=$(basename "$TEST_MAP" +tlrc.HEAD)
    CLUSTER_MAP="${TTESTS_DIR}/${BASE_NAME}_clusterized_map_0-001.nii.gz"

    echo "Processing: $TEST_MAP with mask $CLUSTER_MAP"

    if [[ -f "$CLUSTER_MAP" ]]; then
        # Run 3dROIstats and capture output
        OUTPUT=$(3dROIstats -mask "$CLUSTER_MAP" "$TEST_MAP[1]")

        echo "3dROIstats Output for $BASE_NAME:"
        echo "$OUTPUT"

        # Parse the output to extract z-scores
        readarray -t lines <<< "$OUTPUT"
        if [[ ${#lines[@]} -ge 2 ]]; then
            header_line="${lines[0]}"
            data_line="${lines[1]}"

            IFS=$'\t' read -ra headers <<< "$header_line"
            IFS=$'\t' read -ra data <<< "$data_line"

            for ((i=2; i<${#headers[@]}; i++)); do
                cluster_label="${headers[i]}"
                z_score="${data[i]}"
                zscores["${BASE_NAME}_${cluster_label}"]="$z_score"
                echo "Key: ${BASE_NAME}_${cluster_label}, Z-Score: $z_score"
            done
        else
            echo "Unexpected output format from 3dROIstats for: $BASE_NAME"
        fi
    else
        echo "Clusterized map not found for: $BASE_NAME"
    fi
done

# Process the input file and add z-scores directly
echo "Integrating z-scores into the table..."
while IFS= read -r line; do
    if echo "$line" | grep -q '^----- Results for '; then
        ttest=$(echo "$line" | sed 's/^----- Results for \(.*\) -----$/\1/')
        k=1
        in_table=0
    elif echo "$line" | grep -q '^#Volume'; then
        in_table=1
    elif [ "$in_table" -eq 1 ] && echo "$line" | grep -q '^#------'; then
        in_table=2
    elif [ "$in_table" -eq 2 ] && (echo "$line" | grep -q '^#------' || echo "$line" | grep -q '^$'); then
        in_table=0
    elif [ "$in_table" -eq 2 ] && echo "$line" | grep -q '^[ ]*[0-9]'; then
        # Parse the line into fields
        read -a fields <<< "$line"
        volume="${fields[0]}"
        mean="${fields[10]}"
        sem="${fields[11]}"
        mi_rl="${fields[13]}"
        mi_ap="${fields[14]}"
        mi_is="${fields[15]}"
        volume_mm3=$((volume * 27))
        cluster_label="Mean_${k}"
        z_score="${zscores["${ttest}_${cluster_label}"]}"
        z_score="${z_score:-NA}"  # Default to NA if no z-score is found
        echo "\"$ttest\",$k,2,$volume,$volume_mm3,$mi_rl,$mi_ap,$mi_is,$z_score,$mean,$sem," >> "$OUTPUT_FILE"
        echo "Processed: $ttest, Cluster: $cluster_label, Z-Score: $z_score"
        k=$((k + 1))
    fi
done < "$INPUT_FILE"

echo "Table with z-scores saved to $OUTPUT_FILE"
