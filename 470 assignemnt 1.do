set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 1.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/mobility.dta"

browse 

*7.1: am = 38.46875
*7.2: hhinc00 = 35224.83
*7.3: gini = .5086
*7.4 statefip = 37
*8.1 37.57139 
sum am[aw=pop2000] if statefip == 47
sum am if statefip == 47
*8.2 38.20225  
sum am[aw=pop2000] if statefip == 47, detail
*8.3 left skewed 
*8.4 2.057653 
*9.1 The Northeast has the most positive net_migration
gen net_migration = mig_outflow - mig_inflow 
tab region 
tab region, nol
sum net_migration[aw=pop2000] if region == 1 
sum net_migration[aw=pop2000] if region == 2
sum net_migration[aw=pop2000] if region == 3
sum net_migration[aw=pop2000] if region == 4
*9.2 South 
*9.3 42.28278
sum am[aw=pop2000] if net_migration > 0
*9.4  40.74845
sum am[aw=pop2000] if net_migration < 0
*9.5 0.2661
corr am net_migration [aw=pop2000]
 