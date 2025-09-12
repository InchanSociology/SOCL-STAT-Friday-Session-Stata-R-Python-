## if you need to install pacaksges, you can use below codes after removing ##
## install.packages("janitor", "skimr", "scales")

library(tidyverse)
library(haven)
library(janitor)
library(skimr)
library(scales)


nels <- read_dta("C:/Users/InchanHwang/Desktop/Week2/NELS.dta")

## Exploring the Dataset##

glimpse(nels)

View(nels) # All
View(select(nels, id, advmath8, gender, famsize)) #selected Variables


## Exploring Nominal Variable ##

nels %>% tabyl(advmath8) %>% 
  adorn_totals("row")

nels %>% 
  tabyl(region) %>% 
  adorn_totals("row")

nels %>% 
  tabyl(region) %>% 
  adorn_totals("row")

## Two-Way Tabulation/Cross-Tabs ##


nels %>% 
  tabyl(advmath8, region) %>% 
  adorn_totals("both")

nels %>% 
  tabyl(advmath8, region) %>% 
  adorn_percentages("col") %>% 
  adorn_ns()

nels %>% 
  tabyl(advmath8, region) %>% 
  adorn_percentages("row") %>% 
  adorn_pct_formatting(digits = 1) %>% 
  adorn_ns()

nels %>% 
  tabyl(advmath8, region) %>% 
  adorn_percentages("all") %>%  
  adorn_ns()

nels %>% 
  tabyl(advmath8, region, show_na = TRUE) %>% 
  adorn_percentages("all")

## Bar Chart Visualization for Nominal Variables ##

nels %>% 
  count(advmath8) %>% 
  mutate(pct = n / sum(n)) %>% 
  ggplot(aes(x = advmath8, y = pct)) +
  geom_col()


nels %>% 
  count(region) %>% 
  mutate(pct = n / sum(n)) %>% 
  ggplot(aes(x = region, y = pct)) +
  geom_col()

##  Exploring Continuous Variables ##

summary(nels$expinc30)
skim(nels$expinc30)
quantile(nels$expinc30, probs = 0.40)

## Tabstat ##


nels %>% 
  summarise(
    mean   = mean(expinc30),
    median = median(expinc30),
    sd     = sd(expinc30),
    iqr    = IQR(expinc30)
  )

# by(region)
nels %>%
  group_by(region) %>% 
  summarise(
    mean   = mean(expinc30),
    median = median(expinc30),
    sd     = sd(expinc30),
    iqr    = IQR(expinc30),
    n      = sum(expinc30),
    .groups = "drop"
  )


nels %>% 
  summarise(
    across(c(expinc30, famsize),
           list(mean = ~mean(.x),
                median = ~median(.x),
                sd = ~sd(.x),
                iqr = ~IQR(.x)))
  )

# histogram
# Total + Normal distribution
mu <- mean(nels$expinc30)
sigma <- sd(nels$expinc30)

ggplot(nels, aes(x = expinc30)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30) +
  stat_function(fun = dnorm, args = list(mean = mu, sd = sigma)) +
  labs(title = "Histogram of expinc30 with Normal Curve") +
  theme_minimal()

ggplot(nels, aes(x = expinc30)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30) +
  facet_wrap(~ region) +
  theme_minimal()

# if expinc30 < 250000, + Normal distribution
nels_sub <- nels %>% filter(!is.na(expinc30), expinc30 < 250000)
mu2 <- mean(nels_sub$expinc30)
sigma2 <- sd(nels_sub$expinc30)

ggplot(nels_sub, aes(x = expinc30)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30) +
  stat_function(fun = dnorm, args = list(mean = mu2, sd = sigma2), linewidth = 1) +
  labs(x = "expinc30 (<250000)", y = "Density", title = "Histogram (<250000) with Normal Curve")

## The Display Command: Use Stata as a Calculator ##

10 * 10
98 / 22

round(98 / 22, digits = 2)
round(98 / 22, digits = 1)
round(98 / 22, digits = 0)

round_to <- function(x, base) base * round(x / base)

round_to(98 / 22, 0.01)
round_to(98 / 22, 0.1)
round_to(98 / 22, 1.0)
