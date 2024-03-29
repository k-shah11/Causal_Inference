********************************************
* This is file for "Do Children Born to Victims of Domestic Abuse Fare Worse?"
* This is the stata code used to determine relationship between children's exposure to IPV and their nutritional outcomes 


* DATA cleaning + Variable creations 
* Dataset used NFHS-5 (data file is available on the DHS website)

***************************************************
* MAIN VARIABLES:
 * Explanatory variables: Tot_PV, Tot_SV, Tot_EV, Tot_DV, PV_Index, SV_Index, EV_Index, DV_Index
 * Outcome varibales :  stunted, severely_stunted, wasted, severely_wasted
 
************************************************************************************************************************************

/// Merging female responder level data with child level data   
set maxvar 10000
use "IAIR7DFL.DTA",clear
sort v001 v002 v003
save "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/IAIR7DDT/IAIR7DFL.DTA", replace

use "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/IAKR7DDT/IAKR7DFL.DTA"
sort v001 v002 v003
merge m:1 v001 v002 v003 using "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/IAIR7DDT/IAIR7DFL.DTA"
tab _merge 
drop if _merge != 3
save "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/Merged_Data.dta"   


///Drop children with birth order > 1, drop women not selected for DV module
drop if bord != 1
drop if v044 ==0

///Create flag for whether a woman responded to DV module or not
gen responded_DV = 1 if v044 == 1 
replace responded_DV = 0 if d106==. & d107==. & d108==. & d104==. | responded_DV==. 

///Create indicator for women in the sample
gen in_sample = 0 if responded_DV==0
replace in_sample=0 if v715 >= 96
replace in_sample=0 if v438 >= 9994
replace in_sample=0 if hw70 >= 9996
replace in_sample=0 if hw72 >= 9996
replace in_sample=0 if d121 == 8 
replace in_sample=0 if m19 >= 9996
replace in_sample=0 if s116 == 8
replace in_sample=0 if v717 ==98
replace in_sample=0 if v730 == 98
replace in_sample=1 if in_sample==.

///Creating dummies for factor variables
tab v705, gen(spouse_occ)
tab v190, gen(Wealth)
tab v130, gen(Religion)
tab v151, gen(HH_Head_Sex)
tab v025, gen(Urban)
tab v745a, gen(House) 
tab v745b, gen(Land)
tab s116, gen(caste)
tab v457, gen(anemic)
tab b4, gen(child_sex)

label variable spouse_occ1 "\hspace{0.25cm} Professional/Technical - spouse occ"
label variable spouse_occ2 "\hspace{0.25cm} Clerical - spouse occ"
label variable spouse_occ3 "\hspace{0.25cm} Sales - spouse occ"
label variable spouse_occ4 "\hspace{0.25cm} Dom. Services - spouse occ"
label variable spouse_occ5 "\hspace{0.25cm} Agri - spouse occ"
label variable spouse_occ6 "\hspace{0.25cm} Manual Lab - spouse occ"
label variable spouse_occ7 "\hspace{0.25cm} Other - spouse occ"

label variable v133 "\hspace{0.25cm} Own Edu"
label variable v715 "\hspace{0.25cm} Spouse's Edu"
label variable v012 "\hspace{0.25cm} Age"
label variable v136 "\hspace{0.25cm} HH Size"
label variable hw1 "\hspace{0.25cm} Child's Age (months)"
label variable v212 "\hspace{0.25cm} Age at 1st Birth"

label variable Wealth1 "\hspace{0.25cm} Poorest"
label variable Wealth2 "\hspace{0.25cm} Poor"
label variable Wealth3 "\hspace{0.25cm} Middle"
label variable Wealth4 "\hspace{0.25cm} Rich"
label variable Wealth5 "\hspace{0.25cm} Richest"

gen Other_No_Religion=1 if Religion7==1|Religion8==1|Religion9==1|Religion10==1
replace Other_No_Religion=0 if Other_No_Religion==.
drop Religion7 Religion8 Religion9 Religion10
rename Other_No_Religion Religion7

label variable Religion1 "\hspace{0.25cm} Hindu"
label variable Religion2 "\hspace{0.25cm} Muslim"
label variable Religion3 "\hspace{0.25cm} Christian"
label variable Religion4 "\hspace{0.25cm} Sikh"
label variable Religion5 "\hspace{0.25cm} Buddhist"
label variable Religion6 "\hspace{0.25cm} Jain"
label variable Religion7 "\hspace{0.25cm} Other/No-Religion"

label variable HH_Head_Sex1 "\hspace{0.25cm} Male HH Head"
label variable HH_Head_Sex2 "\hspace{0.25cm} Female HH Head"

label variable Urban1 "\hspace{0.25cm} Urban HH"
label variable Urban2 "\hspace{0.25cm} Rural HH" 

label variable House1 "\hspace{0.25cm} Doesn't own house" 
label variable House2 "\hspace{0.25cm} Owns house alone" 
label variable House3 "\hspace{0.25cm} Owns house jointly" 
label variable House4 "\hspace{0.25cm} Owns house both alone & jointly" 
label variable Land1 "\hspace{0.25cm} Doesn't own land"  
label variable Land2 "\hspace{0.25cm} Owns land alone"  
label variable Land3 "\hspace{0.25cm} Owns land jointly" 
label variable Land4 "\hspace{0.25cm} Owns land both alone & jointly" 

label variable caste1 "\hspace{0.25cm} SC"  
label variable caste2 "\hspace{0.25cm} ST"  
label variable caste3 "\hspace{0.25cm} OBC" 
label variable caste4 "\hspace{0.25cm} None" 
    
label variable anemic1 "\hspace{0.25cm} Severely Anemic" 
label variable anemic2 "\hspace{0.25cm} Moderately Anemic" 
label variable anemic3 "\hspace{0.25cm} Mildly Anemic" 
label variable anemic4 "\hspace{0.25cm} Not Anemic" 

label variable child_sex1 "\hspace{0.25cm} Male Child"
label variable child_sex2 "\hspace{0.25cm} Female Child"

/// Creating additional variables for balance test 
gen age_difference = v730 - v012
label variable age_difference "\hspace{0.25cm} Age Diff w/ Spouse"

gen weight_at_birth = m19/1000
label variable weight_at_birth "\hspace{0.25cm} Birth Weight"

gen mother_ht = v438/10
label variable mother_ht "\hspace{0.25cm} Height"

/// Creating Explanatory Variables

gen DV = d106 + d107 + d108 + d104 if in_sample==1
gen dom_viol = 1 if DV > 0 & DV != .
replace dom_viol = 0 if DV == 0 & DV != .

gen adj_d105a = d105a if d105a == 0 | d105a == 2
replace adj_d105a = 1 if d105a ==3
replace adj_d105a = 3 if d105a==1
label define adj_d105a 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105a adj_d105a

gen adj_d105b = d105b if d105b == 0 | d105b == 2
replace adj_d105b = 1 if d105b ==3
replace adj_d105b = 3 if d105b==1
label define adj_d105b 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105b adj_d105b

gen adj_d105c = d105c if d105c == 0 | d105c == 2
replace adj_d105c = 1 if d105c ==3
replace adj_d105c = 3 if d105c ==1
label define adj_d105c 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105c adj_d105c

gen adj_d105d = d105d if d105d == 0 | d105d == 2
replace adj_d105d = 1 if d105d ==3
replace adj_d105d = 3 if d105d ==1
label define adj_d105d 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105d adj_d105d

gen adj_d105e = d105e if d105e == 0 | d105e == 2
replace adj_d105e = 1 if d105e ==3
replace adj_d105e = 3 if d105e ==1
label define adj_d105e 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105e adj_d105e

gen adj_d105f = d105f if d105f == 0 | d105f == 2
replace adj_d105f = 1 if d105f ==3
replace adj_d105f = 3 if d105f ==1
label define adj_d105f 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105f adj_d105f

gen adj_d105g = d105g if d105g == 0 | d105g == 2
replace adj_d105g = 1 if d105g ==3
replace adj_d105g = 3 if d105g ==1
label define adj_d105g 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105g adj_d105g

gen adj_d105h = d105h if d105h == 0 | d105h == 2
replace adj_d105h = 1 if d105h ==3
replace adj_d105h = 3 if d105h ==1
label define adj_d105h 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105h adj_d105h

gen adj_d105i = d105i if d105i == 0 | d105i == 2
replace adj_d105i = 1 if d105i ==3
replace adj_d105i = 3 if d105i ==1
label define adj_d105i 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105i adj_d105i

gen adj_d105j = d105j if d105j == 0 | d105j == 2
replace adj_d105j = 1 if d105j ==3
replace adj_d105j = 3 if d105j ==1
label define adj_d105j 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105j adj_d105j

gen adj_d105k = d105k if d105k == 0 | d105k == 2
replace adj_d105k = 1 if d105k ==3
replace adj_d105k = 3 if d105k ==1
label define adj_d105k 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d105k adj_d105k

gen adj_d103a = d103a if d103a == 0 | d103a == 2
replace adj_d103a = 1 if d103a ==3
replace adj_d103a = 3 if d103a ==1
label define adj_d103a 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d103a adj_d103a

gen adj_d103b = d103b if d103b == 0 | d103b == 2
replace adj_d103b = 1 if d103b ==3
replace adj_d103b = 3 if d103b ==1
label define adj_d103b 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d103b adj_d103b

gen adj_d103c = d103c if d103c == 0 | d103c == 2
replace adj_d103c = 1 if d103c ==3
replace adj_d103c = 3 if d103c ==1
label define adj_d103c 0 "Never" 1 "yes, but not in the last 12 months" 2 "Sometimes" 3 "Often"
label values adj_d103c adj_d103c

///PV Index

egen min_105a = min(adj_d105a)
egen max_105a = max(adj_d105a)

egen min_105b = min(adj_d105b)
egen max_105b = max(adj_d105b)

egen min_105c = min(adj_d105c)
egen max_105c = max(adj_d105c)

egen min_105j = min(adj_d105j)
egen max_105j = max(adj_d105j)

egen min_105d = min(adj_d105d)
egen max_105d = max(adj_d105d)

egen min_105e = min(adj_d105e)
egen max_105e = max(adj_d105e)

egen min_105f = min(adj_d105f)
egen max_105f = max(adj_d105f)

gen std_d105a = (adj_d105a - min_105a)/(max_105a - min_105a)
gen std_d105b = (adj_d105b - min_105b)/(max_105b - min_105b)
gen std_d105c = (adj_d105c - min_105c)/(max_105c - min_105c)
gen std_d105j = (adj_d105j - min_105j)/(max_105j - min_105j)
gen std_d105d = (adj_d105d - min_105d)/(max_105d - min_105d)
gen std_d105e = (adj_d105e - min_105e)/(max_105e - min_105e)
gen std_d105f = (adj_d105f - min_105f)/(max_105f - min_105f)


gen PV_Index = (1/12)*std_d105a + (1/12)*std_d105b + (1/12)*std_d105c + (1/12)*std_d105j + (2/9)*std_d105d + (2/9)*std_d105e + (2/9)*std_d105f

///SV Index

egen min_105h = min(adj_d105h)
egen max_105h = max(adj_d105h)

egen min_105i = min(adj_d105i)
egen max_105i = max(adj_d105i)

egen min_105k = min(adj_d105k)
egen max_105k = max(adj_d105k)

gen std_d105h = (adj_d105h - min_105h)/(max_105h - min_105h)
gen std_d105i = (adj_d105i - min_105i)/(max_105i - min_105i)
gen std_d105k = (adj_d105k - min_105k)/(max_105k - min_105k)

gen SV_Index = (1/3)*std_d105h + (1/3)*std_d105i + (1/3)*std_d105k

///EV Index
egen min_103a =min(adj_d103a)
egen max_103a =max(adj_d103a)

egen min_103b =min(adj_d103b)
egen max_103b =max(adj_d103b)

egen min_103c =min(adj_d103c)
egen max_103c =max(adj_d103c)

gen std_103a=(adj_d103a-min_103a)/(max_103a-min_103a)
gen std_103b=(adj_d103b-min_103b)/(max_103b-min_103b)
gen std_103c=(adj_d103c-min_103c)/(max_103c-min_103c)

gen EV_Index =(1/3)*std_103a+(1/3)*std_103b+(1/3)*std_103c

///DV Index
gen DV_Index = (1/3)*PV_Index +(1/3)*SV_Index+(1/3)*EV_Index


///Total Violence
gen Tot_PV = adj_d105a + adj_d105b + adj_d105c + adj_d105j + adj_d105d + adj_d105e + adj_d105f if in_sample==1
gen Tot_SV = adj_d105h + adj_d105i + adj_d105k if in_sample==1
gen Tot_EV = adj_d103a + adj_d103b + adj_d103c if in_sample==1
gen Tot_DV = Tot_PV + Tot_SV + Tot_EV if in_sample==1


label variable dom_viol "\hspace{0.25cm} Domestic Viol."
label variable d106 "\hspace{0.25cm} Less Severe Phy Viol."
label variable d107 "\hspace{0.25cm} Severe Phy Viol."
label variable d108 "\hspace{0.25cm} Sexual Viol."
label variable d104 "\hspace{0.25cm} Emotional Viol."

label variable Tot_PV "\hspace{0.25cm} Physical Viol."
label variable Tot_SV "\hspace{0.25cm} Sexual Viol."
label variable Tot_EV "\hspace{0.25cm} Emotional Viol."
label variable Tot_DV "\hspace{0.25cm} Domestic Viol."

label variable PV_Index "\hspace{0.25cm} PV Index"
label variable SV_Index "\hspace{0.25cm} SV Index"
label variable EV_Index "\hspace{0.25cm} EV Index"
label variable DV_Index "\hspace{0.25cm} DV Index"

/// Creating Dependent Variables
  
gen stunted = 1 if hw70 < -200 & hw70 != . 
replace stunted = 0 if hw70 >= -200 & hw70!=. 
label variable stunted "\hspace{0.25cm} Stunted"

gen wasted = 1 if hw72 < -200 & hw72 != . 
replace wasted = 0 if hw72 >= -200 & hw72!=.
label variable wasted "\hspace{0.25cm} Wasted"

gen severely_stunted = 1 if hw70 < -300 & hw70 != . 
replace severely_stunted = 0 if hw70 >= -300 & hw70!=. 
label variable severely_stunted "\hspace{0.25cm} Severely Stunted"

gen severely_wasted = 1 if hw72 < -300 & hw72 != . 
replace severely_wasted = 0 if hw72 >= -300 & hw72!=. 
label variable severely_wasted "\hspace{0.25cm} Severely Wasted"
         
///For Regression:

global predictors v133 mother_ht age_difference House1 House2 House3 Land1 Land2 Land3 v715 spouse_occ1 spouse_occ2 spouse_occ3 spouse_occ4 spouse_occ5 spouse_occ6  v136  ///
Wealth1 Wealth2 Wealth3 Wealth4 Religion1 Religion3 Religion4 Religion5 Religion6 HH_Head_Sex1 Urban1 ///
caste1 caste2 caste3 i.v024 hw1 child_sex1 v212

///For ttest: 
global covariates stunted severely_stunted wasted severely_wasted hw1 child_sex1 v012 mother_ht anemic1 anemic2 anemic3  v133 age_difference House1 House2 House3 Land1 Land2 Land3 v715 spouse_occ1 spouse_occ2 spouse_occ3 spouse_occ4 spouse_occ5 spouse_occ6  v136  ///
Wealth1 Wealth2 Wealth3 Wealth4 Religion1 Religion2 Religion3 Religion4 Religion5 Religion6 Religion7 HH_Head_Sex1 Urban1 ///
caste1 caste2 caste3  

///Balance test for women who responded to DV module vs not - most coeff are insig, others included in regression. 
replace responded_DV = 2 if responded_DV==0

eststo clear
estpost ttest  $covariates , by(responded_DV)
esttab using "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/Table1.tex", replace refcat (stunted "\vspace{0.1em} \emph{Child Characteristics}" v012 "\vspace{0.2em} \emph{Own Characteristics}" v715 "\vspace{0.2em} \emph{Spouse's Characteristics}" v136 "\vspace{0.2em} \emph{HH Characteristics}", nolabel) ///
wide nonumber cells("mu_1(fmt(2)) N_1(fmt(0)) mu_2(fmt(2)) N_2(fmt(0)) b(fmt(2) star)") collabels ("Mean" "N" "Mean" "N" "Diff.") label starlevels(* 0.1 ** 0.05 *** 0.01) noobs

drop if in_sample == 0 //drop women not in sample

///Balance check for women who have suffered any type of violence vs not

replace dom_viol = 2 if dom_viol==0
eststo clear
estpost ttest  $covariates , by(dom_viol)

esttab, wide nonumber mtitle ("Mean Diff.") label starlevels(* 0.1 ** 0.05 *** 0.01)

esttab using "/Users/kritishah/Desktop/Impact Evaluation/Term Paper/Table2.tex", replace refcat (stunted "\vspace{0.1em} \emph{Child Characteristics}" v012 "\vspace{0.2em} \emph{Own Characteristics}" v715 "\vspace{0.2em} \emph{Spouse's Characteristics}" v136 "\vspace{0.2em} \emph{HH Characteristics}", nolabel) ///
wide nonumber cells("mu_1(fmt(2)) N_1(fmt(0)) mu_2(fmt(2)) N_2(fmt(0)) b(fmt(2) star) ") collabels ("Mean" "N" "Mean" "N" "Diff.") label starlevels(* 0.1 ** 0.05 *** 0.01) noobs
  

  
  
