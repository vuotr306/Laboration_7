

data("iris")

inTraining <- caret::createDataPartition(iris$Petal.Length, p = .75, list = FALSE)
training <- iris[ inTraining,]
testing  <- iris[-inTraining,]
fitControl <- caret::trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)


gbmFit1 <- caret::train(Petal.Length ~ ., data = training,
                 method = "gbm",
                 trControl = fitControl,
                 ## This last option is actually one
                 ## for gbm() that passes through
                 verbose = FALSE)
gbmFit1

gbmGrid <-  expand.grid(interaction.depth = c(1,3),
                        n.trees = (1:2),
                        shrinkage = seq(0,3,0.1),
                        n.minobsinnode = 20)
nrow(gbmGrid)

set.seed(825)
gbmFit2 <- caret::train(Petal.Length ~ ., data = training,
                 method = "gbm",
                 trControl = fitControl,
                 verbose = FALSE,
                 ## Now specify the exact models 
                 ## to evaludate:
                 tuneGrid = gbmGrid)
gbmFit2$bestTune[3]
