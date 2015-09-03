setwd("./data/")


aci <- read.table (file="2013_2014_photosynthesis_master.csv", sep=",", header=TRUE)
data <- read.table (file="2014_all_but_photosynthesis_master.csv", sep=",", header=TRUE)

load("isoprene_ppbv.Rda")

#subset Ian's trees
aci_focus <- aci[aci$state %in% c("WA/OK","WA/TX","WA/IL","WA/MO","WA/MN"), ]

#subset 2013/2014
aci2013 <- subset(aci_focus, year == 2013)
aci2014 <- subset(aci_focus, year == 2014)









# Vcmax



#June
boxplot(vcmax ~ state, data = june_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "June 2014 Vcmax")



#July

boxplot(vcmax ~ state, data = july_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "july 2014 Vcmax")



#September

boxplot(vcmax ~ state, data = september_aci,
        xlab = "Genotype", ylab = "Vcmax",
        main = "september 2014 Vcmax")







# jmax




#June

boxplot(jmax ~ state, data = june_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "June 2014 jmax")

#July

boxplot(jmax ~ state, data = july_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "july 2014 jmax")



#September

boxplot(jmax ~ state, data = september_aci,
        xlab = "Genotype", ylab = "jmax",
        main = "september 2014 jmax")





# Biomass


boxplot(biomass ~ state, data = data,
        xlab = "Genotype", ylab = "Biomass (g)", 
        main = "2014 Biomass")

# Start growth


boxplot(start_growth ~ state, data = data,
        xlab = "Genotype", ylab = "start_growth", 
        main = "2014 start_growth")



# Duration growth

boxplot(duration_growth ~ state, data = data,
        xlab = "Genotype", ylab = "duration_growth", 
        main = "2014 duration_growth")


# June branches


boxplot(june_branch_number ~ state, data = data,
        xlab = "Genotype", ylab = "june_branch_number", 
        main = "2014 june_branch_number")



# December branches


boxplot(december_branch_number ~ state, data = data,
        xlab = "Genotype", ylab = "december_branch_number", 
        main = "2014 december_branch_number")


# June total diameter


boxplot(june_total_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "june_total_diameter", 
        main = "2014 june_total_diameter")


# December total diameter



boxplot(december_total_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "december_total_diameter", 
        main = "2014 december_total_diameter")


# June diameter of largest branch



boxplot(june_max_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "june_max_diameter", 
        main = "2014 june_max_diameter")



# December diameter of largest branch


boxplot(december_max_diameter ~ state, data = data,
        xlab = "Genotype", ylab = "december_max_diameter", 
        main = "2014 december_max_diameter")

# Leaf number


boxplot(leaf_number ~ state, data = data,
        xlab = "Genotype", ylab = "leaf_number", 
        main = "2014 leaf_number")

# Isoprene

boxplot(isoprene_nmol_per_m2_s ~ state, data = isoprene_final,
        xlab = "Genotype", ylab = "Isoprene nmol/(s*m^2)", 
        main = "2015 isoprene flux")


