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

# change one lowercase state name
aci_2014_qc_coef$genotype <- toupper(aci_2014_qc_coef$genotype)

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


aci_june <- aci_2014_qc_coef[which(aci_2014_qc_coef$date == "2014-06-08"), ]
aci_july <- aci_2014_qc_coef[which(aci_2014_qc_coef$date == "2014-07-09"), ]
aci_september <- aci_2014_qc_coef[which(aci_2014_qc_coef$date == "2014-09-09"), ]


aci$tree <- tolower(aci$tree)

aci_june <- join(aci_june, aci, by = "tree")
aci_july <- join(aci_july, aci, by = "tree")
aci_september <- join(aci_september, aci, by = "tree")


#Vcmax

#June
boxplot(Vcmax ~ genotype, data = aci_june,
        xlab = "Genotype", ylab = "Vcmax",
        main = "June 2014 Vcmax")

#July
boxplot(Vcmax ~ genotype, data = aci_july,
        xlab = "Genotype", ylab = "Vcmax",
        main = "July 2014 Vcmax")

#September
boxplot(Vcmax ~ genotype, data = aci_september,
        xlab = "Genotype", ylab = "Vcmax",
        main = "September 2014 Vcmax")

#bar chart


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


# bar chart photosynthesis all months

summary_2014_vcmax <- summarySE(aci_2014_qc_coef, measurevar="Vcmax", groupvars=c("genotype","date"))

ggplot(summary_2014_vcmax, aes(x=date, y=Vcmax, fill=genotype)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Vcmax-ci, ymax=Vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(30))


# bar chart photosynthesis june

summary_june_vcmax <- summarySE(aci_june, measurevar="Vcmax", groupvars=c("genotype"))

ggplot(summary_june_vcmax, aes(x=genotype, y=Vcmax, fill=genotype)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Vcmax-ci, ymax=Vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + theme(legend.position="none") + ggtitle("June Vcmax") + ylab("Vcmax (umol*m^-2*s^-1)") + xlab("State") + scale_y_continuous(limit = c(0, 126))


# bar chart photosynthesis july

summary_july_vcmax <- summarySE(aci_july, measurevar="Vcmax", groupvars=c("genotype"))

ggplot(summary_july_vcmax, aes(x=genotype, y=Vcmax, fill=genotype)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Vcmax-ci, ymax=Vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + theme(legend.position="none") + ggtitle("july Vcmax") + ylab("Vcmax (umol*m^-2*s^-1)") + xlab("State") + scale_y_continuous(limit = c(0, 126))




# bar chart photosynthesis september

summary_september_vcmax <- summarySE(aci_september, measurevar="Vcmax", groupvars=c("genotype"))

ggplot(summary_september_vcmax, aes(x=genotype, y=Vcmax, fill=genotype)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Vcmax-ci, ymax=Vcmax+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) + theme(legend.position="none") + ggtitle("September Vcmax") + ylab("Vcmax (umol*m^-2*s^-1)") + xlab("State") + scale_y_continuous(limit = c(0, 126))


#Vcmax
# june anova

oneway.test(Vcmax ~ genotype, data = aci_june, var.equal=TRUE)

anova_vcmax_jun2014 <- lm(Vcmax ~ genotype, data = aci_june)
summary(anova_vcmax_jun2014)
anova(anova_vcmax_jun2014)

anova_june_vcmax <- aov(Vcmax ~ genotype, data = aci_june)
summary(anova_june_vcmax)



#july anova

oneway.test(Vcmax ~ genotype, data = aci_july, var.equal=TRUE)

anova_vcmax_jul2014 <- lm(Vcmax ~ genotype, data = aci_july)
summary(anova_vcmax_jul2014)
anova(anova_vcmax_jul2014)

anova_july_vcmax <- aov(Vcmax ~ genotype, data = aci_july)
summary(anova_july_vcmax)





#september anova

oneway.test(Vcmax ~ genotype, data = aci_september, var.equal=TRUE)


anova_vcmax_sept2014 <- lm(Vcmax ~ genotype, data = aci_september)
summary(anova_vcmax_sept2014)
anova(anova_vcmax_sept2014)

anova_september_vcmax <- aov(Vcmax ~ genotype, data = aci_september)
summary(anova_september_vcmax)
TukeyHSD(anova_september_vcmax)

#Jmax

# june anova

oneway.test(Jmax ~ genotype, data = aci_june, var.equal=TRUE)

anova_Jmax_jun2014 <- lm(Jmax ~ genotype, data = aci_june)
summary(anova_Jmax_jun2014)
anova(anova_Jmax_jun2014)

anova_june_Jmax <- aov(Jmax ~ genotype, data = aci_june)
summary(anova_june_Jmax)



#july anova

oneway.test(Jmax ~ genotype, data = aci_july, var.equal=TRUE)

anova_Jmax_jul2014 <- lm(Jmax ~ genotype, data = aci_july)
summary(anova_Jmax_jul2014)
anova(anova_Jmax_jul2014)

anova_july_Jmax <- aov(Jmax ~ genotype, data = aci_july)
summary(anova_july_Jmax)





#september anova

oneway.test(Jmax ~ genotype, data = aci_september, var.equal=TRUE)


anova_Jmax_sept2014 <- lm(Jmax ~ genotype, data = aci_september)
summary(anova_Jmax_sept2014)
anova(anova_Jmax_sept2014)

anova_september_Jmax <- aov(Jmax ~ genotype, data = aci_september)
summary(anova_september_Jmax)
TukeyHSD(anova_september_Jmax)












# biomass


#June
# boxplot(biomass ~ genotype, data = aci_june,
#         xlab = "Genotype", ylab = "Vcmax",
#         main = "June 2014 Vcmax")
# 
# #July
# boxplot(biomass ~ genotype, data = aci_july,
#         xlab = "Genotype", ylab = "Vcmax",
#         main = "July 2014 Vcmax")
# 
# #September
# boxplot(biomass ~ genotype, data = aci_september,
#         xlab = "Genotype", ylab = "Vcmax",
#         main = "September 2014 Vcmax")
