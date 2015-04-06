aci <- read.table (file="2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)

aov.out = aov(vcmax ~ doy + Error(tree/doy), data=aci)
summary(aov.out)
