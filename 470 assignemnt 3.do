set more off 
clear 
capture log close 

*change default directory 
cd "/Users/mgs/Documents/Stata/Output"

*start log file 
log using "470 assignment 3.log",replace 

*open data 
use "/Users/mgs/Documents/Stata/470 data/mobility.dta"

browse 

describe 

*Empirical Problems
*5:Let's start by studying regional differences in upward mobility.
*5.1: violates MLR 3: collinearity 
tab region 
tab region, nol
gen northeast = 0 
replace northeast = 1 if (region == 1)
gen midwest = 0 
replace midwest = 1 if(region == 2)
gen south = 0 
replace south = 1 if (region == 3)
gen west = 0
replace west = 1 if (region == 4)
reg am northeast midwest south west [aw = pop2000]
*5.2: sd = 0 
replace sumofregions = (northeast == 1)+ (midwest == 1)+ (south = 1) + (west == 1)
sum sumofregions 
*5.3: Northeast 
reg am i.region [aw = pop2000]
*5.4: South
*5.5: 1.97

*6: The variable racialseg contains a measure of racial residential segregation on a 0–1scale, where 0 is the lowest possible amount of segregation, and 1 is the highest possible amount.Regress upward mobility on racial segregation and the region indicators. Remember to weight all regressions by by commuting zone population (pop2000). When you run the regression correctly, you will find 𝑅2 = 0.3819.
reg am racialseg northeast midwest south west [aw = pop2000]
*6.1: 1.288731
di 12.88731 * 0.1 
*6.2: 2.745894
*6.3: b 

*7: Verify the partialling out interpretation of the multiple regression in the previous question, with a focus on the coefficient on racial segregation. Remember to weight all regressions by by commuting zone population (pop2000).
*7.1: -12.88731
*7.2: 0.1436
reg racialseg northeast midwest south west [aw = pop2000]
*7.3: northeast 
*7.4: -12.88731

*8: Is the relationship between upward mobility and racial residential segregation different across regions? Address this question by regressing upward mobility on racial segregation, the region indicators, and interactions between the region indicators and racial segregation. See the slides for the relevant Stata code to include the interaction terms. Remember to weight all regressions by by commuting zone population (pop2000). When you run the regression correctly, you will find 𝑅2 = 0.4408.
gen northeastracialseg = northeast*racialseg
gen southracialseg = south*racialseg 
gen westracialseg = west*racialseg
gen midwestracialseg = midwest*racialseg 
reg am racialseg northeast midwest south west northeastracialseg southracialseg westracialseg midwestracialseg [aw = pop2000]
*8.1: -4.5923842
di -4.239963 + -.3524212
*8.2: -21.746243
di -17.50628 + -4.239963
*9:Perhaps the relationship between upward mobility and racial residential segregation is nonlinear. Regress upward mobility on a quadratic in racial segregation (be sure to include both racial segregation and its square). Do not include the region indicators in this regression. Remember to weight all regressions by by commuting zone population (pop2000). When you run the regression correctly, you will find 𝑅2 = 0.0980.
gen racialseg2 = racialseg^2
reg am racialseg racialseg2 [aw = pop2000]
*9.1: -14.11844
*9.2: -11.9821857
di -4.239963*(0.24) + -.3524212*(0.24) + -2.35919193*(0.24) + - 17.50628*(0.24)
*9.3: slope is monotonic 
