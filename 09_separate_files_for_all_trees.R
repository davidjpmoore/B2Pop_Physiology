##Author: Ian Shiach
##Date: 09/17/2015
##Purpose: Separate LICOR files so that each tree/aci curve has its own file to read into PEcAn.photosynthesis

setwd("./data/")

library(PEcAn.photosynthesis)

## Read LI-COR 6400 files (ASCII not xls)

pita_06082014 <- read.Licor("2014_aci/06-08-14-ims-pita-25tree-aci")
princess_06082014 <- read.Licor("2014_aci/06-08-14-ims-princess-25tree-aci")
leila_07092014 <- read.Licor("2014_aci/07-09-2014-leila-aci-punch-ims")
pita_07092014 <- read.Licor("2014_aci/07-09-2014-pita-aci-punch-ims")
flux_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-flux")
leila_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-leila")
pita_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-pita")

# Create new data frame for each tree/date
# June Pita

june_a10 <- pita_06082014[14:26, ]
june_a19 <- pita_06082014[27:39, ]
june_a13 <- pita_06082014[66:78, ]
june_b15 <- pita_06082014[79:91, ]
june_b13 <- pita_06082014[92:104, ]
june_e10 <- pita_06082014[105:117, ]
june_c17 <- pita_06082014[118:130, ]
june_f16 <- pita_06082014[131:143, ]
june_c02 <- pita_06082014[157:169, ]

# June Princess

june_b12 <- princess_06082014[1:13, ]
june_h08 <- princess_06082014[14:26, ]
june_a03 <- princess_06082014[27:39, ]
june_c03 <- princess_06082014[40:52, ]
june_d10 <- princess_06082014[53:65, ]
june_g10 <- princess_06082014[66:78, ]
june_e03 <- princess_06082014[79:91, ]
june_d14 <- princess_06082014[92:104, ]
june_e14 <- princess_06082014[105:117, ]
june_c19 <- princess_06082014[118:130, ]
june_e18 <- princess_06082014[131:143, ]
june_f19 <- princess_06082014[144:156, ]
june_d17 <- princess_06082014[157:169, ]
june_h09 <- princess_06082014[170:182, ]
june_g06 <- princess_06082014[183:195, ]
june_d06 <- princess_06082014[196:208, ]

# July Leila

july_a10 <- leila_07092014[1:13, ]
july_a03 <- leila_07092014[14:26, ]
july_c03 <- leila_07092014[27:39, ]
july_d10 <- leila_07092014[40:52, ]
july_g10 <- leila_07092014[53:65, ]
july_e10 <- leila_07092014[66:78, ]
july_b13 <- leila_07092014[79:91, ]
july_c19 <- leila_07092014[92:104, ]
july_e18 <- leila_07092014[105:117, ]
july_f16 <- leila_07092014[118:130, ]
july_f19 <- leila_07092014[131:143, ]
july_h09 <- leila_07092014[144:156, ]

# July Pita

july_b12 <- pita_07092014[14:26, ]
july_h08 <- pita_07092014[27:39, ]
july_a19 <- pita_07092014[40:52, ]
july_a13 <- pita_07092014[53:65, ]
july_e03 <- pita_07092014[66:78, ]
july_b15 <- pita_07092014[79:91, ]
july_d14 <- pita_07092014[92:104, ]
july_e14 <- pita_07092014[105:117, ]
july_c17 <- pita_07092014[119:131, ]
july_c02 <- pita_07092014[132:144, ]
july_d17 <- pita_07092014[146:158, ]
july_d06 <- pita_07092014[159:171, ]
july_g06 <- pita_07092014[172:184, ]


# September Flux

september_a03 <- flux_09092014[1:13, ]
september_c03 <- flux_09092014[14:26, ]
september_e03 <- flux_09092014[27:39, ]
september_b15 <- flux_09092014[40:52, ]
september_b13 <- flux_09092014[53:65, ]
september_e10 <- flux_09092014[66:78, ]
september_c02 <- flux_09092014[79:91, ]
september_d06 <- flux_09092014[92:104, ]
september_g06 <- flux_09092014[105:117, ]

# September Leila

september_a10 <- leila_09092014[c(1:7,17:22), ]
september_a19 <- leila_09092014[39:51, ]
september_d14 <- leila_09092014[52:64, ]
september_e14 <- leila_09092014[65:77, ]
september_e18 <- leila_09092014[78:90, ]
september_f19 <- leila_09092014[91:103, ]
september_h09 <- leila_09092014[105:117, ]

# September Pita

september_b12 <- pita_09092014[1:13, ]
september_h08 <- pita_09092014[14:26, ]
september_a13 <- pita_09092014[27:39, ]
september_d10 <- pita_09092014[40:52, ]
september_g10 <- pita_09092014[53:65, ]
september_c19 <- pita_09092014[66:78, ]
september_c17 <- pita_09092014[79:91, ]
september_f16 <- pita_09092014[92:104, ]
september_d17 <- pita_09092014[105:117, ]

# Change "fname" values to date-(LICOR name)-tree-line
# June Pita

june_a10$fname <- "06/08/2014-pita-a10-WA/OK"
june_a19$fname <- "06/08/2014-pita-a19-WA/OK"
june_a13$fname <- "06/08/2014-pita-a13-WA/IL"
june_b15$fname <- "06/08/2014-pita-b15-WA/OK"
june_b13$fname <- "06/08/2014-pita-b13-WA/IL"
june_e10$fname <- "06/08/2014-pita-e10-WA/MO"
june_c17$fname <- "06/08/2014-pita-c17-WA/OK"
june_f16$fname <- "06/08/2014-pita-f16-wA/MO"
june_c02$fname <- "06/08/2014-pita-c02-WA/TX"

# June Princess

june_b12$fname <- "06/08/2014-princess-b12-WA/MO"
june_h08$fname <- "06/08/2014-princess-h08-WA/MN"
june_a03$fname <- "06/08/2014-princess-a03-WA/IL"
june_c03$fname <- "06/08/2014-princess-c03-WA/TX"
june_d10$fname <- "06/08/2014-princess-d10-WA/TX"
june_g10$fname <- "06/08/2014-princess-g10-WA/MN"
june_e03$fname <- "06/08/2014-princess-e03-WA/MO"
june_d14$fname <- "06/08/2014-princess-d14-WA/TX"
june_e14$fname <- "06/08/2014-princess-e14-WA/MN"
june_c19$fname <- "06/08/2014-princess-c19-WA/IL"
june_e18$fname <- "06/08/2014-princess-e18-WA/MN"
june_f19$fname <- "06/08/2014-princess-f19-WA/MN"
june_d17$fname <- "06/08/2014-princess-d17-WA/IL"
june_h09$fname <- "06/08/2014-princess-h09-WA/MO"
june_g06$fname <- "06/08/2014-princess-g06-WA/TX"
june_d06$fname <- "06/08/2014-princess-d06-WA/OK"

# July Leila

july_a10$fname <- "07/09/2014-leila-a10-WA/OK"
july_a03$fname <- "07/09/2014-leila-a03-WA/IL"
july_c03$fname <- "07/09/2014-leila-c03-WA/TX"
july_d10$fname <- "07/09/2014-leila-d10-WA/TX"
july_g10$fname <- "07/09/2014-leila-g10-WA/MN"
july_e10$fname <- "07/09/2014-leila-e10-WA/MO"
july_b13$fname <- "07/09/2014-leila-b13-WA/IL"
july_c19$fname <- "07/09/2014-leila-c19-WA/IL"
july_e18$fname <- "07/09/2014-leila-e18-WA/MN"
july_f16$fname <- "07/09/2014-leila-f16-wA/MO"
july_f19$fname <- "07/09/2014-leila-f19-WA/MN"
july_h09$fname <- "07/09/2014-leila-h09-WA/MO"

# July Pita

july_b12$fname <- "07/09/2014-pita-b12-WA/MO"
july_h08$fname <- "07/09/2014-pita-h08-WA/MN"
july_a19$fname <- "07/09/2014-pita-a19-WA/OK"
july_a13$fname <- "07/09/2014-pita-a13-WA/IL"
july_e03$fname <- "07/09/2014-pita-e03-WA/MO"
july_b15$fname <- "07/09/2014-pita-b15-WA/OK"
july_d14$fname <- "07/09/2014-pita-d14-WA/TX"
july_e14$fname <- "07/09/2014-pita-e14-WA/MN"
july_c17$fname <- "07/09/2014-pita-c17-WA/OK"
july_c02$fname <- "07/09/2014-pita-c02-WA/TX"
july_d17$fname <- "07/09/2014-pita-d17-WA/IL"
july_d06$fname <- "07/09/2014-pita-d06-WA/OK"
july_g06$fname <- "07/09/2014-pita-g06-WA/TX"

# September Flux

september_a03$fname <- "09/09/2014-flux-a03-WA/IL"
september_c03$fname <- "09/09/2014-flux-c03-WA/TX"
september_e03$fname <- "09/09/2014-flux-e03-WA/MO"
september_b15$fname <- "09/09/2014-flux-b15-WA/OK"
september_b13$fname <- "09/09/2014-flux-b13-WA/IL"
september_e10$fname <- "09/09/2014-flux-e10-WA/MO"
september_c02$fname <- "09/09/2014-flux-c02-WA/TX"
september_d06$fname <- "09/09/2014-flux-d06-WA/OK"
september_g06$fname <- "09/09/2014-flux-g06-WA/TX"

# September Leila

september_a10$fname <- "09/09/2014-leila-a10-WA/OK"
september_a19$fname <- "09/09/2014-leila-a19-WA/OK"
september_d14$fname <- "09/09/2014-leila-d14-WA/TX"
september_e14$fname <- "09/09/2014-leila-e14-WA/MN"
september_e18$fname <- "09/09/2014-leila-e18-WA/MN"
september_f19$fname <- "09/09/2014-leila-f19-WA/MN"
september_h09$fname <- "09/09/2014-leila-h09-WA/MO"

# September Pita

september_b12$fname <- "09/09/2014-pita-b12-WA/MO"
september_h08$fname <- "09/09/2014-pita-h08-WA/MN"
september_a13$fname <- "09/09/2014-pita-a13-WA/IL"
september_d10$fname <- "09/09/2014-pita-d10-WA/TX"
september_g10$fname <- "09/09/2014-pita-g10-WA/MN"
september_c19$fname <- "09/09/2014-pita-c19-WA/IL"
september_c17$fname <- "09/09/2014-pita-c17-WA/OK"
september_f16$fname <- "09/09/2014-pita-f16-wA/MO"
september_d17$fname <- "09/09/2014-pita-d17-WA/IL"

# Reset "Obs" (might not be necessary because Licor.QC doesn't differentiate between curves this way--looks like it likes separate files)

june_a10$Obs <- c(1:13)
june_a19$Obs <- c(1:13)
june_a13$Obs <- c(1:13)
june_b15$Obs <- c(1:13)
june_b13$Obs <- c(1:13)
june_e10$Obs <- c(1:13)
june_c17$Obs <- c(1:13)
june_f16$Obs <- c(1:13)
june_c02$Obs <- c(1:13)
june_b12$Obs <- c(1:13)
june_h08$Obs <- c(1:13)
june_a03$Obs <- c(1:13)
june_c03$Obs <- c(1:13)
june_d10$Obs <- c(1:13)
june_g10$Obs <- c(1:13)
june_e03$Obs <- c(1:13)
june_d14$Obs <- c(1:13)
june_e14$Obs <- c(1:13)
june_c19$Obs <- c(1:13)
june_e18$Obs <- c(1:13)
june_f19$Obs <- c(1:13)
june_d17$Obs <- c(1:13)
june_h09$Obs <- c(1:13)
june_g06$Obs <- c(1:13)
june_d06$Obs <- c(1:13)
july_a10$Obs <- c(1:13)
july_a03$Obs <- c(1:13)
july_c03$Obs <- c(1:13)
july_d10$Obs <- c(1:13)
july_g10$Obs <- c(1:13)
july_e10$Obs <- c(1:13)
july_b13$Obs <- c(1:13)
july_c19$Obs <- c(1:13)
july_e18$Obs <- c(1:13)
july_f16$Obs <- c(1:13)
july_f19$Obs <- c(1:13)
july_h09$Obs <- c(1:13)
july_b12$Obs <- c(1:13)
july_h08$Obs <- c(1:13)
july_a19$Obs <- c(1:13)
july_a13$Obs <- c(1:13)
july_e03$Obs <- c(1:13)
july_b15$Obs <- c(1:13)
july_d14$Obs <- c(1:13)
july_e14$Obs <- c(1:13)
july_c17$Obs <- c(1:13)
july_c02$Obs <- c(1:13)
july_d17$Obs <- c(1:13)
july_d06$Obs <- c(1:13)
july_g06$Obs <- c(1:13)
september_a03$Obs <- c(1:13)
september_c03$Obs <- c(1:13)
september_e03$Obs <- c(1:13)
september_b15$Obs <- c(1:13)
september_b13$Obs <- c(1:13)
september_e10$Obs <- c(1:13)
september_c02$Obs <- c(1:13)
september_d06$Obs <- c(1:13)
september_g06$Obs <- c(1:13)
september_a10$Obs <- c(1:13)
september_a19$Obs <- c(1:13)
september_d14$Obs <- c(1:13)
september_e14$Obs <- c(1:13)
september_e18$Obs <- c(1:13)
september_f19$Obs <- c(1:13)
september_h09$Obs <- c(1:13)
september_b12$Obs <- c(1:13)
september_h08$Obs <- c(1:13)
september_a13$Obs <- c(1:13)
september_d10$Obs <- c(1:13)
september_g10$Obs <- c(1:13)
september_c19$Obs <- c(1:13)
september_c17$Obs <- c(1:13)
september_f16$Obs <- c(1:13)
september_d17$Obs <- c(1:13)

# reset row names 

row.names(june_a10) <- c(1:13)
row.names(june_a19) <- c(1:13)
row.names(june_a13) <- c(1:13)
row.names(june_b15) <- c(1:13)
row.names(june_b13) <- c(1:13)
row.names(june_e10) <- c(1:13)
row.names(june_c17) <- c(1:13)
row.names(june_f16) <- c(1:13)
row.names(june_c02) <- c(1:13)
row.names(june_b12) <- c(1:13)
row.names(june_h08) <- c(1:13)
row.names(june_a03) <- c(1:13)
row.names(june_c03) <- c(1:13)
row.names(june_d10) <- c(1:13)
row.names(june_g10) <- c(1:13)
row.names(june_e03) <- c(1:13)
row.names(june_d14) <- c(1:13)
row.names(june_e14) <- c(1:13)
row.names(june_c19) <- c(1:13)
row.names(june_e18) <- c(1:13)
row.names(june_f19) <- c(1:13)
row.names(june_d17) <- c(1:13)
row.names(june_h09) <- c(1:13)
row.names(june_g06) <- c(1:13)
row.names(june_d06) <- c(1:13)
row.names(july_a10) <- c(1:13)
row.names(july_a03) <- c(1:13)
row.names(july_c03) <- c(1:13)
row.names(july_d10) <- c(1:13)
row.names(july_g10) <- c(1:13)
row.names(july_e10) <- c(1:13)
row.names(july_b13) <- c(1:13)
row.names(july_c19) <- c(1:13)
row.names(july_e18) <- c(1:13)
row.names(july_f16) <- c(1:13)
row.names(july_f19) <- c(1:13)
row.names(july_h09) <- c(1:13)
row.names(july_b12) <- c(1:13)
row.names(july_h08) <- c(1:13)
row.names(july_a19) <- c(1:13)
row.names(july_a13) <- c(1:13)
row.names(july_e03) <- c(1:13)
row.names(july_b15) <- c(1:13)
row.names(july_d14) <- c(1:13)
row.names(july_e14) <- c(1:13)
row.names(july_c17) <- c(1:13)
row.names(july_c02) <- c(1:13)
row.names(july_d17) <- c(1:13)
row.names(july_d06) <- c(1:13)
row.names(july_g06) <- c(1:13)
row.names(september_a03) <- c(1:13)
row.names(september_c03) <- c(1:13)
row.names(september_e03) <- c(1:13)
row.names(september_b15) <- c(1:13)
row.names(september_b13) <- c(1:13)
row.names(september_e10) <- c(1:13)
row.names(september_c02) <- c(1:13)
row.names(september_d06) <- c(1:13)
row.names(september_g06) <- c(1:13)
row.names(september_a10) <- c(1:13)
row.names(september_a19) <- c(1:13)
row.names(september_d14) <- c(1:13)
row.names(september_e14) <- c(1:13)
row.names(september_e18) <- c(1:13)
row.names(september_f19) <- c(1:13)
row.names(september_h09) <- c(1:13)
row.names(september_b12) <- c(1:13)
row.names(september_h08) <- c(1:13)
row.names(september_a13) <- c(1:13)
row.names(september_d10) <- c(1:13)
row.names(september_g10) <- c(1:13)
row.names(september_c19) <- c(1:13)
row.names(september_c17) <- c(1:13)
row.names(september_f16) <- c(1:13)
row.names(september_d17) <- c(1:13)


# combine individual dfs into one df

aci_2014 <- rbind(
june_a10,
june_a19,
june_a13,
june_b15,
june_b13,
june_e10,
june_c17,
june_f16,
june_c02,
june_b12,
june_h08,
june_a03,
june_c03,
june_d10,
june_g10,
june_e03,
june_d14,
june_e14,
june_c19,
june_e18,
june_f19,
june_d17,
june_h09,
june_g06,
june_d06,
july_a10,
july_a03,
july_c03,
july_d10,
july_g10,
july_e10,
july_b13,
july_c19,
july_e18,
july_f16,
july_f19,
july_h09,
july_b12,
july_h08,
july_a19,
july_a13,
july_e03,
july_b15,
july_d14,
july_e14,
july_c17,
july_c02,
july_d17,
july_d06,
july_g06,
september_a03,
september_c03,
september_e03,
september_b15,
september_b13,
september_e10,
september_c02,
september_d06,
september_g06,
september_a10,
september_a19,
september_d14,
september_e14,
september_e18,
september_f19,
september_h09,
september_b12,
september_h08,
september_a13,
september_d10,
september_g10,
september_c19,
september_c17,
september_f16,
september_d17)

# save df to .rda

save(aci_2014, file="aci_2014.Rda")
