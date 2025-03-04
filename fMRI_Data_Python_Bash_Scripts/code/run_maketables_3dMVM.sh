#!/usr/bin/env bash

# Single “combined cluster” file to parse:
input_file="/my/path/fMRIData/2ndlevel_glm/3dMVM/clusterized_results_0-001/combined_cluster_tables_0-001.txt"

# Output CSV path:
output_file="/my/path/fMRIData/2ndlevel_glm/3dMVM/3dMVM_tables1.csv"

# Write CSV header (once):
echo "test,effect,direction,k,cluster threshold (NN),Volume,Volume (mm3),peak x,peak y,peak z,z score,Mean,SEM,region" > "$output_file"

# Initialize variables that persist across entire file
test=""
effect=""
direction=""
in_table=0
found_cluster=0  # will be set to 1 once we parse any cluster
k=1

while IFS= read -r line; do
  # 1) Detect a new “test” = new 3dMVM file
  if echo "$line" | grep -q '^Processing .*/3dMVM_.*\.nii\.gz with residuals'; then
    # Before we move on, if the *old* effect had no clusters, print “No clusters found” once
    if [ "$in_table" -eq 2 ] && [ "$found_cluster" -eq 0 ]; then
      echo "\"$test\",\"$effect\",\"$direction\",,\"No clusters found\",,,,,,,," >> "$output_file"
    fi

    # Extract test name
    test=$(echo "$line" | sed -n 's|^Processing .*/\(3dMVM_[^/]*\)\.nii\.gz with residuals.*|\1|p')
    # Reset sub-brick counters
    effect=""
    direction=""
    in_table=0
    found_cluster=0
    k=1
    continue
  fi

  # 2) Detect a new sub-brick effect
  if echo "$line" | grep -q '^Processing sub-brick index: '; then
    # If the *old* effect had no clusters, finalize that effect:
    if [ "$in_table" -eq 2 ]; then
      # End old effect’s table
      in_table=0
      if [ "$found_cluster" -eq 0 ]; then
        echo "\"$test\",\"$effect\",\"$direction\",,\"No clusters found\",,,,,,,," >> "$output_file"
      fi
    fi

    # Extract effect
    effect=$(echo "$line" | sed -n 's|^Processing sub-brick index: [0-9]\+ (\([^)]*\)).*|\1|p')
    direction=""
    found_cluster=0
    k=1
    continue
  fi

  # 3) Detect direction from “++ Opt code”
  if echo "$line" | grep -q '^++ Opt code:'; then
    if echo "$line" | grep -q 'RIGHT_TAIL'; then
      direction="positive"
    elif echo "$line" | grep -q 'LEFT_TAIL'; then
      direction="negative"
    elif echo "$line" | grep -q 'bisided'; then
      direction="two-sided"
    fi
    continue
  fi

  # 4) Start of cluster table
  if echo "$line" | grep -q '^#Volume'; then
    in_table=1
    continue
  fi

  # 5) Once we see “#------” after “#Volume”, we know the table lines follow
  if [ "$in_table" -eq 1 ] && echo "$line" | grep -q '^#------'; then
    in_table=2
    continue
  fi

  # 6) If we see “#------” again or a blank line, that ends the table
  if [ "$in_table" -eq 2 ] && ( echo "$line" | grep -q '^#------' || [ -z "$line" ] ); then
    in_table=0
    # If we ended but never found any cluster, print “No clusters found”
    if [ "$found_cluster" -eq 0 ]; then
      echo "\"$test\",\"$effect\",\"$direction\",,\"No clusters found\",,,,,,,," >> "$output_file"
    fi
    continue
  fi

  # 7) Now parse actual cluster lines
  #    We expect lines that start with an integer (cluster index or volume).
  #    Adjust as needed to match your cluster table format.
  if [ "$in_table" -eq 2 ] && echo "$line" | grep -Eq '^[ ]*[0-9]+'; then

    # Mark that we found at least one cluster
    found_cluster=1

    # Example AWK parse:
    echo "$line" | awk -v test="$test" \
                     -v effect="$effect" \
                     -v direction="$direction" \
                     -v k="$k" '
    BEGIN {
      OFS=",";
    }
    {
      # Adjust columns to match your table format.
      # Suppose your table columns are:
      #    1) volume
      #    2) x
      #    3) y
      #    4) z
      #    5) zscore
      #    6) mean
      #    7) sem
      #    8+) region
      #
      # If that’s your actual format, you might do:
      volume   = $1
      peak_x   = $2
      peak_y   = $3
      peak_z   = $4
      zscore   = $5
      meanval  = $6
      semval   = $7

      # Region = columns from $8 onward
      region=""
      for(i=8; i<=NF; i++){
         region = region $i " "
      }
      gsub(/^ +| +$/, "", region)

      # Convert volume to mm^3 (for 3mm isotropic: 27 mm^3/voxel):
      vol_mm3 = volume * 27

      # Print CSV line
      # Format: test,effect,direction,k,NN,vol,vol_mm3,peakx,peaky,peakz,zscore,mean,sem,region
      printf "\"%s\",\"%s\",\"%s\",%d,2,%d,%d,%s,%s,%s,%s,%s,%s,\"%s\"\n", \
             test, effect, direction, k, volume, vol_mm3, \
             peak_x, peak_y, peak_z, zscore, meanval, semval, region
    }' >> "$output_file"

    k=$((k + 1))
    continue
  fi

done < "$input_file"

# One last check: if the file ends while in_table=2
# (i.e., we never saw another "#------" or blank),
# we should finalize and mark "No clusters found" if needed.
if [ "$in_table" -eq 2 ]; then
  if [ "$found_cluster" -eq 0 ]; then
    echo "\"$test\",\"$effect\",\"$direction\",,\"No clusters found\",,,,,,,," >> "$output_file"
  fi
fi

echo "Done! Wrote CSV to $output_file"
 