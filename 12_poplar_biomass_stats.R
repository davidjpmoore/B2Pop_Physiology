##Author: Ian Shiach
##Date: 10/14/2015
##Purpose: run repeated measures ANOVA on biomass data




library(plyr)
#library(car)
library(ggplot2)
library(lsmeans)
#library(agricolae)
#library(multcomp)
#library(nlme)


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
# for split-plot/mixed design ANOVA

biomass_for_anova <- all_but_photosynthesis[ ,c(1,3,5,18,19)]
biomass_for_anova$yr <- c("yr1")
biomass_for_anova$yr2 <- c("yr2")
biomass_for_anova$state <- as.character(biomass_for_anova$state)
# 
# 
biomass_for_anova2 <- data.frame(c(biomass_for_anova$state, biomass_for_anova$state))
colnames(biomass_for_anova2) <- c("state")
biomass_for_anova2$tree <- c(biomass_for_anova$tree,biomass_for_anova$tree)
biomass_for_anova2$biomass <- c(biomass_for_anova$X2013_biomass, biomass_for_anova$X2014_biomass)
biomass_for_anova2$yr <- c(biomass_for_anova$yr, biomass_for_anova$yr2)

# split-plot/mixed design ANOVA (from http://www.cookbook-r.com/Statistical_analysis/ANOVA/)

aov <- aov(biomass ~ state*yr + Error(tree/yr), data=biomass_for_anova2)
summary(aov)
model.tables(aov, "means")

a <- aov$`(Intercept)`
b <- aov$ tree
c <- aov$`tree:yr`
a$residuals


# Least squares means from https://cran.r-project.org/web/packages/lsmeans/vignettes/using-lsmeans.pdf



biomass.lm1 <- lm(biomass ~ yr + state, data = biomass_for_anova2)
anova(biomass.lm1)

# define reference grid

biomass.rg1 <- ref.grid(biomass.lm1)
summary(biomass.rg1)

# 

lsmeans(biomass.lm1, "yr")

lsmeans(biomass.lm1, "state")


# barplots

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




summary_biomass <- summarySE(biomass_for_anova2, measurevar="biomass", groupvars=c("state","yr"))

ggplot(summary_biomass, aes(x=yr, y=biomass, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=biomass-ci, ymax=biomass+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))




# bar chart phenology


summary_phenology <- summarySE(all_but_photosynthesis, measurevar="duration_growth", groupvars=c("state"))

ggplot(summary_phenology, aes(x=state, y=duration_growth, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=duration_growth-ci, ymax=duration_growth+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))



# bar chart branch number


summary_branch_num <- summarySE(all_but_photosynthesis, measurevar="june_branch_number", groupvars=c("state"))

ggplot(summary_branch_num, aes(x=state, y=june_branch_number, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=june_branch_number-ci, ymax=june_branch_number+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))


# bar chart leaf number


summary_leaf_num <- summarySE(all_but_photosynthesis, measurevar="leaf_number", groupvars=c("state"))

ggplot(summary_leaf_num, aes(x=state, y=leaf_number, fill=state)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=leaf_number-ci, ymax=leaf_number+ci),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))






# separate anovas for the two years to test if split plot is giving same results
# two ways to do this

oneway.test(X2013_biomass ~ state, data = biomass_for_anova, var.equal=TRUE)

anova_2013 <- lm(X2013_biomass ~ state, data = biomass_for_anova)
summary(anova_2013)
anova(anova_2013)

oneway.test(X2014_biomass ~ state, data = biomass_for_anova, var.equal=TRUE)

anova_2014 <- lm(X2014_biomass ~ state, data = biomass_for_anova)
summary(anova_2014)
anova(anova_2014)



# Tukey HSD test from http://www.r-bloggers.com/anova-and-tukeys-test-on-r/

HSD.test(aov, 'biomass_for_anova2$biomass')




# plot jitter and boxplot from isoprene files

# biomass_vs_yr <- ggplot(biomass_for_anova2, aes(x=yr, y=biomass))
# # 
# biomass_vs_yr + aes(shape = factor(state)) + scale_shape(solid = FALSE, name ="genotype") +
#   geom_boxplot(lwd=1) +
#   geom_point(aes( shape = factor(state)), size = 5, position = "jitter") +
#   theme_classic() +
#   theme(axis.text=element_text(size=20),
#         axis.title=element_text(size=22,face="bold")) + 
#   theme(panel.border = element_blank(), axis.line = element_line(colour="black", size=2, lineend="square"))+
#   theme(axis.ticks = element_line(colour="black", size=2, lineend="square"))+
#   ylab("biomass")+
#   xlab("yr") 




# jitter boxplot from http://www.ashander.info/posts/2015/04/barchart-alternatives-in-base-r/

# 5 genotypes, both years together

{
boxplot( biomass ~ state, biomass_for_anova2, ylab='biomass', xlab='state')
stripchart(biomass ~ state, biomass_for_anova2, method = 'jitter', add = TRUE, vertical = TRUE,
           pch = 19)
  }

# 5 genotypes over 2 years

{
boxplot( biomass ~ state : yr, biomass_for_anova2, ylab='biomass', xlab='state')
stripchart(biomass ~ state : yr, biomass_for_anova2, method = 'jitter', add = TRUE, vertical = TRUE,
           pch = 19)
  }










# splitPlt <- aov(biomass ~ genotype + Error(tree/genotype) + yr*genotype,data = biomass_for_anova2)
# 
# spltplt2 <- aov(biomass ~ genotype * tree + Error(yr:genotype), data = biomass_for_anova2)
# summary(spltplt2)
# 
# 
# with(biomass_for_anova2, xyplot(biomass ~ tree | genotype, groups = yr))
# 



# rearrange for two-factor
# following guidelines in http://rtutorialseries.blogspot.com/2011/02/r-tutorial-series-two-way-repeated.html
# 
# biomass_for_anova <- all_but_photosynthesis[ ,c(1,2,5,17,18)]
# biomass_for_anova2 <- biomass_for_anova[,c(1,2,4,5,3)]
# colnames(biomass_for_anova2) <- c("tree","genotype_yr1","genotype_yr2","biomass_yr1","biomass_yr2")
# 
# idata <- data.frame(c("180-372","180-372","199-586","199-586","49-177","49-177","50-194","50-194","57-276","57-276"),c("yr1","yr2","yr1","yr2","yr1","yr2","yr1","yr2","yr1","yr2"))
# colnames(idata) <- c("genotype","year")
# 
# #use cbind() to bind the columns of the original dataset
# factorBind <- cbind(biomass_for_anova2$genotype_yr1, biomass_for_anova2$genotype_yr2, biomass_for_anova2$biomass_yr1, biomass_for_anova2$biomass_yr2)
# 
# #use lm() to generate a linear model using the bound columns from step 1
# factorModel <- lm(factorBind ~ 1)
# 
# 
# #compose the Anova(mod, idata, idesign) function
# analysis <- Anova(factorModel, idata = idata, idesign = ~factor * year)
# 
# #use summary(object) to visualize the results of the repeated measures ANOVA
# summary(analysis)



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

