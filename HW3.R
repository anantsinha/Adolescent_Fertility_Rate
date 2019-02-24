#Preliminaries
rm(list=ls())
library("utils")
library("tidyverse")
setwd("/Users/Anant/WorldBank_Gender")
#Getting the data
gender_data <- as_tibble(read.csv("./Gender_StatsData.csv"))

##Understanding tibble structure (following three commmands)
##Using 'View' in RStudio will simplify this process

#printing top ten entries
head(gender_data) %>% print

#printing dimensions of tibble
dim(gender_data)

#printing all indicators
gender_data %>%
  select(Indicator.Name) %>%
  unique %>%
  print

# Separate adolescent fertility rate for each country-year
teenager_fr <- filter(gender_data, Indicator.Code == "SP.ADO.TFRT")

#remove gender_data
rm(gender_data)

#View data by income level
by_income_level <- filter(teenager_fr, Country.Code %in% c("LIC", "MIC", "HIC", "WLD"))

#Each row to contain one group_year
plotdata_bygroupyear <- gather(by_income_level, Year, FertilityRate, X1960:X2015) %>%
  select(Year, Country.Name, Country.Code, FertilityRate) %>%
  mutate(Year=as.numeric(str_replace(Year, "X", "")))

#Plot by FertilityRate over Time (Year)
ggplot(plotdata_bygroupyear, aes (x = Year, y = FertilityRate), group = Country.Code, color = Country.Code)
+ geom_line()
+ labs(title='Fertility Rate by Country-Income-Level over Time')

##Plot fertility rate High Income Countries
filter(plotdata_bygroupyear, Country.Code == "HIC") %>%
  ggplot(aes(x = Year, y = FertilityRate)) +
  geom_line()

##Plot fertility rate Middle Income Countries
filter(plotdata_bygroupyear, Country.Code == "MIC") %>%
  ggplot(aes(x = Year, y = FertilityRate)) +
  geom_line()

##Plot fertility rate Low Income Countries
filter(plotdata_bygroupyear, Country.Code == "LIC") %>%
  ggplot(aes(x = Year, y = FertilityRate)) +
  geom_line()

##Plot fertility rate World
filter(plotdata_bygroupyear, Country.Code == "WLD") %>%
  ggplot(aes(x = Year, y = FertilityRate)) +
  geom_line()