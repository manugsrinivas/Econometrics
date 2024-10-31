set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 6.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/union.dta"

browse 
describe

*5
xtset nr year
sort nr year

*5.1: 0.0706398 
drop if year > 1981 
reg lwage i.union i.agric i.construc i.manuf 
reg D.lwage D.union D.agric D.construc D.manuf 

*5.2: 0.0705   
xtreg lwage i.union i.agric i.construc i.manuf i.year, fe 

*5.3: 0.0800025 
clear 
use "/Users/mgs/Documents/Stata/470 data/union.dta"
xtset nr year
sort nr year
xtreg lwage i.union i.agric i.construc i.manuf i.year, fe 

*5.4: 0.1782589
reg lwage i.union i.agric i.construc i.manuf i.year i.black i.hisp educ

*5.5: The fixed effects estimates are smaller, because higher wage workers are less likely to be in a union.

*5.6: These variables do not change over time for a given worker, so they are already part of the worker fixed effects.

*5.7: yes 

clear 

*6:

use "/Users/mgs/Documents/Stata/470 data/card.dta"

*6.1: 0.0738471
reg lwage educ exper i.black i.smsa i.region motheduc fatheduc [aw = weight]

*6.2: 0.0576246 
reg lwage nearc4 exper i.black i.smsa i.region motheduc fatheduc [aw = weight]

*6.3: 0.3033492 
reg educ nearc4 exper i.black i.smsa i.region motheduc fatheduc [aw = weight]

*6.4:0.18996127
*wald estimate is the reduced form coefficient on nearc4 divided by coeff from first stage on nearc4  
di 0.0576246/0.3033492 

*6.5: 0.002 effect of educ is 0 
ivregress 2sls lwage (educ = nearc4) exper i.black i.smsa i.region motheduc fatheduc [aw = weight]
*0.1899611 coefficient from ivregress whuch is extremely close to wald estimate 
di 0.1899611/ .0624609 


