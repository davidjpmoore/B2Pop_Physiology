#working with dates




# example as.Date('1/15/2001',format='%m/%d/%Y')

#DF means DATAFRAME
DF$rDate = as.Date(DF$LICORDATE, "%m/%d/%Y")
#note you could just overright
# NOTE order of M D Y must be correct

# http://www.stat.berkeley.edu/~s133/dates.html 

DF$MONTH = as.numeric(strftime(DF$rDate, format = "%m"))
DF$WEEK = as.numeric(strftime(DF$rDate, format = "%W"))