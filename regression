********************************************
* This is file for "Do Children Born to Victims of Domestic Abuse Fare Worse?"
* This is the stata code used to determine relationship between children's exposure to IPV and their nutritional outcomes 
* This file has to be used post dataprep
* Individual table results were compiled in Latex

* OLS/IV Regression Specification
* Dataset used NFHS-5 (data file is available on the DHS website)

***************************************************
* MAIN VARIABLES:
 * Explanatory variables: Tot_PV, Tot_SV, Tot_EV, Tot_DV, PV_Index, SV_Index, EV_Index, DV_Index
 * Outcome varibales :  stunted, severely_stunted, wasted, severely_wasted
 
************************************************************************************************************************************

///OLS

eststo clear
eststo model1: quietly regress stunted Tot_PV $predictors_3, robust
eststo model2: quietly regress severely_stunted Tot_PV $predictors_3, robust
eststo model3: quietly regress wasted Tot_PV $predictors_3, robust
eststo model4: quietly regress severely_wasted Tot_PV $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_PV) label

eststo clear
eststo model5: quietly regress stunted Tot_SV $predictors_3, robust
eststo model6: quietly regress severely_stunted Tot_SV $predictors_3, robust
eststo model7: quietly regress wasted Tot_SV $predictors_3, robust
eststo model8: quietly regress severely_wasted Tot_SV $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_SV) label

eststo clear
eststo model9: quietly regress stunted Tot_EV $predictors_3, robust
eststo model10: quietly regress severely_stunted Tot_EV $predictors_3, robust
eststo model11: quietly regress wasted Tot_EV $predictors_3, robust
eststo model12: quietly regress severely_wasted Tot_EV $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_EV) label

eststo clear
eststo model13: quietly regress stunted Tot_DV $predictors_3, robust
eststo model14: quietly regress severely_stunted Tot_DV $predictors_3, robust
eststo model15: quietly regress wasted Tot_DV $predictors_3, robust
eststo model16: quietly regress severely_wasted Tot_DV $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_DV) label

eststo clear
eststo model17: quietly regress stunted PV_Index $predictors_3, robust
eststo model18: quietly regress severely_stunted PV_Index $predictors_3, robust
eststo model19: quietly regress wasted PV_Index $predictors_3, robust
eststo model20: quietly regress severely_wasted PV_Index $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(PV_Index) label

eststo clear
eststo model21: quietly regress stunted SV_Index $predictors_3, robust
eststo model22: quietly regress severely_stunted SV_Index $predictors_3, robust
eststo model23: quietly regress wasted SV_Index $predictors_3, robust
eststo model24: quietly regress severely_wasted SV_Index $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(SV_Index) label

eststo clear
eststo model25: quietly regress stunted EV_Index $predictors_3, robust
eststo model26: quietly regress severely_stunted EV_Index $predictors_3, robust
eststo model27: quietly regress wasted EV_Index $predictors_3, robust
eststo model28: quietly regress severely_wasted EV_Index $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(EV_Index) label

eststo clear
eststo model29: quietly regress stunted DV_Index $predictors_3, robust
eststo model30: quietly regress severely_stunted DV_Index $predictors_3, robust
eststo model31: quietly regress wasted DV_Index $predictors_3, robust
eststo model32: quietly regress severely_wasted DV_Index $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(DV_Index) label


///IV (codes used for first-stage results are missing and will be updated soon) 

eststo clear
eststo model33: quietly ivreg2 stunted (Tot_PV=d121) $predictors_3, robust 
eststo model34: quietly ivreg2 severely_stunted (Tot_PV=d121) $predictors_3, robust
eststo model35: quietly ivreg2 wasted (Tot_PV=d121) $predictors_3, robust
eststo model36: quietly ivreg2 severely_wasted (Tot_PV=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_PV) label

eststo clear
eststo model37: quietly ivreg2 stunted (Tot_SV=d121) $predictors_3, robust
eststo model38: quietly ivreg2 severely_stunted (Tot_SV=d121) $predictors_3, robust
eststo model39: quietly ivreg2 wasted (Tot_SV=d121) $predictors_3, robust
eststo model40: quietly ivreg2 severely_wasted (Tot_SV=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_SV) label

eststo clear
eststo model41: quietly ivreg2 stunted (Tot_EV=d121) $predictors_3, robust
eststo model42: quietly ivreg2 severely_stunted (Tot_EV=d121) $predictors_3, robust
eststo model43: quietly ivreg2 wasted (Tot_EV=d121) $predictors_3, robust
eststo model44: quietly ivreg2 severely_wasted (Tot_EV=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_EV) label

eststo clear
eststo model45: quietly ivreg2 stunted (Tot_DV=d121) $predictors_3, robust
eststo model46: quietly ivreg2 severely_stunted (Tot_DV=d121) $predictors_3, robust
eststo model47: quietly ivreg2 wasted (Tot_DV=d121) $predictors_3, robust
eststo model48: quietly ivreg2 severely_wasted (Tot_DV=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(Tot_DV) label

eststo clear
eststo model49: quietly ivreg2 stunted (PV_Index=d121) $predictors_3, robust
eststo model50: quietly ivreg2 severely_stunted (PV_Index=d121) $predictors_3, robust
eststo model51: quietly ivreg2 wasted (PV_Index=d121) $predictors_3, robust
eststo model52: quietly ivreg2 severely_wasted (PV_Index=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(PV_Index) label

eststo clear
eststo model53: quietly ivreg2 stunted (SV_Index=d121) $predictors_3, robust
eststo model54: quietly ivreg2 severely_stunted (SV_Index=d121) $predictors_3, robust
eststo model55: quietly ivreg2 wasted (SV_Index=d121) $predictors_3, robust
eststo model56: quietly ivreg2 severely_wasted (SV_Index=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(SV_Index) label

eststo clear
eststo model57: quietly ivreg2 stunted (EV_Index=d121) $predictors_3, robust
eststo model58: quietly ivreg2 severely_stunted (EV_Index=d121) $predictors_3, robust
eststo model59: quietly ivreg2 wasted (EV_Index=d121) $predictors_3, robust
eststo model60: quietly ivreg2 severely_wasted (EV_Index=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(EV) label

eststo clear
eststo model61: quietly ivreg2 stunted (DV_Index=d121) $predictors_3, robust
eststo model62: quietly ivreg2 severely_stunted (DV_Index=d121) $predictors_3, robust
eststo model63: quietly ivreg2 wasted (DV_Index=d121) $predictors_3, robust
eststo model64: quietly ivreg2 severely_wasted (DV_Index=d121) $predictors_3, robust
esttab, r2 ar2 se starlevels(* 0.10 ** 0.05 *** 0.01) keep(DV_Index) label

