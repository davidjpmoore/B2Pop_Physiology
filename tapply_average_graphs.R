setwd("C:/Users/ianshiach/Desktop/Grad School/Thesis/Processing/R/Processing")
aci <- read.table (file="2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)

#purpose
#author

#libraries
library(ggplot2)

#subset 2014
aci2014 <- subset(aci, year == 2014)
  
#tapply to get averages
#test commit


tapply(aci2014$vcmax, aci2014$genotype, mean)

#summary stats
#trying to follow http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

summary <- summarySE(aci2014, measurevar="vcmax", groupvars=c("state","month"))
summary


#plot means



# Standard error of the mean
ggplot(summary, aes(x=month, y=vcmax, colour=state)) + 
  geom_errorbar(aes(ymin=vcmax-se, ymax=vcmax+se), width=.1) +
  geom_line() +
  geom_point()


# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.1) # move them .05 to the left and right

ggplot(summary, aes(x=month, y=vcmax, colour=state)) + 
  geom_errorbar(aes(ymin=vcmax-se, ymax=vcmax+se), width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd)


# Use 95% confidence interval instead of SEM
ggplot(summary, aes(x=month, y=vcmax, colour=state)) + 
  geom_errorbar(aes(ymin=vcmax-ci, ymax=vcmax+ci), width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd)

# Black error bars - notice the mapping of 'group=state' -- without it, the error
# bars won't be dodged!
ggplot(summary, aes(x=month, y=vcmax, colour=state, group=state)) + 
  geom_errorbar(aes(ymin=vcmax-ci, ymax=vcmax+ci), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=3)


# Use month as a factor rather than numeric
summary2 <- summary
summary2$month <- factor(summary2$month)

# Error bars represent standard error of the mean
ggplot(summary2, aes(x=month, y=vcmax, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=vcmax-se, ymax=vcmax+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))


# Use 95% confidence intervals instead of SEM
ggplot(summary2, aes(x=month, y=vcmax, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=vcmax-ci, ymax=vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))
