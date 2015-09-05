#purpose: testing temperature functions for rho (density of air) & comparing with Amberly's data
#author: Dave Moore - based on Ian's workflow

#Load data
#Amberly's data from B2

B2Physiologymaster = read.table("./data/Neice_IsopreneAci2014.csv", na.strings=c('.'), stringsAsFactors=FALSE, head=TRUE, sep=",")

ASL = 1164.34 #elevation of B2
P_AirPressPa = 101325*(1 - 2.25577*10^-5*ASL)^5.25588 #air pressure Pa as a function of Temperature        
P_AirPress_KPa = P_AirPressPa/1000 #unit conversion to kPa
# P_AirPressPa = air pressure (Pa)
# ASL = altitude above sea level (m)



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

#d is properaly described as rho - density of air

M_da = 0.028964 #Molar mass of dry air, kg/mol
M_wv = 0.018016 #Molar mass of water vapor,  kg/mol
R_ugc = 8.314 #Universal gas constant,  J/(K·mol)
#P_wv = # partial pressure of water vapour
  
  P_wv25 = 3169.0 # @25 C Water Vapor Pressure P(Pa)
P_wv35  = 5626.7 # @ 35 C Water Vapor Pressure P(Pa)

#hack for two different Water Vapor Pressure values for 25 and 35 degrees 
diff_Pwv=(5626.7 - 3169.0)
B2Physiologymaster$P_wv=5626.7 + ((B2Physiologymaster$Tref-35)/10)*diff_Pwv 

R_spc = 287.058 # J/(kg·K)


B2Physiologymaster$Temp_kelvin = 273.16 + B2Physiologymaster$Tref
B2Physiologymaster$rho_dry = P_AirPressPa/ (R_spc * B2Physiologymaster$Temp_kelvin)
# R_spc = specific gas constant for dry air is 287.058 J/(kg·K)

#rho for humid air (note this is a hack that only works for 25 C and 35 C)
B2Physiologymaster$rho_humid = (B2Physiologymaster$rho_dry*M_da + B2Physiologymaster$P_wv)/(R_ugc*B2Physiologymaster$Temp_kelvin)


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


# apply unit converions

B2Physiologymaster$isoprene_nmol_per_m2_s_IMS <- B2Physiologymaster$mmol.isoprene...umol.air * a * b * c * d * e * f * g * h * i * j


B2Physiologymaster$isoprene_nmol_per_m2_s_DryAir <- B2Physiologymaster$mmol.isoprene...umol.air * a * b * c * B2Physiologymaster$rho_dry * e * f * g * h * i * j
B2Physiologymaster$isoprene_nmol_per_m2_s_HumAir <- B2Physiologymaster$mmol.isoprene...umol.air * a * b * c * B2Physiologymaster$rho_humid * e * f * g * h * i * j

plot (B2Physiologymaster$isoprene_nmol_per_m2_s_HumAir,B2Physiologymaster$mmol.isoprene.m2.sec)
plot (B2Physiologymaster$isoprene_nmol_per_m2_s_IMS,B2Physiologymaster$mmol.isoprene.m2.sec)
plot (B2Physiologymaster$isoprene_nmol_per_m2_s_DryAir,B2Physiologymaster$mmol.isoprene.m2.sec)

