library(ff)
library(ffbase)
library(pryr)

fh <- file("data/activity/Phones_accelerometer.csv", open = "rt")

# run only the first time
#df <- read.csv.ffdf(file = "data/activity/Phones_accelerometer.csv")
#ffsave(df, file = "phones")

ffload(file = "phones", overwrite = TRUE)

class(df)
object_size(df)
names(df)
nrow(df)

unique(df$Model)
mean(df$x)
mean(df$y)
