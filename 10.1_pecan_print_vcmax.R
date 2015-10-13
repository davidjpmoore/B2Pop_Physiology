##Author: Ian Shiach
##Date: 09/16/2015
##Purpose: test PEcAn.photosynthesis and read in LICOR files

setwd("./data/")


library(PEcAn.photosynthesis)
library(ggplot2)



## Read LI-COR 6400 files (ASCII not xls) (file from 09)


# load("aci_2014.Rda")
# 
# ## Load files to a list
# 
# aci_2014_list <- split(aci_2014, factor(sort(rank(row.names(aci_2014))%%75)))
# 
# 
# # same process for all files
# # note: it doesn't appear possible to stop this process partway through. Beware running it with this large list of dataframes unless you're prepared to do it in one sitting.
# 
# for(i in 1:length(aci_2014_list)){
#   aci_2014_list[[i]] = Licor.QC(aci_2014_list[[i]], curve = "ACi")
# }
# 
# # save qc list to .rda
# aci_2014_list_qc <- aci_2014_list
# 
# save(aci_2014_list_qc, file="aci_2014_list_qc.Rda")

load("aci_2014_list_qc.Rda")

# remove QC points from list

for(i in 1:length(aci_2014_list_qc)){
  
  if("QC" %in% colnames(aci_2014_list_qc[[i]])){
    aci_2014_list_qc[[i]] = aci_2014_list_qc[[i]][-which(aci_2014_list_qc[[i]]$QC < 1),]  
  } else{
    QC = rep(1,nrow(aci_2014_list_qc[[i]]))
    aci_2014_list_qc[[i]] = cbind(aci_2014_list_qc[[i]],QC)
  }
}


#fit aci curve to list


# This returns an error--it expects "fit" or in this case "fit[[1]]" to already exist. If you create it beforehand (say in 10_read_aci_pecan.R), it runs, but looks like it only runs one curve 

for(i in 1:length(aci_2014_list_qc)){
  if(file.exists("fit_list.RData")){
    load("fit_list.RData")
  } else{
  fit[[i]] <- fitA(aci_2014_list_qc[[i]])
  save(fit,file="fit_list.RData")
}
}

# fit aci without checking for existing file
# still needs "fit" to exist already
# Throws this error: Error in jags.model(file = textConnection(my.model), data = mydat, inits = init,  : 
#RUNTIME ERROR:
#  Index out of range for node an

for(i in 1:length(aci_2014_list_qc)){
  
  fit[[i]] <- fitA(aci_2014_list_qc[[i]])
  
}


#The 'params' mcmc.list contains the parameter estimate MCMC chains, which we can do standard MCMC diagnositics on.

par(mfrow=c(2,1))
plot(fit$params,auto.layout = FALSE)    ## MCMC diagnostic plots


### YOu can extract the parameter estimates for a given fit using the function summary(fit$params)
### It looks like the Vignette explains how to do this and how to run ANOVA's or estimate treatment effects
### You could also just carry out fits independently on different genotypes or times etc
### Take a read through the vignette to see if there's a more economical way to do this

#https://github.com/PecanProject/pecan/blob/master/modules/photosynthesis/vignettes/ResponseCurves.Rmd  
ParamEstimates= summary(fit$params) ## parameter estimates  

paramstat <- ParamEstimates$statistics




# gelman.plot(fit$params,auto.layout = FALSE)
# gelman.diag(fit$params)
# 

#The 'predict' object can be used to perform standard predictive diagnostics and to construct CI around curves
par(mfrow=c(1,1))
mstats = summary(fit$predict)
pmean = mstats$statistics[grep("pmean",rownames(mstats$statistics)),1]
plot(pmean,dat$Photo,pch="+",xlab="Predicted A",ylab = "Observed A")
abline(0,1,col=2,lwd=2)
