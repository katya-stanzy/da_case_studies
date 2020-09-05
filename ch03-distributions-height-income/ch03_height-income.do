*********************************************************************
*
* GABORS' DATA ANALYSIS TEXTBOOK (Bekes & Kezdi)
*
* Case study 03D
* Distributions of body height and income
*
* using the height-income-distributions dataset
* 
********************************************************************

********************************************************************
* SET YOUR DIRECTORY HERE
*********************************************************************

* Directory for work
cd "C:\Users\kezdi\GitHub\da_case_studies" 
global work  "ch03-distributions-height-income"
cap mkdir "$work/output"
global output "$work/output"
cap mkdir "$work/temp"
global temp "$work/temp"

* Directory for data
* Option 1: run directory-setting do file
*do "set-data-directory.do" /*data_dir must be first defined */
*global data_in   	"$da_data_repo/height-income-distributions/clean"
* Option 2: set directory here
global data_in "C:/Users/kezdi/Dropbox/bekes_kezdi_textbook/da_data_repo/height-income-distributions/clean"




use "$data_in/hrs_height_income.dta",clear

* Normal distribution: height of women age 55-59 
sum height if age>=55 & age<60 & female==1 
tab height if height>1.80 & age>=55 & age<60 & female==1 ,mis

count if age>=55 & age<60 & female==1 & height>1.3 & height<2
sum height if age>=55 & age<60 & female==1 & height>1.3 & height<2

* Histogram with normal density overlayed
* Figure 3.10
colorpalette viridis, n(4) select(2) nograph
hist height if age>=55 & age<60 & female==1 & height>1.3 & height<2.1, ///
 percent width(0.025) ///
 color(`r(p)') lcol(white) ///
 normal ///
 ylabel(,grid) xlabel(1.4(0.1)1.9, grid) ///
 xtitle("Body height")
 graph export "$output/ch03-figure-10-hist-height-Stata.png", replace
 

* Lognormal distribution: family income of women age 55-59 

* Histogram of income and ln income with normal density overlayed
* Figure 3.11a
colorpalette viridis, n(4) select(2) nograph
hist hhincome if age>=55 & age<60 & female==1 & hhincome>1 & hhincome<1000, ///
 percent width(20) ///
 color(`r(p)') lcol(white) lw(vvthin) ///
 ylabel(0(5)25, grid) xlabel(0(200)1000, grid) ///
 xtitle("Household income (thousand US dollars)")
 graph export "$output/ch03-figure-11a-hist-inc-Stata.png", replace

* Figure 3.11b
gen lnincome=ln(hhincome)
 lab var lnincome "ln(houehold income, thousand US dollars)"
colorpalette viridis, n(4) select(2) nograph
hist lnincome if age>=55 & age<60 & female==1 & lnincome>0 & hhincome<1000, ///
 percent width(0.25) start(0) ///
 color(`r(p)') lcol(white) ///
 ylabel(0(2.5)10, grid) xlabel(0(1)8, grid) ///
 normal
 graph export "$output/ch03-figure-11b-hist-lninc-Stata.png", replace