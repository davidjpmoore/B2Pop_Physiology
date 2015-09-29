#00_testingPlantEcoPhys
#Author: Dave Moore
#Date: 09/05/2015
#Purpose: Test the Plantecophys package - a stand alone package to model common leaf gas exchange measurements


# Using fitaci [library (plantecophys)] to estimate Vcmax and Jmax
#
# Note: you need to specify the dataframe and the variables that correspond to ALEAF, Tleaf, Ci and PPFD
# Note: I haven't worked out how to exclude outliers in any sensible way 
#    but PECAN:Photosynthesis has this function built in - perhaps I can use them together?

# download the source code for the package: https://cran.r-project.org/web/packages/plantecophys/index.html
#install.packages('PATH/plantecophys_0.6-3.zip', repos = NULL, type="source")
#Manual: https://cran.r-project.org/web/packages/plantecophys/plantecophys.pdf 

# updated R 09/14/2015
# updated Rstudio 09/14/2015
# updated dplyr 09/14/2015
# updated plantecophys to developer version 0.6.6
# library(devtools)
# install_bitbucket("remkoduursma/plantecophys")

library(devtools)
library (plantecophys)
library(dplyr)
library(ggplot2)
library(grid) #required for 'unit'
#Load data
setwd("./data/")

load ("aci_2014_qc.Rda")



CheckACI= fitacis(aci_2014_qc, "fname")

plot(CheckACI, how="manyplots")
