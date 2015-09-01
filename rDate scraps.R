#working with dates




# example as.Date('1/15/2001',format='%m/%d/%Y')


#Is you have date the format MM/DD/YYYY

#DF means DATAFRAME
DF$rDate = as.Date(DF$LICORDATE, "%m/%d/%Y")
#note you could just overright
# NOTE order of M D Y must be correct

# http://www.stat.berkeley.edu/~s133/dates.html 

DF$MONTH = as.numeric(strftime(DF$rDate, format = "%m"))
DF$WEEK = as.numeric(strftime(DF$rDate, format = "%W"))

#to create a date variable

DF$YEAR=2015
DF$MONTH=6
DF$DAY=15

DF$rDate  = as.Date(ISOdate(DF$YEAR,DF$MONTH,DF$DAY))

