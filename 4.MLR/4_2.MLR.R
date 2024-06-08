#install.packages("party")
#install.packages("mlr")
#install.packages("C50")
#install.packages("mlr3learners")
library(readr)
library(dplyr)
library(party)
library(rpart)
library(mlr3)
#library(mlr)
library(MASS)
library(C50)
library(mlr3learners)

smartfony <- read.csv("./smartfony.csv")


character_columns <- sapply(smartfony, is.character)
character_columns

# Przekonwertowanie kolumn "character" na "factor"
smartfony[character_columns] <- lapply(smartfony[character_columns], as.factor)

# Upewnienie się, że wszystkie kolumny są teraz prawidłowego typu
str(smartfony)

# Ponowne uruchomienie funkcji ctree
tree_fit <- ctree(cena ~ ., data = smartfony)


smartfony_tree_rpart <- rpart(nazwa ~ ., data = smartfony, control = rpart.control(minsplit = 10, cp = 0.01))
summary(smartfony_tree)
tree_fit <- ctree(cena~ ., data = smartfony)
plot(smartfony_tree)
text(smartfony_tree, use.n = TRUE)
plot(tree_fit)

learners <- mlr_learners
print(learners)


task = as_task_classif(cena ~ ., data = smartfony)
task
learner = lrn("classif.rpart", cp = .01)


split = partition(task, ratio = 0.67)

# train the model
learner$train(task, split$train)

# predict data
prediction = learner$predict(task, split$test_set)

# calculate performance
prediction$confusion


measure = msr("classif.acc")
prediction$score(measure)
 

 # 3-fold cross validation
resampling = rsmp("cv", folds = 3L)

# run experiments
rr = resample(task, learner, resampling)

# access results
rr$score(measure)[, .(task_id, learner_id, iteration, classif.acc)]

rr$aggregate(measure)