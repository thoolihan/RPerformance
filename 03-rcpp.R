library(Rcpp) 
library(ggplot2)

# Hello Rcpp World
cppFunction('int add(int x, int y) {
  return x + y;
}')

add

add(2, 3)

# Toy set of height in meters
height1 <- c(1.8, 1.7, 1.75, 2.0)
height2 <- c(1.78, 1.75, 1.76, 2.0)

# A Rcpp function with vectors
cppFunction('NumericVector distance(NumericVector x, NumericVector y) {
            int n = x.size();
            NumericVector dist(n);
            for(int i = 0; i<n; ++i) {
              dist[i] = sqrt(pow(x[i] - y[i], 2.0));
            }
            return dist;
}')

distance(height1, height2)
# It's a 'real function', meaning we can 
#  mix and match with R functions
mean(distance(height1, height2))

# Let's write R equivalents and benchmark
# First a bad version using a loop
distance_loop <- function(v1, v2) {
  # I'm even being kind and doing one large vector allocation
  rval <- vector("numeric", length(v1))
  for(i in seq_along(v1)) {
    rval[i] <- sqrt((v1[i] - v2[i]) ^ 2)
  }
  rval
}

distance_loop(height1, height2)

# Now a good version that operates on vectors
distance_vec <- function(v1, v2) {
  sqrt((v1 - v2) ^ 2)
}

distance_vec(height1, height2)

# Create a larger set for testing
h1 <- runif(10000, 1.4, 2.2)
h2 <- runif(10000, 1.4, 2.2)

# Let's quickly look at our large set
library(ggplot2)
qplot(x = seq_along(h1), y = h1, ylim = c(0, 3), geom="point")

qplot(x = seq_along(h1[0:100]), y = h1[0:100], ylim = c(0, 3), geom="point")

first_ten <- 1:10
ggplot(data.frame(first_ten), aes(x = first_ten)) + 
  geom_point(aes(y = h1[first_ten], color = 'red')) + 
  geom_point(aes(y = h2[first_ten], color = 'blue')) + 
  ylim(c(0, 3))

benchmark("rcpp" = {distance(h1, h2)},
          "rloop" = {distance_loop(h1, h2)},
          "rvec" = {distance_vec(h1, h2)},
          replications = 1000,
          columns = c('test', 'replications', 'relative', 'elapsed', 'user.self', 'sys.self'),
          order = 'elapsed')

# Based on results, you see that Rcpp is useful and fast, but 
#  good R code is usually close enough
