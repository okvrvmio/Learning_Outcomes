/*
# Do name: Results (1) Regressions

# Purpose of script: Runs Regressions for analysis

# Authors: Kiran Ferrini

# Date Created: May 14, 2023
*/


clear all //Removes any existing data from memory
set more off, permanently //Tells stata to continue working through the rest of the program even if the results are larger than the display screen

cd "INSERTFILEPATHHERE\CodeDocumentation\data" //set wd to code folder


capture log close //Closes any previously running log files
set logtype text //Changes the format of the log file to one that is easy to read 
capture log using "regressions", replace // Change logname to the desired file name 


/*Write or copy your commands below this line*/

*import data 
import excel "$raw\sle_merged_altered.xlsx", firstrow clear



*generate euclidian distance to office from school requires `geodist' package
geodist office_lat office_lon school_lat school_lon, gen(distance_office) sphere

*save control covariates, subindicators
ds absence_rate student_attendance students_enrolled content_proficiency ecd_student_proficiency infrastructure teach_score operational_management instructional_leadership principal_knowledge_score principal_management teacher_attraction teacher_selection_deployment teacher_support teaching_evaluation teacher_monitoring intrinsic_motivation standards_monitoring sch_monitoring sch_management_clarity sch_management_attraction sch_selection_deployment sch_support principal_evaluation light_GDP 
local covariates `r(varlist)'

* Arithmetic Means
ds bureaucratic_efficiency impartial_decision_making quality_bureaucracy mandates_accountability national_learning_goals
local subindicators `r(varlist)'
	foreach x of local subindicators {
		regress student_knowledge `x', robust // Basic OLS Regression
		outreg2 using `x'.tex, replace ctitle(Basic) nocons ci label dec(2)
		
		regress student_knowledge `x' `covariates', robust //  OLS With Controls
		outreg2 using `x'.tex, append ctitle(Controls) nocons ci label dec(2)
		
		ivregress 2sls student_knowledge (`x' = distance_office) `covariates', robust first  //distance to district office as iv 
		outreg2 using `x'.tex, append ctitle(District IV) nocons ci label dec(2)
}


* Weighted Aggregation
ds bureaucratic_efficiency_cw impartial_decision_making_cw quality_bureaucracy_cw mandates_accountability_cw national_learning_goals_cw
local subindicators `r(varlist)'
	foreach x of local subindicators {
		regress student_knowledge `x', robust // Basic OLS Regression
		outreg2 using `x'.tex, replace ctitle(Basic) nocons ci label dec(2)
		
		regress student_knowledge `x' `covariates', robust //  OLS With Controls 
		outreg2 using `x'.tex, append ctitle(Controls) nocons ci label dec(2)
		
		ivregress 2sls student_knowledge (`x' = distance_office) `covariates', robust first  //distance to district office as iv 
		outreg2 using `x'.tex, append ctitle(District IV) nocons ci label dec(2) 
}

* Quasi-Arithmetic Means
ds bureaucratic_efficiency_quas impartial_decision_making_quas quality_bureaucracy_quas mandates_accountability_quas national_learning_goals_quas
local subindicators `r(varlist)'
	foreach x of local subindicators {
		regress student_knowledge `x', robust // Basic OLS Regression 
		outreg2 using `x'.tex, replace ctitle(Basic) nocons ci label dec(2)
		
		regress student_knowledge `x' `covariates', robust //  OLS With Controls 
		outreg2 using `x'.tex, append ctitle(Controls) nocons ci label dec(2)
		
		ivregress 2sls student_knowledge (`x' = distance_office) `covariates', robust first  //distance to district office as iv 
		outreg2 using `x'.tex, append ctitle(District IV) nocons ci label dec(2) 
}

* Quasi-Arithmetic Means and Weighted Aggregation
ds bureaucratic_efficiency_alt impartial_decision_making_alt quality_bureaucracy_alt mandates_accountability_alt national_learning_goals_alt
local subindicators `r(varlist)'
	foreach x of local subindicators {
		regress student_knowledge `x', robust // Basic OLS Regression
		outreg2 using `x'.tex, replace ctitle(Basic) nocons ci label dec(2)
		
		regress student_knowledge `x' `covariates', robust //  OLS With Controls
		outreg2 using `x'.tex, append ctitle(Controls) nocons ci label dec(2)
		
		ivregress 2sls student_knowledge (`x' = distance_office) `covariates', robust first  //distance to district office as iv 
		outreg2 using `x'.tex, append ctitle(District IV) nocons ci label dec(2) 
}

* first stages 
ds bureaucratic_efficiency impartial_decision_making quality_bureaucracy mandates_accountability national_learning_goals
local subindicators `r(varlist)'

ds absence_rate student_attendance students_enrolled content_proficiency ecd_student_proficiency infrastructure teach_score operational_management instructional_leadership principal_knowledge_score principal_management teacher_attraction teacher_selection_deployment teacher_support teaching_evaluation teacher_monitoring intrinsic_motivation standards_monitoring sch_monitoring sch_management_clarity sch_management_attraction sch_selection_deployment sch_support principal_evaluation light_GDP 
local covariates `r(varlist)'	
	
regress bureaucratic_efficiency distance_office `covariates', robust
outreg2 using firststage.tex, replace ctitle(BE) nocons label dec(2) addstat("F-Stat",e(F),"Prob > F",e(p),"Degree of Freedom",e(df_r))
		
regress impartial_decision_making distance_office `covariates', robust
outreg2 using firststage.tex, append ctitle(IDM) nocons label dec(2) addstat("F-Stat",e(F),"Prob > F",e(p),"Degree of Freedom",e(df_r))

regress quality_bureaucracy distance_office `covariates', robust
outreg2 using firststage.tex, append ctitle(QOB) nocons label dec(2) addstat("F-Stat",e(F),"Prob > F",e(p),"Degree of Freedom",e(df_r))

regress mandates_accountability distance_office `covariates', robust
outreg2 using firststage.tex, append ctitle(MA) nocons label dec(2) addstat("F-Stat",e(F),"Prob > F",e(p),"Degree of Freedom",e(df_r))

regress national_learning_goals distance_office `covariates', robust
outreg2 using firststage.tex, append ctitle(NLG) nocons label dec(2) addstat("F-Stat",e(F),"Prob > F",e(p),"Degree of Freedom",e(df_r))


capture log close //Don't delete or modify this line - it closes the log and completes it for submission
