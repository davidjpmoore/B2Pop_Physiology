##Author: Ian Shiach
##Date: 10/14/2015
##Purpose: run repeated measures ANOVA on biomass data




library(plyr)
library(car)


setwd("./data/")

# read in biomass data and join into single dataframe

all_but_photosynthesis <- read.table (file="2014_all_but_photosynthesis_master.csv", sep=",", header=TRUE)

all_but_photosynthesis$tree <- tolower(all_but_photosynthesis$tree)

biomass_2013 <- read.table("2013_poplar_biomass.csv", sep = ",", header = TRUE)

biomass_2013$tree <- tolower(biomass_2013$tree)

all_but_photosynthesis <- join(all_but_photosynthesis, biomass_2013, by = "tree")

# save df to .rda

save(all_but_photosynthesis, file="2014_all_but_photosynthesis_master.Rda")

# load .rda to skip previous steps
load("2014_all_but_photosynthesis_master.Rda")



# check for normality
# whole dataset

result <- shapiro.test(all_but_photosynthesis$X2013_biomass)
result$p.value

result2 <- shapiro.test(all_but_photosynthesis$X2014_biomass)
result2$p.value

# broken into groups (n=5)

with(all_but_photosynthesis, tapply(X2013_biomass, genotype, shapiro.test))
with(all_but_photosynthesis, tapply(X2014_biomass, genotype, shapiro.test))

# rearrange df for ANOVA
# for one-factor repeated measures ANOVA

# biomass_for_anova <- all_but_photosynthesis[ ,c(2,5,17,18)]
# biomass_for_anova$yr <- c("yr1")
# biomass_for_anova$yr2 <- c("yr2")
# 
# 
# biomass_for_anova2 <- data.frame(c(biomass_for_anova$genotype, biomass_for_anova$genotype.1))
# colnames(biomass_for_anova2) <- c("genotype")
# biomass_for_anova2$biomass <- c(biomass_for_anova$X2014_biomass, biomass_for_anova$X2013_biomass)
# biomass_for_anova2$yr <- c(biomass_for_anova$yr, biomass_for_anova$yr2)

# rearrange for two-factor
# following guidelines in http://rtutorialseries.blogspot.com/2011/02/r-tutorial-series-two-way-repeated.html

biomass_for_anova <- all_but_photosynthesis[ ,c(1,2,5,17,18)]
biomass_for_anova2 <- biomass_for_anova[,c(1,2,4,5,3)]
colnames(biomass_for_anova2) <- c("tree","genotype_yr1","genotype_yr2","biomass_yr1","biomass_yr2")

idata <- data.frame(c("genotype","genotype","biomass","biomass"),c("yr1","yr2","yr1","yr2"))
colnames(idata) <- c("factor","year")

#use cbind() to bind the columns of the original dataset
factorBind <- cbind(biomass_for_anova2$genotype_yr1, biomass_for_anova2$genotype_yr2, biomass_for_anova2$biomass_yr1, biomass_for_anova2$biomass_yr2)

#use lm() to generate a linear model using the bound columns from step 1
factorModel <- lm(factorBind ~ 1)


#compose the Anova(mod, idata, idesign) function
analysis <- Anova(factorModel, idata = idata, idesign = ~factor * year)

#use summary(object) to visualize the results of the repeated measures ANOVA
summary(analysis)



# repeated measures ANOVA

# code from https://gribblelab.wordpress.com/2009/03/09/repeated-measures-anova-using-r/
# Note: to adhere to the sum-to-zero convention for effect weights, you should always do this before running anovas in R:

# options(contrasts=c("contr.sum","contr.poly"))
# 
# 
# # ANOVA
# am1 <- aov(biomass ~ yr + Error(genotype/yr), data=biomass_for_anova2)
# 
# 
# summary(am1)

