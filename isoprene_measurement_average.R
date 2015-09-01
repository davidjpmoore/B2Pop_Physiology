setwd("C:/Users/ianshiach/Desktop/Grad School/Thesis/Processing/B2Pop_Physiology/data/")

# read in measurement data
iso_meas <- read.table(file="06262015_isoprene_measurements.csv", sep=",", header=TRUE)


# Calculate average CPS for each calibration and FDPS value/known isoprene value
avg_meas <- data.frame(with(iso_meas, tapply(cps, tree, mean)))

# Created new .csv in Excel with averages






















