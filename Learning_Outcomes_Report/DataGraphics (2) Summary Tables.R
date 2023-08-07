# ---------------------------
#
# Script name: DataGraphics (2) Summary Tables
#
# Purpose of script: This script generates some of the tables used for our summary statistics outputs them into LATEX.
#
# Authors: Kalahan Hughes
#
# Date Created: April 19, 2023
#
# Noteable Variables: 
# 'national_learning_goals','impartial_decision_making','mandates_accountability','quality_bureaucracy' are all indicies for public offical opinion.
# 'student_proficient','student_knowledge' both are measures from a random fourth grade class being tested on reading and math.
# 'infrastructure','inputs' are measures of inputs that go into the school such as pencils and pens, and 'infrastructure' is a measure of infrastructure
# ---------------------------
library(vtable)
library(tidyverse)
library(here)
library(stats)

sle = dist_included

data = sle %>% select( absence_rate ,  student_attendance ,  students_enrolled ,  content_proficiency , ecd_student_proficiency ,
                       infrastructure , teach_score , operational_management , instructional_leadership , principal_knowledge_score ,
                       principal_management ,  teacher_attraction , teacher_selection_deployment , teacher_support ,
                       teaching_evaluation , teacher_monitoring , intrinsic_motivation ,  standards_monitoring ,  sch_monitoring ,
                       sch_management_clarity ,  sch_management_attraction ,  sch_selection_deployment ,  sch_support ,  principal_evaluation ,
                       light_GDP , student_knowledge , national_learning_goals ,  mandates_accountability ,  impartial_decision_making , quality_bureaucracy  , bureaucratic_efficiency , national_learning_goals_cw , mandates_accountability_cw ,  impartial_decision_making_cw , quality_bureaucracy_cw , bureaucratic_efficiency_cw ,  national_learning_goals_alt ,  mandates_accountability_alt ,  impartial_decision_making_alt , quality_bureaucracy_alt , bureaucratic_efficiency_alt,distance_office )
#next step is ensuring that i dont have a blank group when grouping by students enrolled
data[data == ""] = NA  
datacomplete = complete.cases(data)
data = data[datacomplete,]

sumtable(data,vars = c("absence_rate", "student_attendance", "students_enrolled", "content_proficiency","ecd_student_proficiency",
                          "infrastructure","teach_score","operational_management","instructional_leadership","principal_knowledge_score",
                          "principal_management", "teacher_attraction","teacher_selection_deployment","teacher_support",
                          "teaching_evaluation","teacher_monitoring","intrinsic_motivation", "standards_monitoring", "sch_monitoring",
                          "sch_management_clarity", "sch_management_attraction", "sch_selection_deployment", "sch_support", "principal_evaluation",
                          "light_GDP","student_knowledge"), group.long = TRUE,title = "Summary Stats for Sierra Leone Schools Controlsd and Student Knowledge",out = 'latex')
sumtable(data,vars = c('national_learning_goals', 'mandates_accountability', 'impartial_decision_making','quality_bureaucracy' ,'bureaucratic_efficiency','national_learning_goals_cw','mandates_accountability_cw', 'impartial_decision_making_cw','quality_bureaucracy_cw','bureaucratic_efficiency_cw', 'national_learning_goals_alt','mandates_accountability_alt', 'impartial_decision_making_alt','quality_bureaucracy_alt','bureaucratic_efficiency_alt'), group.long = TRUE,title = "Summary Stats for Sierra Leone Indices",out = 'latex')

