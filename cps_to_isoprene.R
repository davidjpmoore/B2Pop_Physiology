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



