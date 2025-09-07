# You need to install packages like "tidyverse" (for using %>%), "haven" (for reading .dta files), and "psych" (for using the describe function).
# To install a package, run: install.packages("tidyverse")
# After installation, load the package using: library(tidyverse)

library(tidyverse)
library(haven)
library(psych)

# Load the Excel file
data <- read_dta("C:/Users/InchanHwang/Desktop/Week1/Employment.dta")

# View the data
data

# Count the number of observations for each year
data %>% count(year)

# Summary statistics for the 'year' column
summary(data$year)
describe(data$year)

# Plot a histogram of the 'year' column
hist(data$year)
