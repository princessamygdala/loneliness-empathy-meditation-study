#!/bin/bash

# Base directory
base_dir="/mypath/fMRIData/events"

# Initialize variables
total_sum=0
total_count=0

# Loop through each participant folder
for participant_dir in "$base_dir"/sub-*; do
  # Loop through each txt file containing 'anticipation' in the file name
  for file in "$participant_dir"/regressors/*anticipation*.txt; do
    if [[ -f "$file" ]]; then
      # Read the file and calculate the average of the numbers
      sum=0
      count=0
      while IFS= read -r line; do
        for number in $line; do
          value="${number##*:}"
          sum=$(echo "$sum + $value" | bc)
          count=$((count + 1))
        done
      done < "$file"
      
      # Add to total sum and count
      total_sum=$(echo "$total_sum + $sum" | bc)
      total_count=$((total_count + count))
    fi
  done
done

# Calculate the overall average
if [ $total_count -ne 0 ]; then
  overall_average=$(echo "scale=2; $total_sum / $total_count" | bc)
  echo "Overall average: $overall_average"
else
  echo "No anticipation files found."
fi



# #!/bin/bash

# # Base directory
# base_dir="/mypath/fMRIData/events"

# # Initialize variables
# total_sum=0
# total_count=0

# # Loop through each participant folder
# for participant_dir in "$base_dir"/sub-*; do
#   # Loop through each txt file containing 'anticipation' in the file name
#   for file in "$participant_dir"/regressors/*anticipation*.txt; do
#     if [[ -f "$file" ]]; then
#       # Read the file and calculate the average of the numbers
#       sum=0
#       count=0
#       while IFS= read -r line; do
#         for number in $line; do
#           value="${number##*:}"
#           sum=$(echo "$sum + $value" | bc)
#           count=$((count + 1))
#         done
#       done < "$file"
      
#       # Add to total sum and count
#       total_sum=$(echo "$total_sum + $sum" | bc)
#       total_count=$((total_count + count))
#     fi
#   done
# done

# # Calculate the overall average
# if [ $total_count -ne 0 ]; then
#   overall_average=$(echo "scale=2; $total_sum / $total_count" | bc)
#   echo "Overall average: $overall_average"
# else
#   echo "No anticipation files found."
# fi