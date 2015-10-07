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

# save qc list to .rda

save(aci_2014_list, file="aci_2014_list_qc.Rda")

load("aci_2014_list_qc.Rda")



#after the QC process combine the files into one data frame

aci_2014_qc <- do.call("rbind", aci_2014_list)


## if QC was done, remove both unchecked points and those that fail QC
if("QC" %in% colnames(aci_2014_qc)){
  aci_2014_qc = aci_2014_qc[-which(aci_2014_qc$QC < 1),]  
} else{
  QC = rep(1,nrow(aci_2014_qc))
  aci_2014_qc = cbind(aci_2014_qc,QC)
}

# save df to .rda

save(aci_2014_qc, file="aci_2014_qc.Rda")


# load file that was created above if QC was already done previously

load ("aci_2014_qc.Rda")


# fit aci curve
# 
# fit <- fitA(aci_2014_list[[1]])
# plot.photo(aci_2014_list[[1]],fit,curve="ACi")

if(file.exists("fit.RData")){
  load("fit.RData")
} else{
  fit <- fitA(aci_2014_qc)
  save(fit,file="fit.RData")
}





# analysis from https://github.com/PecanProject/pecan/blob/master/documentation/tutorials/MCMC/MCMC_Concepts.Rmd

# params <- as.matrix(fit$params)
# xrng = range(fit$params[,"alpha0"])
# yrng = range(fit$params[,"Jmax0"])
# 
# n = 1:nrow(params)
# plot(params[n,"alpha0"],params[n,"Jmax0"],type='p',pch="+",cex=0.5,xlim=xrng,ylim=yrng)
# pairs(params,pch=".")
# 
# plot(fit$params,auto.layout = FALSE)    ## MCMC diagnostic plots
# summary(fit$params) ## parameter estimates  
# 
# gelman.plot(fit$params,auto.layout = FALSE)
# gelman.diag(fit$params)
# 
# par(mfrow=c(1,1))
# mstats = summary(fit$predict)
# pmean = mstats$statistics[grep("pmean",rownames(mstats$statistics)),1]
# plot(pmean,aci_2014_qc$Photo,pch="+",xlab="Predicted A",ylab = "Observed A")
# abline(0,1,col=2,lwd=2)
# bias.fit = lm(aci_2014_qc$Photo~pmean)
# abline(bias.fit,col=3,lty=2,lwd=2)
# legend("topleft",legend=c("1:1","regression"),lwd=2,col=2:3,lty=1:2)
# summary(bias.fit)
# RMSE = sqrt(mean((pmean-aci_2014_qc$Photo)^2))
# RMSE
# R2 = 1-RMSE^2/var(aci_2014_qc$Photo)
# R2
# confint(bias.fit)

# view model

writeLines(fit$model)


# plot aci curves
# plot.photo(aci_2014_qc,fit,curve="aci")

#diagnostic plots from Vinette
#https://github.com/PecanProject/pecan/blob/master/modules/photosynthesis/vignettes/ResponseCurves.Rmd 

#The 'params' mcmc.list contains the parameter estimate MCMC chains, which we can do standard MCMC diagnositics on.

par(mfrow=c(2,1))
plot(fit$params,auto.layout = FALSE)    ## MCMC diagnostic plots


### YOu can extract the parameter estimates for a given fit using the function summary(fit$params)
### It looks like the Vignette explains how to do this and how to run ANOVA's or estimate treatment effects
### You could also just carry out fits independently on different genotypes or times etc
### Take a read through the vignette to see if there's a more economical way to do this

#https://github.com/PecanProject/pecan/blob/master/modules/photosynthesis/vignettes/ResponseCurves.Rmd  
ParamEstimates= summary(fit$params) ## parameter estimates  

gelman.plot(fit$params,auto.layout = FALSE)
gelman.diag(fit$params)


#The 'predict' object can be used to perform standard predictive diagnostics and to construct CI around curves
par(mfrow=c(1,1))
mstats = summary(fit$predict)
pmean = mstats$statistics[grep("pmean",rownames(mstats$statistics)),1]
plot(pmean,dat$Photo,pch="+",xlab="Predicted A",ylab = "Observed A")
abline(0,1,col=2,lwd=2)
