library(ff)
library(ffbase)
library(pryr)

# run only the first time
#df <- read.csv.ffdf(file = "data/activity/Phones_accelerometer.csv")
#ffsave(df, file = "phones")

ffload(file = "phones", overwrite = TRUE)

class(df)
object_size(df)
names(df)
dim(df)

unique(df$Model)
mean(df$x)
mean(df$y)

library(biglm)
model <- bigglm(z ~ x + y, data = df)
str(model)

