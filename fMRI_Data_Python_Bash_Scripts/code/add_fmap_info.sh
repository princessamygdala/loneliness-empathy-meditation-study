#!/bin/bash

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

SUB_DIR='/my/path/fMRIData/subjects'

# Add IntendedFor field in fmap .json files
chmod -R 664 ${SUB_DIR}/sub-${SUBID}/fmap/*.json # file permission 

if ! [ "${SUBID}" -eq 1015 ]; then

    ## WE DONT NEED THIS ANYMORE BECAUSE WE SPECIFIED SELF/OTHER IN MRI CONSOLE
    # get task order from csv file
    # task_order=$(python3 /my/path/fMRIData/code/get_task_order.py ${SUBID})
    ## WE DONT NEED THIS ANYMORE BECAUSE WE SPECIFIED SELF/OTHER IN MRI CONSOLE

    for type in magnitude1 magnitude2 phasediff; do
        selfpain_file="${SUB_DIR}/sub-${SUBID}/fmap/sub-${SUBID}_run-01_${type}.json"
        otherpain_file="${SUB_DIR}/sub-${SUBID}/fmap/sub-${SUBID}_run-02_${type}.json"
        fmapsolo_file="${SUB_DIR}/sub-${SUBID}/fmap/sub-${SUBID}_${type}.json"

        # self pain
        if grep -q "IntendedFor" "${selfpain_file}"; then
            echo "Replacing IntendedFor field in ${selfpain_file}"
            sed -i 's/"IntendedFor".*/"IntendedFor": ["func\/sub-'${SUBID}'_task-empathy_run-01_bold.nii.gz"],/' "${selfpain_file}"
        else
            echo "Adding IntendedFor field in ${selfpain_file}"
            sed '/"InstitutionName": "Georgetown University Medical Center",/a\  "IntendedFor": ["func/sub-'${SUBID}'_task-empathy_run-01_bold.nii.gz"],' "${selfpain_file}" > "${selfpain_file}.tmp" && mv "${selfpain_file}.tmp" "${selfpain_file}"
        fi

        # other pain
        if grep -q "IntendedFor" "${otherpain_file}"; then
            echo "Replacing IntendedFor field in ${otherpain_file}"
            sed -i 's/"IntendedFor".*/"IntendedFor": ["func\/sub-'${SUBID}'_task-empathy_run-02_bold.nii.gz"],/' "${otherpain_file}"
        else
            echo "Adding IntendedFor field in ${otherpain_file}"
            sed '/"InstitutionName": "Georgetown University Medical Center",/a\  "IntendedFor": ["func/sub-'${SUBID}'_task-empathy_run-02_bold.nii.gz"],' "${otherpain_file}" > "${otherpain_file}.tmp" && mv "${otherpain_file}.tmp" "${otherpain_file}"
        fi

        # if there is just one fmap
        if grep -q "IntendedFor" "${fmapsolo_file}"; then
            echo "Replacing IntendedFor field in ${fmapsolo_file}"
            sed -i 's/"IntendedFor".*/"IntendedFor": ["func\/sub-'${SUBID}'_task-empathy_run-01_bold.nii.gz","func\/sub-'${SUBID}'_task-empathy_run-02_bold.nii.gz"],/' "${fmapsolo_file}"
        else
            echo "Adding IntendedFor field in ${fmapsolo_file}"
            sed '/"InstitutionName": "Georgetown University Medical Center",/a\  "IntendedFor": ["func\/sub-'${SUBID}'_task-empathy_run-01_bold.nii.gz","func/sub-'${SUBID}'_task-empathy_run-02_bold.nii.gz"],' "${fmapsolo_file}" > "${fmapsolo_file}.tmp" && mv "${fmapsolo_file}.tmp" "${fmapsolo_file}"
        fi
    done
fi

# Remove the backup and temporary files if they exist
find "${SUB_DIR}" -type f -name "*.tmp" -exec rm -f {} +

#cd MD/MindAndLife/fMRIData/code