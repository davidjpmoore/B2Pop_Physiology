0##Author: Ian Shiach
##Date: 09/16/2015
##Purpose: test PEcAn.photosynthesis and read in LICOR files

setwd("./data/")

#installing PEcAn.photosynthesis as a stand alone

#note you need rjags installed in R and also JAGS (stand alone application) installed on your computer
#note you will also need Rtools installed.

#note you will get an error 

library(PEcAn.photosynthesis)

## Read LI-COR 6400 files (ASCII not xls)



pita_06082014 <- read.Licor("2014_aci/06-08-14-ims-pita-25tree-aci")
princess_06082014 <- read.Licor("2014_aci/06-08-14-ims-princess-25tree-aci")
leila_07092014 <- read.Licor("2014_aci/07-09-2014-leila-aci-punch-ims")
pita_07092014 <- read.Licor("2014_aci/07-09-2014-pita-aci-punch-ims")
flux_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-flux")
leila_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-leila")
pita_09092014 <- read.Licor("2014_aci/09-09-2014-ims-aci-pita")




## Load files to a list
#master = lapply(filenames, read.Licor)


# # The code below performs a set of interactive QA/QC checks on the LI-COR data that's been loaded. 
# Because it's interactive it isn't run when this vignette is knit.

# # If you want to get a feel for how the code works you'll 
# want to run it first on just one file, rather than looping over all the files

#this runs licor QC on a file - you click on outliers to remove them
#master[[1]] <- Licor.QC(master[[1]])

pita_06082014 <- Licor.QC(pita_06082014)










#same process for all files
for(i in 1:length(master)){
  master[[i]] = Licor.QC(master[[i]])
}

#after the QC process combine the files into one data frame

dat<-do.call("rbind", master)


## if QC was done, remove both unchecked points and those that fail QC
if("QC" %in% colnames(dat)){
  dat = dat[-which(dat$QC < 1),]  
} else{
  QC = rep(1,nrow(dat))
  dat = cbind(dat,QC)
}
