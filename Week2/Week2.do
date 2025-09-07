cd "C:\Users\InchanHwang\Desktop\Week2"

use "NELS.dta", clear

//// I don't use log at all... so I just delete log line..

//// 1. Exploring the Dataset \\\\
describe
browse
browse id advmath8 gender famsize

//// 2. Exploring Nominal Variables \\\\
tabulate advmath8 
tab region 
tab region, nolabel

// Two-Way Tabulation/Cross-Tabs \\
tab advmath8 region 
tab advmath8 region, col 
tab advmath8 region, row 
tab advmath8 region, cell
tab advmath8 region, m cell


tab1 advmath8 region

// Bar Chart Visualization for Nominal Variables
graph bar (percent), over(advmath8)
graph bar (percent), over(region)
graph bar (percent), over(advmath8) over(region) asyvars percentages blabel(bar)
help graph



//// 3. Exploring Continuous Variables \\\\
sum expinc30, detail
centile (expinc30), c(40)

// Tabstat \\

tabstat expinc30 
tabstat expinc30, stats(mean median sd iqr)
tabstat expinc30, by(region) stats(mean median sd iqr) 
tabstat expinc30 famsize, stats(mean median sd iqr) 


// Histograms \\
histogram expinc30
histogram expinc30, normal
histogram expinc30, by(region) normal
histogram expinc30 if expinc30 < 250000, normal 

// Box Plots \\
graph box expinc30, over(region)
graph box expinc30 if expinc30 < 250000, over(region)



//// 4. The Display Command: Use Stata as a Calculator \\\\
display 10*10
display 98/22
display round(98/22, 0.01)
display round(98/22, 0.1)
di      round(98/22, 1.0)
