#install.packages("neuralnet")
library("neuralnet")
#1.
set.seed(123)
f <- function(x){return (1/sqrt(x))}
x <- seq(1,10)
fx<-f(x)
traininginput <- as.data.frame(fx=fx ,x = x)


maxs <- max(traininginput)
mins <- min(traininginput)

scaled.traininginput <- as.data.frame(scale(traininginput), center = mins, scale=maxs - mins)

net <-neuralnet(fx~ x, data = scaled.traininginput , hidden = c(3,2), threshold = 0.01)
plot(net)

test_data <- data.frame(x=seq(1,10))
scaled.traininginput.test <-as.data.frame(scale(test_data,  center = mins, scale=maxs - mins))
redictions <- compute(net, scaled.traininginput.test)

#2.
smartfony <- read.csv("./smartfony.csv")

traininginputSmartfony <- smartfony[, c('nazwa', 'cena')]

traininginputSmartfony$cena <- (traininginputSmartfony$cena - min(traininginputSmartfony$cena)) / (max(traininginputSmartfony$cena) - min(traininginputSmartfony$cena))

print(traininginputSmartfony)

traininginputSmartfony$nazwa <- as.numeric(factor(traininginputSmartfony$nazwa))

formula <- as.formula("cena ~ nazwa")

net <- neuralnet(formula, data = traininginputSmartfony, hidden = c(3,2), threshold = 0.01)

plot(net)



print(traininginputSmartfony)


test_data <- data.frame(nazwa = seq(1, 15))


print(str(traininginputSmartfony))

test_data$nazwa <- as.numeric(factor(test_data$nazwa, levels = levels(factor(traininginputSmartfony$nazwa))))

min_nazwa <- min(traininginputSmartfony$nazwa)
max_nazwa <- max(traininginputSmartfony$nazwa)
scaled_test_data <- data.frame(nazwa = (test_data$nazwa - min_nazwa) / (max_nazwa - min_nazwa))

colnames(scaled_test_data) <- "nazwa"

print(scaled_test_data)

predictions <- compute(net, scaled_test_data)

min_cena <- min(traininginputSmartfony$cena)
max_cena <- max(traininginputSmartfony$cena)
predicted_cena <- predictions$net.result * (max_cena - min_cena) + min_cena

result <- data.frame(test_data, Predicted_Cena = predicted_cena)
print(result)