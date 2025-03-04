#!/bin/bash

#bids_root_dir = "/my/path/fMRIData/"
nthreads=2
mem=10 #gb

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


### THIS IS PARTICIPANT LEVEL!!!!!!!!!!!!!!!!!!


#singularity run /my/path/fMRIData/mriqc-0.15.1.simg \
  #/my/path/fMRIData/ /my/path/fMRIData/derivatives/mriqc/sub-${SUBID} \
  #participant \
singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /my/path/fMRIData/mriqc-0.15.1.simg "/my/path/fMRIData/subjects" "/my/path/fMRIData/subjects/derivatives/mriqc" participant \
  --participant_label $SUBID \
  --n_proc $nthreads \
  --hmc-fsl \
  --verbose-reports \
  --correct-slice-timing \
  --mem_gb $mem \
  --float32 \
  --ants-nthreads $nthreads \
  -w /my/path/fMRIData/derivatives/mriqc/sub-${subj}
