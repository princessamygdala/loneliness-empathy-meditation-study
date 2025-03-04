#/!bin/bash
# USAGE: `convert2bids.sh -s 004`
# Last updated by MD: (November 19, 2023)

# Initialize options
usage() { echo "Invalid option: $0 [-s <Subject ID Number>]" 1>&2; exit 1; }
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

RAW_DIR='/my/path/fMRIData/rawdata'
SUB_DIR='/my/path/fMRIData/subjects/meep'

# unzip archive with raw dicoms
# unzip ${RAW_DIR}/ML${SUBID}/*/*.zip -d ${RAW_DIR}/ML${SUBID}/

# unzip
# unzip /my/path/fMRIData/rawdata/ML{subject}/*/*.zip -d /my/path/fMRIData/rawdata/ML{subject}

## convert dcm2niix in BIDS format

# get tsv
# heudiconv -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -o /my/path/fMRIData/subjects -f convertall -s ${SUBID} -c none --overwrite

# Running the above script in the terminal did not work. It needs to be run in singularity
#singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f convertall -s ${SUBID} -c none --overwrite --minmeta

# once you create heuristic.py (e.g., ML_BIDS.py)

 if [[ "${SUBID}" == "001" || "${SUBID}" == "002" || "${SUBID}" == "004" || "${SUBID}" == "014" ]];then
     singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_thumbSelf1Fmap1.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "003" || "${SUBID}" == "006" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_thumbOther1Fmap1.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "005" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_thumbMoreRuns005.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "007" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_selfgreFmap.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "008" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_thumbMoreRuns008.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "009" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_1fmap.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "018" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_MoreRuns018.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "053" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_3fmap.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "067" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_MoreRuns067.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "087" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_MoreRuns087.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "088" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_2selfFmap.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "130" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_MoreRuns130.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
elif [[ "${SUBID}" == "195" ]];then
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS_3fmap_195.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
else
    singularity run --bind /home:/home --bind /mnt:/mnt --cleanenv /mnt/LSANdata/SR/tools/singularity/heudiconv-0.13.0.simg -d /my/path/fMRIData/rawdata/ML{subject}/*/*dcm -b -o /my/path/fMRIData/subjects -f /my/path/fMRIData/code/ML_BIDS.py -s ${SUBID} -c dcm2niix --overwrite --minmeta
fi


#./add_fmap_info.sh -s ${SUBID}


# cd LSANdata/MD/MindAndLife/fMRIData/code