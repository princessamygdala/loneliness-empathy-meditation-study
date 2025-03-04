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

    phase_self = create_key('sub-{subject}/fmap/sub-{subject}_run-01_phasediff')
    mag_self = create_key('sub-{subject}/fmap/sub-{subject}_run-01_magnitude')

    phase_other = create_key('sub-{subject}/fmap/sub-{subject}_run-02_phasediff')
    mag_other = create_key('sub-{subject}/fmap/sub-{subject}_run-02_magnitude')

    fmap_info = {'self':[],
                 'other':[]}

    info = {
            t1w_high_res: [],
            task_self: [],
            task_other: [],
            phase_self : [],
            mag_self  : [],
            phase_other : [],
            mag_other  : []
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

        # ANATOMICAL 
        if ('MPRAGE' in s.protocol_name) and ('ND' in s.series_description):
            info[t1w_high_res] = [s.series_id]

        # RUN SELF
        if ('self-pain' in s.series_description) and ('field_map' not in s.protocol_name):
            info[task_self] = [s.series_id]

        # RUN OTHER
        if ('other-pain' in s.series_description) and ('field_map' not in s.protocol_name):
            info[task_other] = [s.series_id]

        # GET FMAP INFO, BUT DON"T ADD TO INFO YET
        if ('self_gre_field_mapping' in s.series_description) and ('ND' in s.series_description):
            fmap_info['self'].append(s)

        if ('gre_field_mapping' in s.series_description) and ('self' not in s.series_description) and ('ND' in s.series_description):   
            fmap_info['other'].append(s)
    
    if len(fmap_info['self']) == 2:
        if fmap_info['self'][0].total_files_till_now > fmap_info['self'][1].total_files_till_now:
            # phase image is first
            info[phase_self] = [fmap_info['self'][0].series_id]
            info[mag_self] = [fmap_info['self'][1].series_id]
        else:
            # phase image is second
            info[phase_self] = [fmap_info['self'][1].series_id]
            info[mag_self] = [fmap_info['self'][0].series_id]
    else:
        raise Exception('Wrong number of fieldmaps for self-pain run')
    
    if len(fmap_info['other']) == 2:
        if fmap_info['other'][0].total_files_till_now > fmap_info['other'][1].total_files_till_now:
            # phase image is first
            info[phase_other] = [fmap_info['other'][0].series_id]
            info[mag_other] = [fmap_info['other'][1].series_id]
        else:
            # phase image is second
            info[phase_other] = [fmap_info['other'][1].series_id]
            info[mag_other] = [fmap_info['other'][0].series_id]
    else:
        raise Exception('Wrong number of fieldmaps for other-pain run')

    return info