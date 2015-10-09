## ------------------------------------------------------------------------
library(caret)
library(mlbench)
library(Lab7)
data("BostonHousing")

## ------------------------------------------------------------------------
head(BostonHousing)

## ------------------------------------------------------------------------
set.seed(1337)
inTraining <- caret::createDataPartition(BostonHousing$crim, p = .7, list = FALSE)
training <- BostonHousing[ inTraining,]
testing  <- BostonHousing[-inTraining,]
fitControl <- caret::trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)


## ------------------------------------------------------------------------
lmFit <- caret::train(crim ~ ., data = training,
                 method = "lm",
                 trControl = fitControl

                 )
lmFit



## ------------------------------------------------------------------------
lmGrid <-  expand.grid(nvmax=1:(ncol(training)-1))
fsFit <- caret::train(crim ~ ., data = training,
                 method = "leapForward",
                 trControl = fitControl,
                  tuneGrid=lmGrid
                 )

fsFit

