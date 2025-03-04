# convert_BIDs.py

import os

def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


def infotodict(seqinfo):
    """Heuristic evaluator for determining which tasks belong where
    allowed template fields - follow python string module:
    item: index within category
    subject: participant id
    seqitem: task number during scanning
    subindex: sub index within group
    """

    t1w_high_res = create_key('sub-{subject}/anat/sub-{subject}_acq-highres_T1w')

    task_self = create_key('sub-{subject}/func/sub-{subject}_task-empathy_run-01_bold')
    task_other = create_key('sub-{subject}/func/sub-{subject}_task-empathy_run-02_bold')

    phase = create_key('sub-{subject}/fmap/sub-{subject}_phasediff')
    mag = create_key('sub-{subject}/fmap/sub-{subject}_magnitude')

    info = {
            t1w_high_res: [],
            task_self: [],
            task_other: [],
            phase : [],
            mag : [],
            }

    for s in seqinfo:
        """
        The namedtuple `s` contains the following fields:
        * total_files_till_now
        * example_dcm_file
        * series_id
        * dcm_dir_name
        * unspecified2
        * unspecified3
        * dim1
        * dim2
        * dim3
        * dim4
        * TR
        * TE
        * protocol_name
        * is_motion_corrected
        * is_derived
        * patient_id
        * study_description
        * referring_physician_name
        * series_description
        * image_type
        """
        # anatomical 
        if (s.dim3 == 176) and ('MPRAGE' in s.protocol_name):
            info[t1w_high_res] = [s.series_id]

        # SELF
        if ('Thumb' in s.protocol_name) and ('ND' in s.series_description) and ('2' in s.series_description):
            info[task_self] = [s.series_id]

        # OTHER
        if ('Thumb' in s.protocol_name) and ('ND' in s.series_description) and ('1' in s.series_description) and (s.total_files_till_now > 30):
            info[task_other] = [s.series_id]

        
        # FIELD MAP
        if ('gre_field_mapping' in s.series_id) and ('ND' in s.series_description) and (s.total_files_till_now <9):
            info[mag] = [s.series_id]

        if ('gre_field_mapping' in s.series_id) and ('ND' in s.series_description) and (s.total_files_till_now >8):
            info[phase] = [s.series_id]

    return info