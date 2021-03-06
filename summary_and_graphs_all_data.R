setwd("./data/")


aci <- read.table (file="2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)
data <- read.table (file="2014_all_but_photosynthesis_master.csv", sep=",", header=TRUE)


#subset Ian's trees
aci_focus <- aci[aci$state %in% c("WA/OK","WA/TX","WA/IL","WA/MO","WA/MN"), ]

#subset 2013/2014
aci2013 <- subset(aci_focus, year == 2013)
aci2014 <- subset(aci_focus, year == 2014)



#libraries
library(ggplot2)

#tapply to get averages

#tapply(aci2014$vcmax, aci2014$genotype, mean)

#summary stats
#trying to follow http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/

#define function summarySE

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






#plot means




# Summaries, bar graphs, boxplots

# Graphs use 95% confidence intervals instead of SEM. See reference above.

# Vcmax

#2013
summary_vcmax <- summarySE(aci2013, measurevar="vcmax", groupvars=c("state","month"))

ggplot(summary_vcmax, aes(x=month, y=vcmax, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=vcmax-ci, ymax=vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

#2014
summary_vcmax <- summarySE(aci2014, measurevar="vcmax", groupvars=c("state","month"))

ggplot(summary_vcmax, aes(x=month, y=vcmax, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=vcmax-ci, ymax=vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))



#June
june_aci <- subset(aci2014, month == "june")

boxplot(vcmax ~ state, data = june_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "June 2014 Vcmax")

qplot(vcmax, data$biomass, colour = state, data = june_aci)


#July
july_aci <- subset(aci2014, month == "july")

boxplot(vcmax ~ state, data = july_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "july 2014 Vcmax")

qplot(vcmax, data$biomass, colour = state, data = july_aci)


#September
september_aci <- subset(aci2014, month == "september")

boxplot(vcmax ~ state, data = september_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "september 2014 Vcmax")

qplot(vcmax, data$biomass, colour = state, data = september_aci)






# jmax

summary_jmax <- summarySE(aci2014, measurevar="jmax", groupvars=c("state","month"))

ggplot(summary_jmax, aes(x=month, y=jmax, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=jmax-ci, ymax=jmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

qplot(jmax, data$biomass, colour = state, data = june_aci)



#June
june_aci <- subset(aci2014, month == "june")

boxplot(jmax ~ state, data = june_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "June 2014 jmax")

#July
july_aci <- subset(aci2014, month == "july")

boxplot(jmax ~ state, data = july_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "july 2014 jmax")

qplot(jmax, data$biomass, colour = state, data = july_aci)


#September
september_aci <- subset(aci2014, month == "september")

boxplot(jmax ~ state, data = september_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "september 2014 jmax")

qplot(jmax, data$biomass, colour = state, data = september_aci)




# Biomass

summary_biomass <- summarySE(data, measurevar="biomass", groupvars=c("state"))

ggplot(summary_biomass, aes(x=state, y=biomass, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=biomass-ci, ymax=biomass+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(biomass ~ state, data = data,
        xlab = "Genotype", ylab = "Biomass (g)", 
        main = "2014 Biomass")

# Start growth
summary_start_growth <- summarySE(data, measurevar="start_growth", groupvars=c("state"))

ggplot(summary_start_growth, aes(x=state, y=start_growth, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=start_growth-ci, ymax=start_growth+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(start_growth ~ state, data = data,
        xlab = "Genotype", ylab = "start_growth", 
        main = "2014 start_growth")


plot(data$start_growth, data$biomass, xlab = "Start growth (doy)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. Budbreak")

qplot(start_growth, biomass, colour = state, data = data)

# End growth

summary_end_growth <- summarySE(data, measurevar="end_growth", groupvars=c("state"))


ggplot(summary_end_growth, aes(x=state, y=end_growth, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=end_growth-ci, ymax=end_growth+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))


boxplot(end_growth ~ state, data = data,
        xlab = "Genotype", ylab = "end_growth", 
        main = "2014 end_growth")




# Duration growth
summary_duration_growth <- summarySE(data, measurevar="duration_growth", groupvars=c("state"))

ggplot(summary_duration_growth, aes(x=state, y=duration_growth, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=duration_growth-ci, ymax=duration_growth+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(duration_growth ~ state, data = data,
        xlab = "Genotype", ylab = "duration_growth", 
        main = "2014 duration_growth")

plot(data$duration_growth, data$biomass, xlab = "Duration growth (days)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. Growth duration")

qplot(duration_growth, biomass, colour = state, data = data)


# June branches

summary_june_branch_number <- summarySE(data, measurevar="june_branch_number", groupvars=c("state"))

ggplot(summary_june_branch_number, aes(x=state, y=june_branch_number, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=june_branch_number-ci, ymax=june_branch_number+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(june_branch_number ~ state, data = data,
        xlab = "Genotype", ylab = "june_branch_number", 
        main = "2014 june_branch_number")

plot(data$june_branch_number, data$biomass, xlab = "June branch number", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. June branch number")

qplot(june_branch_number, biomass, colour = state, data = data)


# December branches

summary_december_branch_number <- summarySE(data, measurevar="december_branch_number", groupvars=c("state"))

ggplot(summary_december_branch_number, aes(x=state, y=december_branch_number, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=december_branch_number-ci, ymax=december_branch_number+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(december_branch_number ~ state, data = data,
        xlab = "Genotype", ylab = "december_branch_number", 
        main = "2014 december_branch_number")


# June total diameter

summary_june_total_diameter <- summarySE(data, measurevar="june_total_diameter", groupvars=c("state"))

ggplot(summary_june_total_diameter, aes(x=state, y=june_total_diameter, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=june_total_diameter-ci, ymax=june_total_diameter+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(june_total_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "june_total_diameter", 
        main = "2014 june_total_diameter")

plot(data$june_total_diameter, data$biomass, xlab = "June total diameter", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. June total diameter")

qplot(june_total_diameter, biomass, colour = state, data = data)


# December total diameter

summary_december_total_diameter <- summarySE(data, measurevar="december_total_diameter", groupvars=c("state"))

ggplot(summary_december_total_diameter, aes(x=state, y=december_total_diameter, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=december_total_diameter-ci, ymax=december_total_diameter+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))


boxplot(december_total_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "december_total_diameter", 
        main = "2014 december_total_diameter")


# June diameter of largest branch

summary_june_max_diameter <- summarySE(data, measurevar="june_max_diameter", groupvars=c("state"))


ggplot(summary_june_max_diameter, aes(x=state, y=june_max_diameter, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=june_max_diameter-ci, ymax=june_max_diameter+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(june_max_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "june_max_diameter", 
        main = "2014 june_max_diameter")

plot(data$june_max_diameter, data$biomass, xlab = "June max diameter", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. June max diameter")

qplot(june_max_diameter, biomass, colour = state, data = data)


# December diameter of largest branch

summary_december_max_diameter <- summarySE(data, measurevar="december_max_diameter", groupvars=c("state"))

ggplot(summary_december_max_diameter, aes(x=state, y=december_max_diameter, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=december_max_diameter-ci, ymax=december_max_diameter+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(december_max_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "december_max_diameter", 
        main = "2014 december_max_diameter")

# Leaf number

summary_leaf_number <- summarySE(data, measurevar="leaf_number", groupvars=c("state"))

ggplot(summary_leaf_number, aes(x=state, y=leaf_number, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=leaf_number-ci, ymax=leaf_number+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

boxplot(leaf_number ~ state, data = data,
        xlab = "Genotype", ylab = "leaf_number", 
        main = "2014 leaf_number")

plot(data$leaf_number, data$biomass, xlab = "Leaf number", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. Leaf number")

qplot(leaf_number, biomass, colour = state, data = data)



