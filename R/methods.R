


# Our inherited functions, from coef, residuals and predict 

print.linreg <- function(x){
  
  temp <- rownames(x$B_hat)
  B_hat <- as.vector(x$B_hat)
  names(B_hat) <- temp
  
  lista <- list(Call=x$formula, Coefficients=B_hat)
  
  return(lista)
}

# print(a)



plot.linreg<-function(x){
  
  #    browser()
  sresid <- x$res/sqrt(x$sigma_2[1,1])
  scale_res <- sqrt(abs(sresid))
  
  df<-data.frame(x$res, x$y_hat, sresid, scale_res)
  colnames(df) <- c("Residuals", "Fittedvalues", "Standardized residuals", "scale_res")
  
  p1 <- ggplot2::ggplot(data=df) + ggplot2::theme_bw() + 
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(), axis.text.y = ggplot2::element_text(angle=90)) + 
    ggplot2::aes(x=Fittedvalues,y=Residuals) + 
    ggplot2::geom_point(shape=21,size=3)+
    ggplot2::ggtitle("Residuals vs Fitted") + 
    ggplot2::geom_hline(yintercept = 0, linetype=3, colour="lightgrey", size=1) +  
    ggplot2::geom_smooth(method = "lm", formula = y~x, se = FALSE, colour = "red")
  
  
  p2 <- ggplot2::ggplot(data=df) + ggplot2::theme_bw() + 
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(), axis.text.y = ggplot2::element_text(angle=90)) + 
    ggplot2::aes(x=Fittedvalues,y=scale_res) + 
    ggplot2::geom_point(shape=21,size=3)+
    ggplot2::ggtitle("Scale-Location") + 
    ggplot2::labs(x = "Fitted values", y = expression(sqrt("|Strandardized residuals|"))) + 
    ggplot2::geom_smooth(method = "lm", formula = y~x, se = FALSE, colour = "red")
  
  
  plot(p1)
  plot(p2)
  
}

# plot(a)



coef.linreg<-function(x){
  
  temp <- rownames(x$B_hat)
  B_hat <- as.vector(x$B_hat)
  names(B_hat) <- temp
  
  return(B_hat)
  
}

# coefficients(a)




residuals.linreg<-function(x){
  return(x$res)
}

# resid(a)



summary.linreg<-function(x){
  Out_data<-data.frame(Estimate=x$B_hat,"Std Error"=sqrt(x$Var_B_hat),"t value"=x$t_B,"P-Values"=x$p_values)
  sigma <- as.vector(sqrt(x$sigma_2))
  
  
  Output_lista<-list(Coefficients=Out_data, "Residual standard error"=sigma, "Degrees of freedom" = x$df)
  
  
  return(Output_lista)
}

# summary(a)



predict.linreg <- function(x){
  return(x$y_hat)
}

# predict(a)












