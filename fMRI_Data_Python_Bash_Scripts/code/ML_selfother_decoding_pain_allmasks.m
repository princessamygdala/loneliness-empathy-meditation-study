addpath('/usr/local/bin/matlab') 

% Set defaults and define subjects
KOsubjects = {'sub-001', 'sub-002', 'sub-003', 'sub-004', 'sub-005', 'sub-006', 'sub-007', 'sub-008', 'sub-014', 'sub-018', 'sub-031', 'sub-034', 'sub-039', 'sub-043', 'sub-050', 'sub-052', 'sub-053', 'sub-057', 'sub-058', 'sub-063', 'sub-064', 'sub-067', 'sub-071', 'sub-074', 'sub-075', 'sub-076', 'sub-081', 'sub-088', 'sub-102', 'sub-106', 'sub-109', 'sub-115', 'sub-119', 'sub-122', 'sub-130', 'sub-136', 'sub-139', 'sub-149', 'sub-154', 'sub-156', 'sub-158', 'sub-159', 'sub-167', 'sub-169', 'sub-179', 'sub-180', 'sub-187', 'sub-191', 'sub-192', 'sub-193', 'sub-194', 'sub-195', 'sub-196', 'sub-197'};

% Get list of all mask files
mask_folder = '/my/path/ML_masks/';
mask_files = [dir(fullfile(mask_folder, '*_resampled+tlrc.BRIK')), dir(fullfile(mask_folder, '*_resampled+tlrc.BRIK.gz'))];

for k = 1:length(KOsubjects)
    cursub = KOsubjects{k};

    addpath('/usr/local/bin/matlab') 
    addpath('/my/path/Applications/decoding_toolbox');
    addpath('/my/path/Applications/afni_matlab-master/src/');
    addpath('/my/path/Applications/libsvm-3.35/matlab'); 

    for m = 1:length(mask_files)
        mask_file = fullfile(mask_folder, mask_files(m).name);
        [~, mask_name, ext] = fileparts(mask_files(m).name);

        % Handle .gz files: Always use the .BRIK version
        if strcmp(ext, '.gz')
            unzipped_mask_file = fullfile(mask_folder, mask_name);
            if ~exist(unzipped_mask_file, 'file')
                fprintf('Unzipping %s...\n', mask_file);
                gunzip(mask_file);
            end
            mask_file = unzipped_mask_file;  % Ensure .BRIK file is used
        end

        % Set up decoding configuration
        decoding_defaults;
        cfg.software = 'afni';
        cfg.analysis = 'searchlight';
        cfg.results.dir = sprintf('/my/path/MVPAresults_pain/%s/%s', mask_name, cursub);
        if ~exist(cfg.results.dir, 'dir'), mkdir(cfg.results.dir); end
        
        % Handle beta files (compressed and uncompressed)
        beta_loc_uncompressed = sprintf('/my/path/3dLSS/%s/%s_task-empathy_self-other-pain-combined_space-MNI152NLin6Asym_LSS+tlrc.BRIK', cursub, cursub);
        beta_loc_compressed = sprintf('/my/path/3dLSS/%s/%s_task-empathy_self-other-pain-combined_space-MNI152NLin6Asym_LSS+tlrc.BRIK.gz', cursub, cursub);
        if exist(beta_loc_uncompressed, 'file')
            beta_loc = beta_loc_uncompressed;
        elseif exist(beta_loc_compressed, 'file')
            gunzip(beta_loc_compressed);  % Unzip if compressed
            beta_loc = beta_loc_uncompressed;
        else
            error('Beta file not found: %s or %s', beta_loc_uncompressed, beta_loc_compressed);
        end

        cfg.files.mask = mask_file;
        cfg.files.twoway = 1;
        
        regressor_names = design_from_afni(beta_loc);
        labelname1a = 'self_pain*';
        labelname2a = 'self_no_pain*';
        labelname1b = 'other_pain*';
        labelname2b = 'other_no_pain*';

        cfg = decoding_describe_data(cfg, {labelname1a, labelname2a, labelname1b, labelname2b}, [1 -1 1 -1], regressor_names, beta_loc, [1 1 2 2]);
        cfg.design = make_design_xclass(cfg);

        % Set searchlight and results parameters
        cfg.searchlight.unit = 'voxels';
        cfg.searchlight.radius = 3;
        cfg.searchlight.spherical = 0;

        % Ensure unbalanced data handling
        cfg.verbose = 0;
        cfg.design.unbalanced_data = 'ok';

        % Set decoding method and output settings
        cfg.decoding.method = 'classification_kernel';
        cfg.results.output = {'accuracy_minus_chance', 'AUC_minus_chance', 'dprime', 'specificity_minus_chance', 'sensitivity_minus_chance'};
        cfg.results.overwrite = 1;
        cfg.results.write = 1;

        % Run decoding analysis
        results = decoding(cfg);

        % Clean up unzipped file if it was unzipped
        if strcmp(ext, '.gz') && exist(unzipped_mask_file, 'file')
            delete(unzipped_mask_file);
        end
    end
end