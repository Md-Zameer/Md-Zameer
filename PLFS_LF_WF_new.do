cd "D:\capex\PLFS_LF_WF\DDI-IND-CSO-PLFS-2020-21"
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
***Workforce, by 2 and 5 digit
*************************************************
destring Status_ps Status_ss, replace
gen ps_labourforce = 1 if (Status_ps>=11 & Status_ps<=51)
replace ps_labourforce = 0 if missing(ps_labourforce)
gen ss_labourforce = 1 if (Status_ss >= 11 & Status_ss <= 51)
replace ss_labourforce = 0 if missing(ss_labourforce)

gen nic_two_ps = substr(NIC_code_ps,1, 2)
gen nic_two_ss= substr(NIC_code_ss,1, 2)
gen nic_two_usual_status= nic_two_ps
replace nic_two_usual_status= nic_two_ss if missing(nic_two_ps)

gen workforce = 1 if ps==1 | ss==1 
replace workforce = 0 if missing(workforce)

egen gender_sector= group( Gender Sector)
label define sector_gender 1 "Rural Male" 2 "Urban Male" 3 "Rural Female" 4 "Urban Female"
label value gender_sector sector_gender

**NIC five Digit_construction breakdown
gen nic_five_usual_status= NIC_code_ps
replace nic_five_usual_status= NIC_code_ss if missing(NIC_code_ps)

gen nic_five_construction = nic_five_usual_status if ///
    real(nic_five_usual_status) >= 41001 & real(nic_five_usual_status) <= 43900

**NIC two Digit_construction breakdown 

gen nic_two_contruction = nic_two_usual_status if inlist(nic_two_usual_status,"41", "42","43")


**NIC three Digit_construction breakdown 
gen nic_three_digit= substr(nic_five_usual_status,1,3)
gen nic_three_construction = nic_three if ///
    real(nic_three_digit) >= 410 & real(nic_three_digit) <= 439
	

save appended_new, replace

levelsof year, local(years)

foreach yr of local years {
    display "=== Year: `yr' ==="
    tab nic_two_usual_status gender_sector [iw=weight_annual] if year == "`yr'" & workforce == 1
}
*three digit
levelsof year, local(years)

foreach yr of local years {
    display "=== Year: `yr' ==="
    tab nic_three_construction gender_sector [iw=weight_annual] if year == "`yr'" & workforce == 1
}
** two digit
levelsof year, local(years)

foreach yr of local years {
    display "=== Year: `yr' ==="
    tab nic_two_contruction gender_sector [iw=weight_annual] if year == "`yr'" & workforce == 1
}
** five digit
levelsof year, local(years)

foreach yr of local years {
    display "=== Year: `yr' ==="
    tab nic_five_construction gender_sector [iw=weight_annual] if year == "`yr'" & workforce == 1
}

************************************************************************
* Quality of work 
************************************************************************

destring nic_two_contruction, replace
gen usual_status= Status_ps
replace usual_status = Status_ss if missing(usual_status)
gen usual_status_broad = usual_status
keep if inrange(usual_status_broad, 11,51)
recode usual_status_broad (11 12 21 =1 "self-employed") (31=2 "salaried employee") (41 51 =3 "casual worker"), gen(usual_status_new) 
***construction as a whole
gen constr=1 if !missing(nic_two_contruction)
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr==1
}
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr==1, nof col
}
*****Breakdown of construction
gen constr_nic41=. 
replace constr_nic41 = 1 if nic_two_contruction ==41

gen constr_nic42=. 
replace constr_nic42 = 1 if nic_two_contruction==42

gen constr_nic43=. 
replace constr_nic43 = 1 if nic_two_contruction==43
***41
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr_nic41 ==1
}
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr_nic41 ==1, nof col
}

***42

levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" &constr_nic42 ==1
}
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr_nic42 ==1, nof col
}
	
***43
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr_nic43 ==1
}
levelsof year, local(years)
foreach yr of local years {
    display "=== Year: `yr' ==="
    tab usual_status_new gender_sector [iw=weight_annual] if year == "`yr'" & constr_nic43 ==1, nof col
}



***********************************************************
**Broad Classifiacation (Construction Sector)
***********************************************************

* --- Generate sector variable ---
gen nic_two_broad=nic_two_usual_status
encode nic_two_broad, gen(nic_two_broad_num)
gen sector_broad = .

* -------------------------------------------------------
* 1. AGRICULTURE (Section A: 01–03)
*    Crop & animal production, forestry, fishing
* -------------------------------------------------------
replace sector_broad = 1 if inrange(nic_two_usual_status, "01", "03")

* -------------------------------------------------------
* 2. MANUFACTURING (: 10–39)
replace sector_broad = 2 if inrange(nic_two_usual_status, "10", "39")  // Manufacturing (C)
* -------------------------------------------------------
* 3. CONSTRUCTION (Section F: 41–43)
*    Building construction, civil engineering, specialised
* -------------------------------------------------------
replace sector_broad = 3 if inrange(nic_two_usual_status, "41", "43")

* -------------------------------------------------------
* 4. SERVICE (Sections G–U: 45–99)
* -------------------------------------------------------
replace sector_broad = 4 if inrange(nic_two_usual_status, "45", "66")
replace sector_broad = 5 if missing(sector_broad)


* --- Attach value labels ---
label define sector_lbl  1 "Agriculture"   ///
                         2 "Manufacturing" ///
                         3 "Construction"  ///
                         4 "Service"  ///
						 5 "None_of_the_above"
label values sector sector_lbl
label variable sector "Broad Sector (NIC 2-digit)"


table sector_broad Gender ///
    [iweight=weight_annual] ///
    if year=="2017-18" & Sector==1, ///
    statistic(percent)
	
table sector_broad Gender ///
    [iweight=weight_annual] ///
    if year=="2017-18" & Sector==2, ///
    statistic(percent)


 