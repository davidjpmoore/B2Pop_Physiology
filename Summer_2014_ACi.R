setwd("C:/Users/ianshiach/Desktop/Grad School/Thesis/Processing/R/Processing")
aci <- read.table (file="Summer_2014_ACi.csv", sep=",", header=TRUE)
#Vcmax

#June
boxplot(june_vcmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "June 2014 Vcmax")

#July
boxplot(july_vcmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "July 2014 Vcmax")

#September
boxplot(september_vcmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "September 2014 Vcmax")

#Jmax

#June

boxplot(june_jmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Jmax",
        main = "June 2014 Jmax")

#July

boxplot(july_jmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Jmax",
        main = "July 2014 Jmax")

#September

boxplot(september_jmax ~ state, data = aci,
        xlab = "Genotype", ylab = "Jmax",
        main = "September 2014 Jmax")

#Biomass

boxplot(biomass ~ state, data = aci,
        xlab = "Genotype", ylab = "Biomass (g)", 
        main = "Estimated 2014 Biomass")

#Budbreak

boxplot(budbreak ~ state, data = aci,
        xlab = "Genotype", ylab = "Budbreak (doy)", 
        main = "2014 Budbreak")

#Branch Number

boxplot(branch_number ~ state, data = aci,
        xlab = "Genotype", ylab = "Number of Branches", 
        main = "2014 Number of Branches")
#Scatter Plots

plot(aci$budbreak, aci$biomass, xlab = "Budbreak (doy)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. Budbreak")
plot(aci$branch_number, aci$biomass, xlab = "Number of Branches", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. Branch Number")
plot(aci$june_vcmax, aci$biomass, xlab = "June Vcmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. June Vcmax")
plot(aci$july_vcmax, aci$biomass, xlab = "July Vcmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. July Vcmax")
plot(aci$september_vcmax, aci$biomass, xlab = "September Vcmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. September Vcmax")
plot(aci$june_jmax, aci$biomass, xlab = "June Jmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. June Jmax")
plot(aci$july_jmax, aci$biomass, xlab = "July Jmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. July Jmax")
plot(aci$september_jmax, aci$biomass, xlab = "September Jmax (...)", ylab = "Biomass (g)", 
     main = "2014 Biomass vs. September Jmax")




#ANOVAs
attach(aci)
anova = aov(biomass ~ budbreak * branch_number * june_vcmax * july_vcmax 
            * september_vcmax * june_jmax * july_jmax * september_jmax)
summary(anova)

anova2 = aov(biomass ~ june_vcmax * july_vcmax 
             * september_vcmax)
summary(anova2)



