Data needed in Raw folder (files marked as "World Bank" are not public):  
GDP_grid_flt.tif (https://ngdc.noaa.gov/eog/dmsp/download_gdp.html)  
g2014_2015_2.geojson (World Bank)   
public_officials_indicators_data (R Workspace - World Bank)  
school_survey_data (R Workspace - World Bank)  
WB_admin_boundaries (R Workspace - Wortld Bank)   
EPDash_linkfile_hashed.csv (World Bank)  

Data generated:  
sle_merged_altered.xlsx

All Files Dependent on First Running:  
DataPrep (1) Relink Reweights


File Structure:  
├── DataPrep (1) Relink Reweights.Rmd          
├── DataGraphics (1) Heatmap.R     		  		           
├── DataGraphics (2) Summary Tables.R     	   
├── Results (1) Regressions.do     		  		    
├── Results (2) LO_DML.ipynb    				
├── Results (3) LO_DML_5Covars.ipynb    		
├── Raw/     						  				 

Variable Definitions:  
absence_rate = m2sbq6_efft==6 | m2sbq6_efft==5 |  teacher_available==2  
student_attendance = m4scq4_inpt/m4scq12_inpt   
content_proficiency = 100*as.numeric(content_knowledge>=80)  
ecd_student_proficiency = 100*as.numeric(student_knowledge>=86.6  
infrastructure = (drinking_water+ functioning_toilet+ internet + class_electricity+ disability_accessibility)  
teach_score = rowMeans(select(.,classroom_culture, instruction, socio_emotional_skills)  
operational_management = 1+vignette_1+vignette_2  
instructional_leadership = 1+0.5 * classroom_observed + 0.5 * classroom_observed_recent + discussed_observation + feedback_observation + lesson_plan_w_feedback)  

principal_knowledge_score = case_when(  
principal_knowledge_avg >0.9 ~ 5,  
(principal_knowledge_avg >0.8 & principal_knowledge_avg<=0.9) ~ 4,  
(principal_knowledge_avg >0.7 & principal_knowledge_avg<=0.8) ~ 3,  
(principal_knowledge_avg >0.6 & principal_knowledge_avg<=0.7) ~ 2,  
(principal_knowledge_avg <=0.6 ) ~ 1  )  

principal_management = (goal_setting+problem_solving)/2  
teacher_attraction = 1+0.8 * teacher_satisfied_job+ .8 * teacher_satisfied_status+.8 * better_teachers_promoted+.8 * teacher_bonus+.8*(1-salary_delays/12))  

teacher_selection_deployment = 1+teacher_selection+teacher_deployment  

teacher_support = pre_service=pre_training_exists+pre_training_useful,  
practicum=pre_training_practicum+pre_training_practicum_lngth,  
in_service=0.5* in_service_exists+0.25* in_servce_lngth+0.25* in_service_classroom  
teacher_support=1+pre_service+practicum+in_service+opportunities_teachers_share  

teaching_evaluation = =1+formally_evaluated+evaluation_content+negative_consequences+positive_consequences  
teacher_monitoring = 1+attendance_evaluated + 1* attendance_rewarded + 1* attendence_sanctions + (1-miss_class_admin)  
intrinsic_motivation = 1+0.8* (0.2* acceptable_absent + 0.2* students_deserve_attention + 0.2*growth_mindset + motivation_teaching+bin_var(m3sdq2_tmna,1)  

standards_monitoring = (standards_monitoring_input* 6+standards_monitoring_infrastructure*4)/2  
sch_monitoring = 1+1.5* monitoring_inputs+1.5*monitoring_infrastructure+parents_involved  
sch_management_clarity = 1+ (infrastructure_scfn+materials_scfn)/2+ (hiring_scfn + supervision_scfn)/2 +student_scfn +(principal_hiring_scfn+ principal_supervision_scfn)/2  
sch_management_attraction = (principal_satisfaction+principal_salary_score)/2  

sch_selection_deployment = case_when(  
    (m7sgq2_ssld==2 | m7sgq2_ssld==3 | m7sgq2_ssld==8) ~ 5,  
    (m7sgq2_ssld==6 | m7sgq2_ssld==7) ~ 1,  
    (!(m7sgq2_ssld==6 | m7sgq2_ssld==7) & (m7sgq1_ssld__2==1 | m7sgq1_ssld__3==1 | m7sgq1_ssld__8==1) ) ~ 4,  
    (!(m7sgq2_ssld==6 | m7sgq2_ssld==7) & (m7sgq1_ssld__1==1 | m7sgq1_ssld__4==1 | m7sgq1_ssld__5==1 | m7sgq1_ssld__97==1) ) ~ 3,  
    (m7sgq1_ssld__6==1 | m7sgq1_ssld__7==1 ) ~ 2,   
    TRUE ~ as.numeric(NA))  
    
sch_support = 1+prinicipal_trained+principal_training+principal_used_skills+principal_offered  
principal_evaluation = 1+principal_formally_evaluated+principal_evaluation_multiple+principal_negative_consequences+principal_positive_consequences  
light_GDP = Light GDP is an informal measure of economic activity using light  
