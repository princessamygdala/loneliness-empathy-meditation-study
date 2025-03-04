#!/bin/bash

#bids_root_dir = "/my/path/fMRIData/"
nthreads=2
mem=10 #gb


### THIS IS GROUP LEVEL!!!!!!!!!!!!!!!!!!


#singularity run /my/path/fMRIData/mriqc-0.15.1.simg \
  #/my/path/fMRIData/ /my/path/fMRIData/derivatives/mriqc/sub-${SUBID} \
  #participant \
singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /my/path/fMRIData/mriqc-0.15.1.simg "/my/path/fMRIData/subjects" "/my/path/fMRIData/subjects/derivatives/mriqc" group \
  --n_proc $nthreads \
  --hmc-fsl \
  --correct-slice-timing \
  --mem_gb $mem \
  --float32 \
  --ants-nthreads $nthreads \
  --verbose-reports \
  -w /my/path/fMRIData/derivatives/mriqc/sub-${subj}
