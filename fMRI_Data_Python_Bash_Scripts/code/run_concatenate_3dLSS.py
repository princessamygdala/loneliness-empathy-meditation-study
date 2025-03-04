import os
import glob
import subprocess

# Define the base directory
base_dir = '/my/path/fMRIData/mvpa/3dLSS'

# Get a list of all subject directories
subject_dirs = glob.glob(os.path.join(base_dir, 'sub-*'))

# Define task-specific parameters
tasks = {
    "pain": {
        "files": [
            "selfpain",
            "selfnopain",
            "otherpain",
            "othernopain"
        ],
        "output_suffix": "self-other-pain-combined"
    },
    "anticipation": {
        "files": [
            "selfpainanticipation",
            "selfneutralanticipation",
            "otherpainanticipation",
            "otherneutralanticipation"
        ],
        "output_suffix": "self-other-anticipation-combined"
    }
}

# Loop through each subject directory
for subject_dir in subject_dirs:
    subject_num = os.path.basename(subject_dir).split('-')[1]

    # Process each task
    for task, task_params in tasks.items():
        # Get the file paths for the current task
        input_files = [
            os.path.join(subject_dir, f"sub-{subject_num}_task-empathy_{file}_space-MNI152NLin2009cAsym_LSS.nii.gz")
            for file in task_params["files"]
        ]

        # Define the output file name
        output_file = os.path.join(
            subject_dir,
            f"sub-{subject_num}_task-empathy_{task_params['output_suffix']}_space-MNI152NLin2009cAsym_LSS.nii.gz"
        )

        # Concatenate the input files using 3dTcat
        subprocess.run(['3dTcat', '-prefix', output_file] + input_files)

        # Convert the nii.gz file to BRIK/HEAD format using 3dcopy
        subprocess.run(['3dcopy', output_file, output_file.replace('.nii.gz', '')])
