library(rbenchmark)

large_vec = 1:10000

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