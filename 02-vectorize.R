library(rbenchmark)

large_vec = 1:1000

get_roots <- function(nums) {
  tmp <- c()
  for(n in nums) {
    tmp <- c(tmp, sqrt(n))
  }
  return(tmp)
}

benchmark("loop" = {get_roots(large_vec)},
          "vec" = {sqrt(large_vec)},
          columns = c('test', 'replications', 'relative', 'user.self', 'sys.self'),
          order = 'elapsed')

sqrt

sum_along <- function(nums) {
  current_sum <- 0
  tmp <- c()
  for(n in nums) {
    current_sum <- current_sum + n
    tmp <- c(tmp, current_sum)
  }
  return(tmp)
}

smaller_vec <- 1:10000
benchmark("loop" = {sum_along(smaller_vec)},
          "vec" = {cumsum(smaller_vec)},
          columns = c('test', 'replications', 'relative', 'user.self', 'sys.self'),
          order = 'elapsed')
