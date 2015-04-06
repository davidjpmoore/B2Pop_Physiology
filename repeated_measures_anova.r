#install package dplyr 
#cheatsheet - http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
library(dplyr)

#read data in
aci <- read.table (file="data/2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)

#display table of data
tbl_df(aci)

#ISOdate or rDate formats
aci$rDate = as.Date(aci$date, "%m/%d/%Y")

#subsetting data for 2013 and 2014 by themselves
aci2013 <- subset(aci, year == 2013)
aci2014 <- subset(aci, year == 2014)

#do some simple plots

#INSTALL PACKAGE ggplot2 & Pull the library
#install.packages("ggplot2")
library(ggplot2)

#you can find more examples for using ggplot2 at the following locations
# http://ggplot2.org/ 
# http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

#first DEFINE the plot you want to see *NOTE instead of using ENZdat$pH as x you define the dataframe FIRST and then the x and y axes
a <- ggplot(aci, aes(x=rDate, y=vcmax))
#create a simple plot
a + geom_point()


a + aes(shape = factor(genotype)) +
  geom_point(aes(colour = factor(genotype)), size = 4) +
  geom_point(colour="grey90", size = 1.5)


#
#for just 2013
#

a13 <- ggplot(aci2013, aes(x=rDate, y=vcmax))
#create a simple plot
a13 + geom_point()


a13 + theme_bw() + aes(shape = factor(genotype)) +
  geom_point(aes(colour = factor(genotype)), size = 4) +
  geom_point(colour="grey90", size = 1.5)




#
#for just 2014
#
a14 <- ggplot(aci2014, aes(x=rDate, y=vcmax))
#create a simple plot
a14 + geom_point()


a14 + theme_bw() + aes(shape = factor(genotype)) +
  geom_point(aes(colour = factor(genotype)), size = 4) +
  geom_point(colour="grey90", size = 1.5)



#examine simple plots and write down step by step what you need to make the next plot

# 1) we want a plot of the MEAN Vcmax for EACH genotype at each date
# 2) we want the standard error of that mean
# could use tapply

# 3) we want to know if these means are different from each other
#could do an ANOVA - repeated measures ANOVA 

# Does my data conform to the ASSUMPTIONS OF THE ANALYSIS I WANT TO DO?
# What are the assumptions of the ANOVA?

# QUESTION1: What is the appropriate model structure for THIS analysis? (what are the main effects, interactions - what is your unit of replication?)
# QUESTION1: WHAT are the differences I care about for THIS analysis?
# Question3: What is the appropriate statistical test? 


######
#try UCLA webpage for examples of statistical models

demo1.aov <- aov(vcmax ~ genotype * rdate + Error(tree), data = aci)
summary(demo1.aov)


aov.out = aov(vcmax ~ rDate + Error(tree/rDate), data=aci)
summary(aov.out)
