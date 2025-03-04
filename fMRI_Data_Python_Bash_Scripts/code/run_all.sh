# run scripts you want for all participants
# Last updated by MD: (November 19, 2024)

for subjectID in 001 002 003 004 005 006 007 008 014 018 031 034 039 043 050 052 053 057 058 063 064 067 071 074 075 076 081 088 102 106 109 115 119 122 130 136 139 149 154 156 158 159 167 169 179 180 187 191 192 193 194 195 001 002 003 004 005 006 007 008 014 018 031 034 039 043 050 052 053 057 058 063 064 067 071 074 075 076 081 088 102 106 109 115 119 122 130 136 139 149 154 156 158 159 167 169 179 180 187 191 192 193 194 195 196 197; do
   #./run_1stlevel_smoothed.sh -s $subjectID
   #./run_1stlevel_unsmoothed.sh -s $subjectID
   #./run_3dlss.sh -s $subjectID -c selfpain
   # ./run_3dlss.sh -s $subjectID -c selfnopain
   # ./run_3dlss.sh -s $subjectID -c selfpaincue
   # ./run_3dlss.sh -s $subjectID -c selfneutralcue
   # ./run_3dlss.sh -s $subjectID -c selfpainanticipation
   # ./run_3dlss.sh -s $subjectID -c selfneutralanticipation
   # ./run_3dlss.sh -s $subjectID -c otherpain
   # ./run_3dlss.sh -s $subjectID -c othernopain
   # ./run_3dlss.sh -s $subjectID -c otherpaincue
   # ./run_3dlss.sh -s $subjectID -c otherneutralcue
   # ./run_3dlss.sh -s $subjectID -c otherpainanticipation
   # ./run_3dlss.sh -s $subjectID -c otherneutralanticipation
   #./run_mriqc-0.15.1.simg.sh -s $subjectID
   #./run_GROUP_mriqc-0.15.1.simg.sh -s $subjectID
   #./run_fmriprep-23.0.0.sh -s $subjectID
   #./run_convert2bids.sh -s $subjectID
done

# cd /my/path/fMRIData/code 