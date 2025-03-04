#!/bin/bash

# Define input files
table_file="/my/path/fMRIData/2ndlevel_glm/ttests/ttest_tables_without_zscores.csv"
stats_file="/my/path/fMRIData/2ndlevel_glm/ttests/combined_roi_stats.csv"
output_file="/my/path/fMRIData/2ndlevel_glm/ttests/combined_ttest_tables.csv"

# Create a temporary file
temp_file=$(mktemp)

# Extract header and write to the temporary file
head -n 1 "$table_file" > "$temp_file"

# Process rows in the table file (excluding the header)
tail -n +2 "$table_file" | while IFS=',' read -r ttest k cluster_threshold volume volume_mm3 peak_x peak_y peak_z z_score mean sem region
do
    # Remove quotes from ttest
    ttest=$(echo "$ttest" | tr -d '"')

    # If z_score is empty or NA, replace it
    if [[ -z "$z_score" || "$z_score" == "NA" ]]; then
        cluster_label="Mean_$k"
        z_score=$(awk -F',' -v ttest="$ttest" -v cluster_label="$cluster_label" '
            {gsub(/^ +| +$/, "", $1); gsub(/^ +| +$/, "", $2)}
            $1 == ttest && $2 == cluster_label {print $3}' "$stats_file")
    fi

    # Debug log
    echo "DEBUG: ttest=$ttest, cluster_label=$cluster_label, z_score=$z_score"

    # Write updated row to the temporary file
    echo "\"$ttest\",$k,$cluster_threshold,$volume,$volume_mm3,$peak_x,$peak_y,$peak_z,$z_score,$mean,$sem,$region" >> "$temp_file"
done

# Copy the temporary file to the output location
cp "$temp_file" "$output_file"

# Cleanup temporary file
rm "$temp_file"

echo "Combined CSV written to $output_file"
