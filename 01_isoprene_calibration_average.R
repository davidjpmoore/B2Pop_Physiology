setwd("./data/")
#install plyr
library(plyr)

#if we put all the R code in the folder "Rcode" then this line becomes:
# setwd("../data/")

# read in calibration data
iso_cal <- read.table(file="06262015_isoprene_calibration.csv", sep=",", header=TRUE)


# Calculate average CPS for each calibration and FDPS value/known isoprene value
ave.cal= ddply(iso_cal, .(calibration_number, known_isoprene), summarise, mean=mean(cps), sum=sum(cps))
avg_cal <- data.frame(with(iso_cal, tapply(cps, list(calibration_number, known_isoprene), mean)))

# Created new .csv in Excel with averages