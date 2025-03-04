#!/bin/bash

ttests_dir="/mnt/LSANdata/MD/MindAndLife/fMRIData/2ndlevel_glm/ttests"

echo "Starting Z-map creation in directory: $ttests_dir"
echo ""

shopt -s nullglob
for file in "$ttests_dir"/*+tlrc.HEAD; do
  base=$(basename "$file" +tlrc.HEAD)
  ttest_file="${ttests_dir}/${base}+tlrc"
  clusterized_map="${ttests_dir}/${base}_clusterized_map_0-001.nii.gz"
  output_file="${ttests_dir}/${base}_cluster_Zplot.nii.gz"

  # Debug info
  echo "Processing $base"
  echo "T-test file: $ttest_file"
  echo "Clusterized map: $clusterized_map"
  echo "Output file: $output_file"

  if [[ ! -f "$clusterized_map" ]]; then
    echo "Skipping $base (missing clusterized map)"
    continue
  fi

  echo "Running 3dcalc..."
  3dcalc -a "$ttest_file" \
         -b "$clusterized_map" \
         -expr 'a*step(b)' \
         -prefix "$output_file"

  if [[ $? -eq 0 ]]; then
    echo "Z-map created: $output_file"
  else
    echo "Error running 3dcalc for $base"
  fi

  echo ""
done

echo "Z-map creation completed."
