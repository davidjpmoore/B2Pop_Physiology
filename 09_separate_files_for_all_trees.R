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

# Change "fname" values to date-(LICOR name)-tree-line

pita_06082014$fname <- "06/08/2014-pita-tree-line"
princess_06082014$fname <- "06/08/2014-princess-tree-line"
leila_07092014$fname <- "06/08/2014-leila-tree-line"
pita_07092014$fname <- "06/08/2014-pita-tree-line"
flux_09092014$fname <- "06/08/2014-flux-tree-line"
leila_09092014$fname <- "06/08/2014-leila-tree-line"
pita_09092014$fname <- "06/08/2014-pita-tree-line"

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






# Reset "Obs" 


# Change "fname" to reflect tree and line




