#!/bin/bash

# # Step 1: Isolate the large cluster and resample the mask

# 3dcalc -a /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_clusterized_map_0-001.nii.gz \
#        -expr 'equals(a, 1)' \
#        -prefix /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask.nii.gz


# 3dresample -master /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_cluster_Zplot.nii.gz \
#            -input /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask.nii.gz \
#            -prefix /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask_resampled.nii.gz

# 3drefit -space MNI /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask_resampled.nii.gz

# Step 2: Apply the mask to your Z-map

# 3dcalc -a /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_cluster_Zplot.nii.gz \
#        -b /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask_resampled.nii.gz \
#        -expr 'a*step(b)' \
#        -prefix /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_zmap_large_cluster.nii.gz

# # Step 3: Find local maxima with an 8 mm distance requirement
# 3dExtrema -volume \
#           -mask_file /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_mask_resampled.nii.gz \
#           -sep_dist 8 \
#           -prefix /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_large_cluster_maxima.nii.gz \
#           /my/path/fMRIData/2ndlevel_glm/ttests/1sample-ttest_rdm_pain_wholebrain_zmap_large_cluster.nii.gz'[0]'


# Define directories and files
BASE_DIR="/my/path/fMRIData/2ndlevel_glm/ttests"
OUTPUT_FILE="${BASE_DIR}/combined_local_maxima_results.txt"
ZMAP_SUFFIX="_cluster_Zplot.nii.gz"
MASK_SUFFIX="_large_cluster_mask.nii.gz"
RESAMPLED_SUFFIX="_large_cluster_mask_resampled.nii.gz"
FINAL_ZMAP_SUFFIX="_zmap_large_cluster.nii.gz"
MAXIMA_SUFFIX="_large_cluster_maxima.nii.gz"

# Define tests and clusters
declare -A TEST_CLUSTERS
TEST_CLUSTERS["1sample-ttest_decoding_pain_wholebrain"]="1"
TEST_CLUSTERS["1sample-ttest_other-pain_wholebrain"]="1 2 3"
TEST_CLUSTERS["1sample-ttest_self-pain_wholebrain"]="1 2"

# Clear the output file
> $OUTPUT_FILE

# Function to process clusters
process_cluster() {
  local test_name=$1
  local cluster=$2

  echo "Processing ${test_name}, cluster ${cluster}..."

  local mask_file=${BASE_DIR}/${test_name}_cluster${cluster}${MASK_SUFFIX}
  local resampled_file=${BASE_DIR}/${test_name}_cluster${cluster}${RESAMPLED_SUFFIX}
  local zmap_file=${BASE_DIR}/${test_name}_cluster${cluster}${FINAL_ZMAP_SUFFIX}
  local maxima_file=${BASE_DIR}/${test_name}_cluster${cluster}${MAXIMA_SUFFIX}

  # Step 1: Isolate the cluster
  if [[ ! -f $mask_file ]]; then
    echo "Creating mask for ${test_name}, cluster ${cluster}..."
    3dcalc \
      -a ${BASE_DIR}/${test_name}_clusterized_map_0-001.nii.gz \
      -expr "equals(a, ${cluster})" \
      -prefix $mask_file
  else
    echo "Mask file already exists: $mask_file. Skipping."
  fi

  # Step 2: Resample the mask
  if [[ ! -f $resampled_file ]]; then
    echo "Resampling mask for ${test_name}, cluster ${cluster}..."
    3dresample \
      -master ${BASE_DIR}/${test_name}${ZMAP_SUFFIX} \
      -input $mask_file \
      -prefix $resampled_file
    3drefit -space MNI $resampled_file
  else
    echo "Resampled mask file already exists: $resampled_file. Skipping."
  fi

  # Step 3: Apply the mask to the Z-map
  if [[ ! -f $zmap_file ]]; then
    echo "Creating masked Z-map for ${test_name}, cluster ${cluster}..."
    3dcalc \
      -a ${BASE_DIR}/${test_name}${ZMAP_SUFFIX} \
      -b $resampled_file \
      -expr "a*step(b)" \
      -prefix $zmap_file
  else
    echo "Masked Z-map file already exists: $zmap_file. Skipping."
  fi

  # Step 4: Find local maxima
  if [[ ! -f $maxima_file ]]; then
    echo "Finding local maxima for ${test_name}, cluster ${cluster}..."
    echo -e "\n${test_name}, Cluster ${cluster}:" >> $OUTPUT_FILE
    3dExtrema -volume \
      -mask_file $resampled_file \
      -sep_dist 8 \
      $zmap_file'[0]' >> $OUTPUT_FILE
  else
    echo "Maxima file already exists: $maxima_file. Skipping."
    # Append existing maxima results to the combined file
    echo -e "\n${test_name}, Cluster ${cluster} (from existing file):" >> $OUTPUT_FILE
    cat $maxima_file >> $OUTPUT_FILE
  fi
}

# Main script loop
for test_name in "${!TEST_CLUSTERS[@]}"; do
  for cluster in ${TEST_CLUSTERS[$test_name]}; do
    process_cluster $test_name $cluster
  done
done

echo "Processing complete. Results saved to ${OUTPUT_FILE}."

