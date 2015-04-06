#install package dplyr 
#cheatsheet - http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
library(dplyr)

aci <- read.table (file="data/2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)

#display table of data
tbl_df(aci)

#ISOdate or rDate formats
aci$rDate = as.Date(aci$date, "%m/%d/%Y")


#subsetting data for 2013 and 2014 by themselves
aci2013 <- subset(aci, year == 2013)
aci2014 <- subset(aci, year == 2014)

plot(aci$date,aci$vcmax)

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




aov.out = aov(vcmax ~ rDate + Error(tree/rDate), data=aci)
summary(aov.out)
