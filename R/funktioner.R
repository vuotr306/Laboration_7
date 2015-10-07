
linreg<-function(formula, data){

  stopifnot(!is.null(data))
  stopifnot(is.data.frame(data))
  stopifnot(sum(1-c(all.vars(formula)) %in% colnames(data)) == 0)
  #    stopifnot(is.numeric(data$all.vars(formula)[1]))

  X<-model.matrix(formula, data=data)
  y<-as.matrix(data[all.vars(formula)[1]],ncol=1)

  QR <- qr((X))
  Q <- qr.Q(QR)
  R <- qr.R(QR)

  B_hat <- qr.solve(R) %*% t(Q) %*% as.matrix(y)
  dimnames(B_hat) <- dimnames(B_hat)[1]

  y_hat<-X%*%B_hat
  res<-as.matrix(y-y_hat,ncol=1)
  n<-nrow(X)
  p<-ncol(X)
  df<-n-p
  sigma_2<-(t(res)%*%res)/df

#   Var_B_hat_old_linear_alg<-diag(sigma_2[1,1]*(solve(t(X)%*%X)))
  Var_B_hat <- diag(sigma_2[1,1]*solve(t(R) %*% R))

  t_B<-B_hat/((Var_B_hat)^0.5)
  p_values<-2 * pt(q = -abs(t_B), df=df)
  H_ii <-diag(X %*% solve(t(X) %*% X) %*% t(X))
  linreg_list <- list(formula=formula, data=data, X=X, y=y, B_hat=B_hat, y_hat=y_hat, res=res, n=n, p=p, df=df,
                      sigma_2=sigma_2, Var_B_hat=Var_B_hat, t_B=t_B, p_values=p_values, H_ii=H_ii)

  linreg_object <- structure(linreg_list, class="linreg")

  return(linreg_object)

}




ridgereg <- function(formula, data, lambda){

  stopifnot(!is.null(data))
  stopifnot(is.data.frame(data))
  stopifnot(sum(1-c(all.vars(formula)) %in% colnames(data)) == 0)
# Kontrollera att lambda uppfyller ngt villkor.
  X<-model.matrix(formula, data=data)
  X <- cbind(1, scale(X[,-1]))
  y<-as.matrix(data[all.vars(formula)[1]],ncol=1)
  p <- ncol(X)

  B_ridge_hat <- solve(t(X) %*% X + lambda * diag(p) ) %*% t(X) %*% as.matrix(y)
  Y_hat <- X%*%B_ridge_hat

  ridgereg_list <- list(B_ridge_hat = B_ridge_hat, Y_hat = Y_hat)

  ridgereg_object <- structure(ridgereg_list, class="ridgereg")


  return(ridgereg_object)


}

ridgereg(Petal.Length~Petal.Width, iris, 10)


lm(Petal.Length~Petal.Width, iris, )
plot(Petal.Length~Petal.Width, iris)

abline(a=3.745, b=1.69)
abline(a=1.69, b=3.75)
