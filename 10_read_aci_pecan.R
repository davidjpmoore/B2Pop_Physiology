##Author: Ian Shiach
##Date: 09/16/2015
##Purpose: test PEcAn.photosynthesis and read in LICOR files

setwd("./data/")


library(PEcAn.photosynthesis)
library(ggplot2)



## Read LI-COR 6400 files (ASCII not xls) (file from 09)


load("aci_2014.Rda")

## Load files to a list

aci_2014_list <- split(aci_2014, factor(sort(rank(row.names(aci_2014))%%75)))


# Plot facet wrap

aci_plot <- ggplot(data=aci_2014, aes(x=Ci, y=Photo))
aci_plot + facet_wrap(~ fname) + 
  geom_point(colour="black", size = 2.5) +
  theme_classic() +
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=22,face="bold")) + 
  theme(panel.border = element_blank(), axis.line = element_line(colour="black", size=2, lineend="square"))+
  theme(axis.ticks = element_line(colour="black", size=2, lineend="square"))+
  ylab("Assimilation (umol/m2/sec)")+
  xlab("Ci")








# # The code below performs a set of interactive QA/QC checks on the LI-COR data that's been loaded. 
# Because it's interactive it isn't run when this vignette is knit.

# # If you want to get a feel for how the code works you'll 
# want to run it first on just one file, rather than looping over all the files

# this runs licor QC on a file - you click on outliers to remove them

# aci_2014_list[[1]] <- Licor.QC(aci_2014_list[[1]])




# same process for all files
# note: it doesn't appear possible to stop this process partway through. Beware running it with this large list of dataframes unless you're prepared to do it in one sitting.

# trying to add curve = ACi to only run through ACi rather than ACi and AQ

for(i in 1:length(aci_2014_list)){
  aci_2014_list[[i]] = Licor.QC(aci_2014_list[[i]], curve = "ACi")
}

#after the QC process combine the files into one data frame

aci_2014_qc <- do.call("rbind", aci_2014_list)


## if QC was done, remove both unchecked points and those that fail QC
if("QC" %in% colnames(aci_2014_qc)){
  aci_2014_qc = aci_2014_qc[-which(aci_2014_qc$QC < 1),]  
} else{
  QC = rep(1,nrow(aci_2014_qc))
  aci_2014_qc = cbind(aci_2014_qc,QC)
}


# fit aci curve

#test2 <- fitA(aci_2014_list[[1]])
#plot.photo(aci_2014_list[[1]],test2,curve="ACi")

if(file.exists("fit.RData")){
  load("fit.RData")
} else{
  fit <- fitA(aci_2014)
  save(fit,file="fit.RData")
}

plot.photo(aci_2014,fit,curve="aci")

