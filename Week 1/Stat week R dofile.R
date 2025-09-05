# You need to install packages like "tidyverse" (for using %>%), "readxl" (for reading .xls files), and "psych" (for using the describe function).
# To install a package, run: install.packages("tidyverse")
# After installation, load the package using: library(tidyverse)

library(tidyverse)
library(readxl)
library(psych)

# Load the Excel file
data <- read_excel("C:/Users/InchanHwang/Desktop/Employment.xls")

# View the data
data

# Count the number of observations for each year
data %>% count(year)

# Summary statistics for the 'year' column
summary(data$year)
describe(data$year)

# Plot a histogram of the 'year' column
hist(data$year)
