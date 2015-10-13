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
BostonHousing$chas <- as.numeric(BostonHousing$chas) - 1
BostonHousing <- scale(BostonHousing)

## ------------------------------------------------------------------------
set.seed(1337)
lmFit <- caret::train(crim ~ ., data = training,
                      method = "lm",
                      trControl = fitControl
)
lmFit



## ------------------------------------------------------------------------
lmGrid <-  expand.grid(nvmax=1:(ncol(training)-1))
set.seed(1337)
fsFit <- caret::train(crim ~ ., data = training,
                      method = "leapForward",
                      trControl = fitControl,
                      tuneGrid=lmGrid
)

fsFit

## ------------------------------------------------------------------------

lmRig<-list(type=c("Regression","Classification"),
            library="Lab7",
            loop=NULL)

lmRig$parameters<-data.frame(parameter="lambda",
                             class="numeric",
                             label="Lambda")

# 
# Fit<-function(formula,data,lambda,param,lev,last,classProbs,...){
# 
#   
#   Lab7::ridgereg( formula=formula,data=data,lambda=param$lambda)
# }


Fit<-function(x,y,lambda,param,lev,last,classProbs,...){
  
  dat <- as.data.frame(x)
  dat$response <- y
  
  formula <- "response ~ "
  
  formula <- paste(formula, names(dat)[1], sep="")
  
  if(ncol(x) > 1){
    for(i in 2:ncol(x)){
      
      formula <- paste(formula, " + ", names(dat)[i], sep="")
      
    }
  }
  
  formula <- as.formula(formula)
  Lab7::ridgereg( formula = formula, data=dat,lambda=param$lambda)
}

lmRig$fit<-Fit

lmRig$predict<-function (modelFit, newdata,preProc=NULL, submodels = NULL) 
{
  predict(modelFit, newdata)
}

lmRig$prob<- list(NULL)

lmRig$sort<-function (x) x[order(-x$lambda), ]

lmRig$label<-"Ridgeregression"

lmRig$grid<-function(x,y,len=NULL, search="grid"){
  # data.frame(lambda=seq(from=0, to=500, by=10))
  # data.frame(lambda=seq(from=500, to=1000, by=25))
  # data.frame(lambda=seq(from=750, to=850, by=10))
  # data.frame(lambda=seq(from=820, to=840, by=1))
  # data.frame(lambda=seq(from=825, to=830, by=0.1))
  data.frame(lambda=c(0, 1, 2, 500, 828, 828.4, 830, 1000))
}

set.seed(1337)
rrFit1 <- caret::train(crim ~ ., data = training,
                       method = lmRig,
                       trControl = fitControl
)
rrFit1

## ------------------------------------------------------------------------
best_model <- ridgereg(crim ~ zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + b + lstat + medv, data = as.data.frame(BostonHousing), lambda = 828.4)
print(best_model)
qqnorm(best_model$res)
qqline(best_model$res)
plot(best_model$res, type="o", pch=20, cex=0.5)

