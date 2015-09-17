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

# Change "fname" to date-LICOR name-tree-line

pita_06082014$fname <- "06/08/2014-pita-tree-line"
princess_06082014$fname <- "06/08/2014-princess-tree-line"
leila_07092014$fname <- "06/08/2014-leila-tree-line"
pita_07092014$fname <- "06/08/2014-pita-tree-line"
flux_09092014$fname <- "06/08/2014-flux-tree-line"
leila_09092014$fname <- "06/08/2014-leila-tree-line"
pita_09092014$fname <- "06/08/2014-pita-tree-line"

# Create new data frame for each tree

# Change "fname" to reflect tree and line




