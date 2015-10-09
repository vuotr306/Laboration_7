


a <- rrFit1$finalModel
a$tuneValue


plot(RMSE~lambda, data=rrFit1$results, type="o")

which_best <- tolerance(rrFit1$results, metric="RMSE",
          tol=0.0000001, maximize = F)

rrFit1$results[which_best, ]


