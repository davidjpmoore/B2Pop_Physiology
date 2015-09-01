setwd("C:/Users/ianshiach/Desktop/Grad School/Thesis/Processing/B2Pop_Physiology/data/")

# read in calibration data
iso_cal <- read.table(file="06262015_isoprene_calibration.csv", sep=",", header=TRUE)


# Calculate average CPS for each calibration and FDPS value/known isoprene value
avg_cal <- data.frame(with(iso_cal, tapply(cps, list(calibration_number, known_isoprene), mean)))

# Created new .csv in Excel with averages