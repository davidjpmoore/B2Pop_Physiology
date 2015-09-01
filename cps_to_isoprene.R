setwd("C:/Users/ianshiach/Desktop/Grad School/Thesis/Processing/B2Pop_Physiology/data/")

# read in calibration average data
cps_averages <- read.table (file="06262015_isoprene_calibration_averages.csv", sep=",", header=TRUE)

# read in measurement average data
cps_measurements <- read.table (file="06262015_isoprene_measurement_averages.csv", sep=",", header=TRUE)


# generating standard curve equations

x1 <- with(cps_averages, subset(cps, calibration_number == 1))
y1 <- with(cps_averages, subset(known_isoprene, calibration_number == 1))

b1 <- coef(lm(y1 ~ x1))[[1]]
m1 <- coef(lm(y1 ~ x1))[[2]]

x2 <- with(cps_averages, subset(cps, calibration_number == 2))
y2 <- with(cps_averages, subset(known_isoprene, calibration_number == 2))

b2 <- coef(lm(y2 ~ x2))[[1]]
m2 <- coef(lm(y2 ~ x2))[[2]]

x3 <- with(cps_averages, subset(cps, calibration_number == 3))
y3 <- with(cps_averages, subset(known_isoprene, calibration_number == 3))

b3 <- coef(lm(y3 ~ x3))[[1]]
m3 <- coef(lm(y3 ~ x3))[[2]]

x4 <- with(cps_averages, subset(cps, calibration_number == 4))
y4 <- with(cps_averages, subset(known_isoprene, calibration_number == 4))

b4 <- coef(lm(y4 ~ x4))[[1]]
m4 <- coef(lm(y4 ~ x4))[[2]]

# inputting average measurement CPS data into standard curve equations

# need to subset average CPS values by calibration number

cps_cal_1 <- data.frame(cps_measurements[which(cps_measurements[,2]==1), c("tree","cps", "genotype", "state")])

cps_cal_2 <- data.frame(cps_measurements[which(cps_measurements[,2]==2), c("tree","cps", "genotype", "state")])

cps_cal_3 <- data.frame(cps_measurements[which(cps_measurements[,2]==3), c("tree","cps", "genotype", "state")])

cps_cal_4 <- data.frame(cps_measurements[which(cps_measurements[,2]==4), c("tree","cps", "genotype", "state")])

# input measurements into equations

isoprene1 <- m1 * cps_cal_1$cps + b1

isoprene2 <- m2 * cps_cal_2$cps + b2

isoprene3 <- m3 * cps_cal_3$cps + b3

isoprene4 <- m4 * cps_cal_4$cps + b4

# add calculated values of isoprene (ppbv) to data frames

cps_cal_1$isoprene_ppbv <- isoprene1

cps_cal_2$isoprene_ppbv <- isoprene2

cps_cal_3$isoprene_ppbv <- isoprene3

cps_cal_4$isoprene_ppbv <- isoprene4

# combine data frames into one

isoprene_ppbv <- rbind(cps_cal_1,cps_cal_2,cps_cal_3,cps_cal_4)









