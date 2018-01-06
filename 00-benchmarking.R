library(rbenchmark)

circle_area_difference <- function(radius, area = 1) {
  return(abs(area - pi * radius ^ 2))
}

# circle with radius 1 should have pi area, so let's find
# the difference between pi and our bad estimate
circle_area_difference(1, 3.14)

# let's find the radius that gets us closest to an area of 1
optimize(circle_area_difference, lower = 0, upper = 1)

# $minimum is the best value it found, 
# and $objective is the output of the function at the value

library(optimx)

benchmark("optimize" = {optimize(circle_area_difference, lower = 0, upper = 1)},
          "optimx" = {optimx(par = c(.5), fn = circle_area_difference, lower = 0, upper = 1)},
          replications = 200,
          columns = c('test', 'replications', 'relative', 'elapsed', 'user.self', 'sys.self'),
          order = 'elapsed')

# Note the "relative" column, which is a magnitude after normalizing the 
#   smallest test to 1