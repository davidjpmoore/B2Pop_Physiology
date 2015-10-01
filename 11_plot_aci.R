#11_plot_aci
#Author: Ian Shiach
#Date: 09/05/2015
#Purpose: Plot aci


# libraries

library(ggplot2)
library(plyr)

# load aci files

setwd("./data/")

load ("aci_2014_qc_coef.Rda")

manual_aci <- read.table (file="2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)

# subset manual_aci for just relevant variables and 2014

manual_aci <- manual_aci[c("vcmax","jmax", "date", "tree", "state", "year")]
manual_aci <- manual_aci[ which(manual_aci$year=="2014"), ]

# change tree in manual to lowercase

manual_aci$tree <- tolower(manual_aci$tree)

# convert to r date

aci_2014_qc_coef$date <- as.Date(aci_2014_qc_coef$date, format = "%m/%d/%Y")
manual_aci$date <- as.Date(manual_aci$date, format = "%m/%d/%Y")

# join dfs

join_auto_manual_aci <- join(manual_aci, aci_2014_qc_coef, by = c("tree","date"))

# pull out N/As--aci curves that could not be fit

join_no_nas <- na.omit(join_auto_manual_aci)


# plot auto vcmax vs manual vcmax

plot(join_no_nas$vcmax, join_no_nas$Vcmax)
abline(lm(join_no_nas$Vcmax ~ join_no_nas$vcmax)) 
abline(0,1)
