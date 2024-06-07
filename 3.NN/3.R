#install.packages("neuralnet")
library("neuralnet")
set.seed(123)
f <- function(x){return (1/sqrt(x))}
x <- seq(1,10)
fx<-f(x)
traininginput <- as.data.frame(fx=fx ,x = x)


maxs <- max(traininginput)
mins <- min(traininginput)
scaled.traininginput <- as.data.frame(scale(traininginput), center = mins, scale=maxs - mins)

#trainingdata <-chind(scaled.traininginput)

net <-neuralnet(fx~ x, data = scaled.traininginput , hidden = c(3,2), threshold = 0.01)
plot(net)

test_data <- data.frame(x=seq(1,10))
scaled.traininginput.test <-as.data.frame(scale(test_data,  center = mins, scale=maxs - mins))
redictions <- compute(net, scaled.traininginput.test)