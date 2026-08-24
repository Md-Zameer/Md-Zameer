clear all
set more off
cd "D:\capex\PLFS_LF_WF\DDI-IND-CSO-PLFS-2020-21"
use "hhfv_201718.dta", clear
egen hhid = concat( qtr_hh_fv visit_hh_fv b1q3_hh_fv b1q1_hh_fv b1q13_hh_fv b1q14_hh_fv b1q15_hh_fv)
gen weight_qtr = .   
replace weight_qtr = MULT_hh_fv /100 if NSS_hh_fv == NSC_hh_fv 
replace weight_qtr = MULT_hh_fv /200 if NSS_hh_fv != NSC_hh_fv
gen weight_annual= weight_qtr/4
gen Statecode = substr( nss_region_hh_fv, 1,2)
save newfile, replace

use "per_fv_201718.dta", clear
egen hhid = concat( quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv)
gen weight_qtr = .
replace weight_qtr = MULT_per_fv/100 if NSS_per_fv == NSC_per_fv
replace weight_qtr = MULT_per_fv/200 if NSS_per_fv != NSC_per_fv
gen weight_annual= weight_qtr/4
gen Statecode = substr( nss_region , 1,2)
tempfile blocks
save `blocks'
clear

use "newfile", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv b4q1_per_fv)

rename ( qtr_hh_fv visit_hh_fv b1q3_hh_fv state_hh_fv b1q5_hh_fv b1q1_hh_fv b1q13_hh_fv b1q14_hh_fv b1q15_hh_fv b3q1_hh_fv b3q3_hh_fv b3q4_hh_fv b4q1_per_fv b4q5_per_fv b4q6_per_fv b5pt1q3_per_fv b5pt1q5_per_fv b5pt2q3_per_fv b5pt2q5_per_fv b6q5_per_fv b6q6_per_fv ) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector Stratum FSU SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace

gen year= "2017-18"
save master_201718, replace

********************************************************
**PLFS_2018-19
*******************************************************
use "HHV1_201819.dta", clear
egen hhid = concat( qtr_hh_rv visit_hh_rv b1q3_hh_rv b1q1_hh_rv b1q13_hh_rv b1q14_hh_rv b1q15_hh_rv)
gen weight_qtr = .   
replace weight_qtr = MULT_hh_rv /100 if NSS_hh_rv == NSC_hh_rv 
replace weight_qtr= MULT_hh_rv /200 if NSS_hh_rv != NSC_hh_rv
gen weight_annual= weight_qtr/4
gen Statecode = substr( nss_region_hh_rv, 1,2)
save newfile_201819, replace

use "PerV1_201819", clear
egen hhid = concat( quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv)
gen weight_qtr = .
replace weight_qtr = MULT_per_fv/100 if NSS_per_fv == NSC_per_fv
replace weight_qtr = MULT_per_fv/200 if NSS_per_fv != NSC_per_fv
gen weight_annual=weight_qtr/4
gen Statecode = substr( nss_region_per_fv , 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_201819", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv b4q1_per_fv)

rename ( qtr_hh_rv visit_hh_rv b1q3_hh_rv state_hh_rv b1q5_hh_rv b1q1_hh_rv b1q13_hh_rv b1q14_hh_rv b1q15_hh_rv b3q1_hh_rv b3q3_hh_rv b3q4_hh_rv b4q1_per_fv b4q5_per_fv b4q6_per_fv b5pt1q3_per_fv b5pt1q5_per_fv b5pt2q3_per_fv b5pt2q5_per_fv b6q5_per_fv b6q6_per_fv ) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector Stratum FSU SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace


gen year= "2018-19"
save master_201819, replace
clear

********************************************************
**PLFS_2019-20
*******************************************************
use "HHFV_201920.dta", clear
egen hhid = concat( qtr_hh_fv visit_hh_fv b1q3_hh_fv b1q1_hh_fv b1q13_hh_fv b1q14_hh_fv b1q15_hh_fv)
gen weight_qtr = .   
replace weight_qtr = MULT_hh_fv /100 if NSS_hh_fv == NSC_hh_fv 
replace weight_qtr = MULT_hh_fv /200 if NSS_hh_fv != NSC_hh_fv
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_hh_fv, 1,2)
save newfile_201920, replace

use "PERFV_201920.dta", clear
egen hhid = concat( quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv)
gen weight_qtr = .
replace weight_qtr = MULT_per_fv/100 if NSS_per_fv == NSC_per_fv
replace weight_qtr = MULT_per_fv/200 if NSS_per_fv != NSC_per_fv
gen weight_annual = weight_qtr/4

gen Statecode = substr( nss_region , 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_201920", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(quarter_per_fv visit_per_fv b1q3_per_fv fsu_per_fv b1q13_per_fv b1q14_per_fv b1q15_per_fv b4q1_per_fv)

rename ( qtr_hh_fv visit_hh_fv b1q3_hh_fv state_hh_fv b1q5_hh_fv b1q1_hh_fv b1q13_hh_fv b1q14_hh_fv b1q15_hh_fv b3q1_hh_fv b3q3_hh_fv b3q4_hh_fv b4q1_per_fv b4q5_per_fv b4q6_per_fv b5pt1q3_per_fv b5pt1q5_per_fv b5pt2q3_per_fv b5pt2q5_per_fv b6q5_per_fv b6q6_per_fv ) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector FSU Stratum SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace

gen year= "2019-20"
save master_201920, replace
clear

********************************************************
**PLFS_2020-21
*******************************************************
use "hhv1_202021.dta", clear
egen hhid = concat( qtr_hhv1 visit_hhv1 b1q3_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1)
  
gen weight_qtr = .   
replace weight_qtr = mult_hhv1 /100 if nss_hhv1 == nsc_hhv1 
replace weight_qtr = mult_hhv1 /200 if nss_hhv1 != nsc_hhv1
gen weight_annual = weight_qtr/4

gen Statecode = substr( nss_region_hhv1, 1,2)
save newfile_202021, replace

use "perv1_202021.dta", clear
egen hhid = concat( qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1)
gen weight_qtr = .   
replace weight_qtr = mult_perv1 /100 if NSS_perv1 == NSC_perv1 
replace weight_qtr = mult_perv1 /200 if NSS_perv1 != NSC_perv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_perv1, 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_202021", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1 b4q1_perv1)

rename (qtr_hhv1 visit_hhv1 b1q3_hhv1 state_hhv1 b1q5_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1 b3q1_hhv1 b3q3_hhv1 b3q4_hhv1 b4q1_perv1 b4q5_perv1 b4q6_perv1 b5pt1q3_perv1 b5pt1q5_perv1 b5pt2q3_perv1 b5pt2q5_perv1 b6q5_perv1 b6q6_perv1) (Quarter Visit Sector State FSU Stratum  Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector Stratum FSU SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace

gen year= "2020-21"
save master_202021, replace


********************************************************
**PLFS_2021-22
*******************************************************
use "hhv1_202122.dta", clear
egen hhid = concat( qtr_hhv1 visit_hhv1 b1q3_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1)
  
gen weight_qtr = .   
replace weight_qtr = mult_hhv1 /100 if nss_hhv1 == nsc_hhv1 
replace weight_qtr = mult_hhv1 /200 if nss_hhv1 != nsc_hhv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_hhv1, 1,2)
save newfile_202122, replace

use "perv1_202122.dta", clear
egen hhid = concat( qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1)
gen weight_qtr = .   
replace weight_qtr = mult_perv1 /100 if NSS_perv1 == NSC_perv1 
replace weight_qtr = mult_perv1 /200 if NSS_perv1 != NSC_perv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_perv1, 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_202122", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1 b4q1_perv1)

rename (qtr_hhv1 visit_hhv1 b1q3_hhv1 state_hhv1 b1q5_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1 b3q1_hhv1 b3q3_hhv1 b3q4_hhv1 b4q1_perv1 b4q5_perv1 b4q6_perv1 b5pt1q3_perv1 b5pt1q5_perv1 b5pt2q3_perv1 b5pt2q5_perv1 b6q5_perv1 b6q6_perv1) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector FSU Stratum SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace

gen year= "2021-22"
save master_202122, replace

********************************************************
**PLFS_2022-23
*******************************************************
use "hhv1_202223.dta", clear
egen hhid = concat( qtr_hhv1 visit_hhv1 b1q3_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1)
  
gen weight_qtr = .   
replace weight_qtr = mult_hhv1 /100 if nss_hhv1 == nsc_hhv1 
replace weight_qtr = mult_hhv1 /200 if nss_hhv1 != nsc_hhv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_hhv1, 1,2)
save newfile_202223, replace

use "perv1_202223.dta", clear
egen hhid = concat( qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1)
gen weight_qtr = .   
replace weight_qtr = mult_perv1 /100 if NSS_perv1 == NSC_perv1 
replace weight_qtr = mult_perv1 /200 if NSS_perv1 != NSC_perv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_perv1, 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_202223", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1 b4q1_perv1)

rename (qtr_hhv1 visit_hhv1 b1q3_hhv1 state_hhv1 b1q5_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1 b3q1_hhv1 b3q3_hhv1 b3q4_hhv1 b4q1_perv1 b4q5_perv1 b4q6_perv1 b5pt1q3_perv1 b5pt1q5_perv1 b5pt2q3_perv1 b5pt2q5_perv1 b6q5_perv1 b6q6_perv1) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector FSU Stratum SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace

gen year= "2022-23"
save master_202223, replace
********************************************************
**PLFS_2023-24
*******************************************************
use "hhv1_202324.dta", clear
egen hhid = concat( qtr_hhv1 visit_hhv1 b1q3_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1)
  
gen weight_qtr = .   	
replace weight_qtr = mult_hhv1 /100 if nss_hhv1 == nsc_hhv1 
replace weight_qtr = mult_hhv1 /200 if nss_hhv1 != nsc_hhv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_hhv1, 1,2)
save newfile_202324, replace

use "perv1_202324.dta", clear
egen hhid = concat( qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1)
gen weight_qtr = .   
replace weight_qtr = mult_perv1 /100 if NSS_perv1 == NSC_perv1 
replace weight_qtr = mult_perv1 /200 if NSS_perv1 != NSC_perv1
gen weight_annual = weight_qtr/4
gen Statecode = substr( nss_region_perv1, 1,2)
tempfile blocks
save `blocks'
clear

use "newfile_202324", clear
merge 1:m hhid using `blocks', nogen
egen perid = concat(qtr_perv1 visit_perv1 b1q3_perv1 b1q1_perv1 b1q13_perv1 b1q14_perv1 b1q15_perv1 b4q1_perv1)

rename (qtr_hhv1 visit_hhv1 b1q3_hhv1 state_hhv1 b1q5_hhv1 b1q1_hhv1 b1q13_hhv1 b1q14_hhv1 b1q15_hhv1 b3q1_hhv1 b3q3_hhv1 b3q4_hhv1 b4q1_perv1 b4q5_perv1 b4q6_perv1 b5pt1q3_perv1 b5pt1q5_perv1 b5pt2q3_perv1 b5pt2q5_perv1 b6q5_perv1 b6q6_perv1) (Quarter Visit Sector State Stratum FSU Hamlet SSS Sample_Hno Household_size Religion Social_group Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS)

keep Quarter Visit Sector FSU Stratum SSS Sample_Hno Household_size Religion Social_group hhid weight_qtr weight_annual Person_seriol_no Gender Age Status_ps NIC_code_ps Status_ss NIC_code_ss CWS NIC_code_CWS perid

destring Sector Household_size Religion Social_group Gender Age , replace


gen year= "2023-24"
save master_202324, replace
clear

*****************************************************
**Append multiple rounds of PLFS
*****************************************************
append using master_201718.dta master_201819.dta master_201920.dta master_202021.dta master_202122 master_202223.dta master_202324.dta 
sort year
save appended_plfs, replace
********************************************************
**refining the data
********************************************************
use "appended_plfs", clear
destring Gender, replace
keep if Gender == 1 | Gender == 2
label define Gender 1 male 2 female
label values Gender Gender
destring Social_group, replace
label define Social_group 1 ST 2 SC 3 OBC 9 Others
label values Social_group Social_group
destring Sector, replace
label define Sector 1 Rural 2 Urban
label values Sector Sector 
*************************************************
***labourforce, by 2 and 5 digit
*************************************************
destring Status_ps Status_ss, replace
gen ps_labourforce = 1 if (Status_ps>=11 & Status_ps<=51) | Status_ps == 81
replace ps_labourforce = 0 if missing(ps_labourforce)
gen ss_labourforce = 1 if (Status_ss >= 11 & Status_ss <= 51)
replace ss_labourforce = 0 if missing(ss_labourforce)

gen nic_two_ps = substr(NIC_code_ps,1, 2)
gen nic_two_ss= substr(NIC_code_ss,1, 2)
gen nic_two_usual_status= nic_two_ps
replace nic_two_usual_status= nic_two_ss if missing(nic_two_ps)

gen laborforce = 1 if ps_labourforce==1 | ss_labourforce==1 
replace laborforce = 0 if missing(laborforce)
gen laborforce_percent = laborforce*100

tab nic_two_usual_status Gender [iw=weight] if Sector==1 & year== "2017-18" & laborforce==1, nof col 

tab nic_two_usual_status Gender [iw=weight] if Sector==1 & year== "2018-19" & laborforce==1

bysort year: tab nic_two_usual_status Gender [iw=weight] if Sector==2 & laborforce==1, nof col
bysort year: tab nic_two_usual_status Gender [iw=weight] if laborforce==1, nof col

gen nic_five_ps = substr(NIC_code_ps,1, 4)
gen nic_five_ss= substr(NIC_code_ss,1, 4)
gen nic_five_usual_status= nic_five_ps
replace nic_five_usual_status= nic_five_ss if missing(nic_five_ps)

tab nic_five_usual_status Gender [iw=weight] if Sector==1 & year== "2018-19" & laborforce==1, nof col
bysort year: tab nic_five_usual_status Gender [iw=weight] if Sector==2 & laborforce==1, nof col
bysort year: tab nic_five_usual_status Gender [iw=weight] laborforce==1, nof col

**********************************************************
***Workforce 2 digit and 5 digit
**********************************************************
gen worker_ps = 1 if (Status_ps>= 11 & Status_ps<= 51)
replace worker_ps = 0 if missing(worker_ps)
gen worker_ss = 1 if (Status_ss>= 11 & Status_ss<= 51)
replace worker_ss= 0 if missing(worker_ss)
gen workforce = 1 if worker_ps ==1 | worker_ss ==1
replace workforce = 0 if missing(workforce)

bysort year: tab nic_two_usual_status Gender [iw=weight] if Sector==1 & workforce==1, nof col
bysort year: tab nic_two_usual_status Gender [iw=weight] if Sector==2 & workforce==1, nof col
bysort year: tab nic_two_usual_status Gender [iw=weight] if workforce==1, nof col

bysort year: tab nic_five_usual_status Gender [iw=weight] if Sector==1 & workforce==1, nof col
bysort year: tab nic_five_usual_status Gender [iw=weight] if Sector==2 & workforce==1, nof col
bysort year: tab nic_two_usual_status Gender [iw=weight] if workforce==1, nof col
**********************************************************
*Labourforce and workforce by Social Group
*********************************************************
table (Social_group) (Sector Gender) [iw=weight], statistic(mean laborforce_percent) nformat(%9.1f)


gen workforce_perc= workforce*100
table (Social_group) (Sector Gender) [iw=weight], statistic(mean workforce_perc) nformat(%9.1f)

*********************************************************
**Workforce
*********************************************************
gen worker_ps = 1 if (Status_ps>= 11 & Status_ps<= 51)
replace worker_ps = 0 if missing(worker_ps)
gen worker_ss = 1 if (Status_ss>= 11 & Status_ss<= 51)
replace worker_ss= 0 if missing(worker_ss)
gen workforce = 1 if worker_ps ==1 | worker_ss ==1
replace workforce = 0 if missing(workforce)



