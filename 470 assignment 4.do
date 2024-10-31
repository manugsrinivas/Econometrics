set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

**# Bookmark #1
*start log file 
log using "470 assignment 3.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/nlsy79.dta"

browse 
describe

*clean data 
gen age = year - birthyr
replace hours = . if hours < 0
replace earn = . if earn < 0
tab year
sum earn
*compute hourly wage  
gen hourly_wage = (earn)/(hours)
replace hourly_wage = . if hourly_wage < 2 | hourly_wage > 150

gen log_wage = ln(hourly_wage)
sum log_wage if year == 1990 [aw = sampweight]

*5.1: -.2494613  
keep if year == 1990
keep if female == 0
reg log_wage i.black i.hispanic age [aw = sampweight], robust

*5.2:-.2042863 
keep if year == 1990
keep if female == 0
reg log_wage i.black i.hispanic age educ [aw = sampweight], robust

*5.3: -.0808332
gen afqt2 = afqt^2
keep if year == 1990
keep if female == 0
reg log_wage i.black i.hispanic age afqt afqt2 [aw = sampweight], robust

*5.4: -.1738547
keep if year == 1990
keep if female == 1
reg log_wage i.black i.hispanic age [aw = sampweight], robust

*5.5: -.1558448 
keep if year == 1990
keep if female == 1
reg log_wage i.black i.hispanic age educ [aw = sampweight], robust

*5.6:.0171366 
gen afqt2 = afqt^2
keep if year == 1990
keep if female == 1
reg log_wage i.black i.hispanic age afqt afqt2 [aw = sampweight], robust

*6.1: -.3231138
keep if year == 2004
keep if female == 0
reg log_wage i.black i.hispanic age [aw = sampweight], robust

*6.2: -.0682978 
gen afqt2 = afqt^2
keep if year == 2004
keep if female == 0
reg log_wage i.black i.hispanic age afqt afqt2 [aw = sampweight], robust

clear 
*6.3: -.411216
keep if year == 2016
keep if female == 0
reg log_wage i.black i.hispanic age [aw = sampweight], robust

*6.4: -.1066125
gen afqt2 = afqt^2
keep if year == 2016
keep if female == 0
reg log_wage i.black i.hispanic age afqt afqt2 [aw = sampweight], robust

clear
 
*7
keep if year == 2016
keep if female == 0
reg log_wage i.black i.hispanic age [aw = sampweight]

*7.1: 5.7074729
reg log_wage i.white i.black age [aw = sampweight]

di (0- -.411216)/.0720487 

*7.2: yes reject null
* is crit value 1.962. 5.7074729 > 1.962.  

*7.3: .2679751
* margin of error = tn,a/2 * s/n^1/2
reg log_wage i.white i. black i.hispanic age [aw = sampweight]
di 2.576 * (( .1040276 ))
*tstat: .2679751
*7.4: yes 
di .2679751

*7.5: -1.8694841

reg log_wage i.white i.hispanic age [aw = sampweight]

di  ( -.2262087)/ (.1210006)
*7.6: no 
*7.7:451.394143  
*unr:
reg log_wage i.white i.black i.hispanic [aw = sampweight]
*r
reg log_wage  age [aw = sampweight] 
*7.8:  468.406884
*7.9:16.847129
*7.10: 3.0
*7.11: yes 

*8
gen blackafqt = black * afqt
gen hispanicafqt = hispanic * afqt
reg log_wage i.black i.hispanic i.white age afqt blackafqt hispanicafqt [aw = sampweight] 

*8.1: .3133907
*8.2: .3680282
*8.3: .69371262
di .0546375/.078761 
*8.4: reject null 




