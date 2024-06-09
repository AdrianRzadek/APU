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

data("Melanoma")

#melanoma_task <- makeClassifTask(status ~ ., data = Melanoma, target = "sex")
melanoma_tree <- rpart(sex ~ ., data = Melanoma, method = "class")
summary(melanoma_tree)
tree_fit <- ctree(status ~ ., data = Melanoma)
plot(melanoma_tree)
text(melanoma_tree, use.n = TRUE)
plot(tree_fit)

learners <- mlr_learners
print(learners)

task = as_task_classif(sex ~ ., data = Melanoma)
task
learner = lrn("classif.rpart", cp = .01)

split = partition(task, ratio = 0.67)

learner$train(task, split$train)

prediction = learner$predict(task, split$test_set)

prediction$confusion


measure = msr("classif.acc")
prediction$score(measure)
 
resampling = rsmp("cv", folds = 3L)

rr = resample(task, learner, resampling)

rr$score(measure)[, .(task_id, learner_id, iteration, classif.acc)]

rr$aggregate(measure)