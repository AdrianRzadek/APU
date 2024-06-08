#install.packages("party")
#install.packages("mlr")
library(readr)
library(dplyr)
library(party)
library(rpart)
library(mlr)
library(MASS)

data("Melanoma")

melanoma_task <- makeClassifTask(data = Melanoma, target = "sex")

melanoma_tree <- rpart(status ~ ., data = Melanoma, method = "class")

par(mar = c(1, 1, 1, 1))
plot(melanoma_tree)
text(melanoma_tree, use.n = TRUE)