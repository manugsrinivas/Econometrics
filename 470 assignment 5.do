set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 3.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/union.dta"

browse 
describe

*4.1:.268614
reg union educ exper i.race3 

*4.2:.7401306 
probit union educ exper i.race3, robust 
margins, dydx(*)

*4.3:..2686288
* margins give the full calculation just use that 

*4.4:-.0057826
reg union educ exper i.race3 
di  -.0028913*2

*4.5: -.0185636
probit union educ exper i.race3, robust 
margins, dydx(*)  
di -.0092818 *2

set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 3.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/minwage.dta"

browse 
describe

*5:
reg fte i.state##i.time, robust 

*5.1: 3.294369
reg fte i.state##i.time i.chain co_owned hoursopen, robust

*5.2: reject H0 2.3099999
di (3.294369/1.4261338 ) 

*5.3: .0818091     
gen price = priceentree + pricesoda + pricefry 
reg price i.state##i.time i.chain co_owned hoursopen, robust  

*5.4: 1.5931324 no reject 
di .0818091/.0513511 
