#!/bin/bash
# This script runs AFNI’s whereami using the MNI_Glasser_HCP_v1.0 atlas on a set of coordinates.
# It creates a temporary file for each coordinate and runs whereami with -coord_file.
# Make sure that the MNI_Glasser_HCP_v1.0 atlas is properly installed and listed in your AFNI_ATLAS_LIST.

# Create a file (coords.1D) containing the coordinates (format: RL AP IS)
cat <<EOF > coords.1D
-53.5 66.5 -3.5
-62.5 30.5 35.5
48.5 75.5 2.5
60.5 24.5 41.5
57.5 42.5 32.5
-44.5 0.5 8.5
42.5 3.5 11.5
0.5 0.5 41.5
18.5 81.5 -15.5
-14.5 27.5 44.5
EOF

echo "Running AFNI whereami with the MNI_Glasser_HCP_v1.0 atlas on the following coordinates:"
echo "Index    RL[mm]    AP[mm]    IS[mm]"
echo "1        -53.5     66.5      -3.5"
echo "2        -62.5     30.5      35.5"
echo "3        48.5      75.5      2.5"
echo "4        60.5      24.5      41.5"
echo "5        57.5      42.5      32.5"
echo "6        -44.5     0.5       8.5"
echo "7        42.5      3.5       11.5"
echo "8        0.5       0.5       41.5"
echo "9        18.5      81.5      -15.5"
echo "10       -14.5     27.5      44.5"
echo ""

# Loop through each coordinate from coords.1D
index=1
while read -r rl ap is; do
    echo "-------------------------------"
    echo "Coordinate #$index: RL=${rl}, AP=${ap}, IS=${is}"
    # Write the current coordinate to a temporary file
    echo "${rl} ${ap} ${is}" > tmp_coord.1D
    # Run whereami using the MNI_Glasser_HCP_v1.0 atlas and the temporary coordinate file
    whereami -atlas MNI_Glasser_HCP_v1.0 -coord_file tmp_coord.1D
    ((index++))
done < coords.1D

# Clean up temporary file
rm -f tmp_coord.1D
