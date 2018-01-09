gcinfo(TRUE) # see any gc() that happens

library(pryr)

n = 1000000

create_large_df <- function() {
  data.frame(name = 
                    sample(c("Marsha", "Jan", "Cindy"), size = n, replace = TRUE),
                    score = sample.int(100, size = n, replace = TRUE))
}

df <- create_large_df()

object_size(df)


rm(df) # try to trigger a gc
gc() #explicitly garbage collect

gcinfo(FALSE)
print("done")

mem_change(df <- create_large_df())

mem_change(rm(df))
