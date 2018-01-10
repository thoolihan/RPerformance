library(parallel)

ncores <- detectCores()
ncores

cl <- makeCluster(ncores - 1)

store_by_bits <- parLapply(cl, 1:16, function(x) 2 ^ x)
store_by_bits

library(nnet)

clusterEvalQ(cl, {library(nnet)})

models <- parLapply(cl, 1:7, function(neurons) 
  nnet(Species ~ ., data = iris, size = neurons))

models
stopCluster(cl)
