### Author: Ian Shiach
### Date: 09/16/2015
### Purpose: To calculate a flux of isoprene in mmol isoprene/m2/sec from ppbv isoprene, using Amberly/Russ equations


setwd("./data/")

#read isoprene in ppbv
#load df isoprene_ppbv 

load("isoprene_ppbv.Rda")

# the input in ppbv can also be expressed as ug_isoprene/kg_air

#define constants

##############################
# micrograms of isoprene to milimoles of isoprene (ug_iso -> mmol_iso)

# micrograms of isoprene to grams of isoprene
# 1 g_iso/1000000 ug_iso

a <- 1/1000000

# grams of isoprene to moles of isoprene
# 1 mol_iso/68.12 g_iso

b <- 1/68.12

#### moles of isoprene to milimoles of isoprene
#### 1000 mmol_iso/1 mol_iso

####c <- 1000/1

# looks like it should be nanomoles of isoprene, per Eller et al. 2012

# moles of isoprene to nanomoles of isoprene
# 1000000000 nmol_iso/1 mol_iso

c <- 1000000000/1

###############################
# kilograms of air to seconds (kg_air -> s)

# kilograms of air to cubic meters of air (density of air;  temperature dependent)
# need to add source of value and possibly change to equation
# this is the value for 35C
# 1.1455 kg_air/1 m^3_air

d <- 1.1455/1

# cubic meters of air to liters of air
# 1 m^3_air/1000 L_air

e <- 1/1000

# liters of air to moles of air
# 22.4 L_air/1 mol_air

f <- 22.4/1

# moles of air to micromoles of air
# 1 mol_air/1000000 umol_air

g <- 1/1000000

# micromoles of air to seconds (LICOR flow rate)
# 600 umol_air/1 s

h <- 600/1

###############################
# milimoles of isoprene per second to milimoles of isoprene per square meter second (mmol_iso/s -> mmol_iso/(s*m^2))

# divide by leaf area (area of LICOR cuvette head)
# 1/6 cm^2

i <- 1/6

# square centimeters to square meters
# 10000 cm^2/1 m^2

j <- 10000/1

###############################
# create new data frame

isoprene_final <- data.frame(isoprene_ppbv)

# apply unit converions

isoprene_final$isoprene_nmol_per_m2_s_ian <- isoprene_ppbv$isoprene_ppbv * a * b * c * d * e * f * g * h * i * j


# apply Russ conversions

isoprene_final$isoprene_nmol_per_m2_s_russ <- isoprene_ppbv$isoprene_ppbv * a * h * i * j


# save df isoprene_final as .Rda

save(isoprene_final, file="isoprene_final.Rda")


