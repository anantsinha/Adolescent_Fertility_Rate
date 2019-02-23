#Preliminaries
rm(list=ls())
library("utils")
library("tidyverse")
setwd("/Users/Anant/WorldBank_Gender")
#Getting the data
gender_data <- as_tibble(read.csv("./Gender_StatsData.csv"))