Contact
For any issues or questions, please contact Marla Dressel (md1864@georgetown.edu).

README BEHAVIORAL R SCRIPTS - DATA CLEANING

This script processes and cleans data for the study titled "Loneliness modulates self-reported empathy but not empathic multi-voxel neural response patterns after meditation training." The script follows a structured approach to handle participant responses across multiple time points: the initial screening survey (T1), the 4-week follow-up survey (T2), and the scan day survey. The cleaned data is then saved as CSV files for further analysis.

See details: https://osf.io/2sx3v 


NOTE: We deleted the following columns from the raw data for deidentification purposes: zip code, emails for compensation, IP address, location latitude. 


Screener Survey (T1) - Collected at Week 1 before intervention.
4-Week Survey (T2) - Collected at Week 4 after intervention.
Scan Day Survey & Scan Info - Collected on the day of the fMRI scan.
6 month follow up survey (T2) - Collected at Week 4 after intervention.
Data Structure
The script processes three main datasets:
Screener Survey (T1) - Collected at Week 1 before intervention.
4-Week Survey (T2) - Collected at Week 4 after intervention.
Scan Day Survey & Scan Info - Collected on the day of the fMRI scan.
Data Processing Steps
Each dataset undergoes the following transformations:
1. Import Data
Data is read from CSV files located in the directory specified in path.
Change the path variable to the directory where your data is stored.
2. Gross Cleaning and Initial Exclusions
Participants with incorrect or missing IDs are excluded.
Surveys marked as unfinished are removed.
Duplicate responses are manually excluded based on Response ID
3. Variable Selection
The script extracts relevant survey variables, including:
Social Connectedness Scale (SCS-R)
Loneliness (UCLA)
Empathy (IRI)
Demographics (age, gender, ethnicity, education, employment, income, religion, handedness)
4. Reverse Coding and Mean Calculation
Reverse-scored items are adjusted accordingly.
Mean scores are computed per participant for each measure.
Some variables (e.g., IRI subscales) are separately processed.
5. Exclusion Variables
Attention checks and control questions are included to filter low-quality responses.
6. Data Output
Cleaned data is saved in the clean/ directory as CSV files:
cleandata_T1.csv
cleandata_T2.csv
cleandata_scandaySurvey.csv
cleandata_scandayInfo.csv

_______________________________________________________________________________________________

README BEHAVIORAL R SCRIPTS - DATA ANALYSIS 


This script performs analysis for the study:  
*"Loneliness modulates self-reported empathy but not empathic multi-voxel neural response patterns after meditation training."*  

See details: https://osf.io/2sx3v 

Data Requirements
Expected Data Files
The script loads cleaned data from the following files:

Full Sample Data
cleandata_fullSample_noT3.csv
cleandata_fullSample_noT3_long.csv
cleandata_fullSample_all_long.csv
Scan Sample Data
cleandata_scanSample_noT3.csv
cleandata_scanSample_noT3_long.csv
cleandata_scanSample_all_long.csv

Script Workflow
1. Preliminary Analysis
Loads and preprocesses data
Ensures categorical variables (e.g., GroupID) are properly set as factors
Prepares summary statistics for demographic variables
2. Demographics
Computes group-wise comparisons of age, gender, ethnicity, income, education, and handedness
Performs t-tests and proportion tests with effect sizes (Cohen’s d)
3. Pre-Intervention Analysis
Examines baseline differences in social connectedness, loneliness, empathy (IRI subscales), wellbeing
Computes correlation matrices with Spearman correlations
4. Trait Measures Over Time
Uses linear mixed-effects models (LME) to analyze changes in loneliness, empathy, and social connectedness across time (T1-T3)
Models include:
time × GroupID interaction
Covariates: age, gender, education
5. Subjective Ratings Analysis
Conducts two-sample t-tests on PSI and pain ratings (self/other)
Visualizes results using violin plots with jittered data points
6. State Empathy Analysis
Examines the relationship between state empathy measures and trait empathy, loneliness, social connectedness, IOS
Uses linear models (lm) to assess these associations
7. fMRI Analysis (3dMVM)
Prepares data for AFNI 3dMVM analysis by mean-centering variables
Generates scatter plots with regression lines and density plots for pattern similarity subject values from 3dMVM_allsubjectvalues.csv to see direction of main and interaction effects 

Output Files
Model results saved as .html files (e.g., fitH1a_T3.html)
Statistical summary tables saved as .csv
Figures generated with ggplot2