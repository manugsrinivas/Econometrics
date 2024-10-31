set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 2.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/mobility.dta"

browse 

describe 


reg am hhinc00[aw = pop2000]

gen hhinc = hhinc00/1000

gen lnhhinc00 = ln(hhinc00)
