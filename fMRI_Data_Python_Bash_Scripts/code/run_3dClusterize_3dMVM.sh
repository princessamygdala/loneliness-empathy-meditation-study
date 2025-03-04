#!/bin/tcsh

############################
# Define paths to masks
############################
set mask_dACC   = "/my/path/fMRIData/masks/aal2_desc-dACC-anteriorY0_3mm-mask_resampled.nii.gz"
set mask_leftAI = "/my/path/fMRIData/masks/aal2_desc-left-AI_3mm-mask_resampled.nii.gz"
set mask_rightAI = "/my/path/fMRIData/masks/aal2_desc-right-AI_3mm-mask_resampled.nii.gz"

############################
# Define input and output directories
############################
set input_dir  = "/my/path/fMRIData/2ndlevel_glm/3dMVM"
set output_dir = "/my/path/fMRIData/2ndlevel_glm/3dMVM/clusterized_results_0-001"

# Create output directory if it doesn't exist
if (! -d $output_dir) then
    mkdir -p $output_dir
endif

############################
# Define the path for the combined cluster tables
############################
set combined_cluster_file = "${output_dir}/combined_cluster_tables_0-001.txt"

# Remove the combined file if it already exists
if (-e $combined_cluster_file) then
    rm $combined_cluster_file
endif
touch $combined_cluster_file

############################
# Iterate over each dataset and corresponding residuals
############################
foreach dataset (`ls $input_dir/*_residuals.nii.gz | sed 's/_residuals\.nii\.gz//'`)
#foreach dataset (`ls $input_dir/*3dMVM_Groupmc_stateEmp_painRating*_residuals.nii.gz | sed 's/_residuals\.nii\.gz//'`) # do it for one type of data set only (optional)
    # Define paths for dataset and residuals
    set map       = "${dataset}.nii.gz"
    set residuals = "${dataset}_residuals.nii.gz"

    ############################
    # Determine the mask based on the map name
    ############################
    # You can adjust the matching rules below depending on how your filenames are structured.
    if    ("$dataset" =~ *dACC*) then
        set mask = $mask_dACC
    else if ("$dataset" =~ *leftAI*) then
        set mask = $mask_leftAI
    else if ("$dataset" =~ *rightAI*) then
        set mask = $mask_rightAI
    else
        echo "WARNING: Unknown dataset type for $map. Skipping..." | tee -a $combined_cluster_file
        continue
    endif

    # Extract the base name for the dataset
    set basename = `basename $dataset`

    # Define an output subdirectory for this dataset with p-value suffix
    set dataset_output_dir = "${output_dir}/${basename}_p0-001"

    # Define the maps directory for clusterized results
    set maps_dir = "${dataset_output_dir}_maps"

    # Ensure the output directory and maps directory are created
    if (! -d $dataset_output_dir) then
        echo "Creating output directory: $dataset_output_dir" | tee -a $combined_cluster_file
        mkdir -p $dataset_output_dir
    endif

    if (! -d $maps_dir) then
        echo "Creating maps directory: $maps_dir" | tee -a $combined_cluster_file
        mkdir -p $maps_dir
    endif

    echo "Processing $map with residuals $residuals and mask $mask..." | tee -a $combined_cluster_file

    ######################################################
    # Step 1: Estimate spatial smoothness
    ######################################################
    echo "Estimating spatial smoothness..." | tee -a $combined_cluster_file
    set smoothness_output = "${dataset_output_dir}/smoothness_params.txt"

    3dFWHMx -acf -mask $mask -input $residuals -out "${dataset_output_dir}/smoothness_acf.1D" > $smoothness_output

    # Append 3dFWHMx outputs to combined_cluster_file
    cat $smoothness_output >>& $combined_cluster_file

    if (! -e $smoothness_output) then
        echo "ERROR: Smoothness parameters file was not created: $smoothness_output" | tee -a $combined_cluster_file
        continue
    endif

    # Extract ACF parameters
    set acf_params = (`awk 'NR==2 {print $1, $2, $3}' $smoothness_output`)
    if ("$acf_params" == "") then
        echo "ERROR: ACF parameters could not be extracted. Skipping $map..." | tee -a $combined_cluster_file
        continue
    endif
    echo "ACF parameters extracted: $acf_params" | tee -a $combined_cluster_file

    ######################################################
    # Step 2: Perform cluster simulation
    ######################################################
    echo "Running cluster simulation..." | tee -a $combined_cluster_file
    set clustsim_output_prefix = "${maps_dir}/clustsim_results_0-001"

    3dClustSim -acf $acf_params -mask $mask -prefix $clustsim_output_prefix >& "${dataset_output_dir}/3dClustSim_output.log"

    # Append 3dClustSim outputs to combined_cluster_file
    cat "${dataset_output_dir}/3dClustSim_output.log" >>& $combined_cluster_file

    # Check if cluster simulation file was created
    set clustsim_file = "${clustsim_output_prefix}.NN2_1sided.1D"
    if (! -e $clustsim_file) then
        echo "ERROR: Cluster simulation file was not created: $clustsim_file" | tee -a $combined_cluster_file
        continue
    endif

    ######################################################
    # Step 3: Extract minimum cluster size
    ######################################################
    echo "Extracting cluster size threshold for NN2 at p=0.001 with alpha=0.05..." | tee -a $combined_cluster_file
    set clust_thresh = (`awk '$1 == 0.001 {print $3}' $clustsim_file`)

    if ("$clust_thresh" == "") then
        echo "ERROR: Cluster size threshold could not be extracted. Skipping $map..." | tee -a $combined_cluster_file
        continue
    endif
    echo "Minimum cluster size extracted: $clust_thresh voxels" | tee -a $combined_cluster_file

    ######################################################
    # Step 4: Clusterizing t-statistics
    #    Always sub-bricks 5, 7, 9 with these labels
    ######################################################
    set subbricks = (5 7 9)
    set labels    = ("LKM_vs_PMR_t" "MainEffect_t" "Interaction_t")

    # If you still want to rename the MainEffect_t to reflect GroupLoneliness or GroupEmpathy,
    # you can keep or remove this block as needed. Otherwise, comment it out or remove it.

    if ("$dataset" =~ *GroupLoneliness*) then
        # For sub-brick #7 which is labels[2], rename to "Loneliness_t"
        set labels[2] = "Loneliness_t"
    else if ("$dataset" =~ *GroupEmpathy*) then
        # For sub-brick #7 which is labels[2], rename to "Empathy_t"
        set labels[2] = "Empathy_t"
    endif

    @ i = 1
    foreach subbrick ($subbricks)
        set label = $labels[$i]
        echo "Processing sub-brick index: $subbrick ($label)..." | tee -a $combined_cluster_file

        set cluster_table_file = ${dataset_output_dir}/cluster_table_${label}.txt

        # Run 3dClusterize
        3dClusterize -inset $map \
                     -mask $mask \
                     -ithr $subbrick \
                     -idat $subbrick \
                     -bisided p=0.001 \
                     -clust_nvox $clust_thresh \
                     -NN 2 \
                     -pref_map ${dataset_output_dir}/cluster_map_${label} \
                     -pref_dat $cluster_table_file >& "${dataset_output_dir}/3dClusterize_${label}.log"

        # Append 3dClusterize outputs to combined_cluster_file
        cat "${dataset_output_dir}/3dClusterize_${label}.log" >>& $combined_cluster_file

        if ($status != 0) then
            echo "ERROR: 3dClusterize failed for $label. Check inputs and outputs." | tee -a $combined_cluster_file
            continue
        endif

        # Append cluster table content to the combined file
        if (-e $cluster_table_file) then
            echo "\n### Results for $label (${basename}) ###\n" | tee -a $combined_cluster_file
            cat $cluster_table_file >>& $combined_cluster_file
        else
            echo "\n### No clusters found for $label (${basename}) ###\n" | tee -a $combined_cluster_file
        endif

        echo "Clusterized map and table saved for: $label" | tee -a $combined_cluster_file
        @ i++
    end

    echo "Processing complete for $map." | tee -a $combined_cluster_file
end

echo "Pipeline complete. Combined SEM tables saved in: $combined_cluster_file." | tee -a $combined_cluster_file
