#!/bin/bash

# This script runs fmriprep for a single subject
# Last updated by MD: (November 19, 2024)
#/my/path/fMRIData/code/run_fmriprep-23.0.0.sh -s "031"
# ./run_fmriprep-23.0.0.sh -s "005"

usage() { echo "Usage: $0 [-s <subID>]" 1>&2; exit 1; }

while getopts ":s:" option; do
	case "${option}" in
		s)
			SUBID=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

if [ -z "${SUBID}" ]; then
    usage
fi

echo $SUBID

# OLD: singularity run --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/fmriprep-23.0.0.simg "/mnt/LSANdata/Mind & Life/fMRI Data/subjects" "/mnt/LSANdata/Mind & Life/fMRI Data/subjects/derivatives" participant \
singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/fmriprep-23.0.0.simg "/my/path/fMRIData/subjects" "/my/path/fMRIData/subjects/derivatives" participant \
--work-dir /my/path/fMRIData/fmriprep-23.0.0_work \
--participant_label $SUBID \
--bold2t1w-dof 9 \
--output-spaces T1w:res-native MNI152NLin2009cAsym:res-native MNI152NLin6Asym:res-native fsaverage:res-native \
--skull-strip-t1w force \
--use-aroma \
--fs-license-file /mnt/LSANdata/SR/tools/freesurfer/license.txt \
--no-submm-recon \
--write-graph \
--fd-spike-threshold 0.5 \
--random-seed 2021


#--skip_bids_validation \