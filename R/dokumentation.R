#' Linear regression
#' 
#' This is our own created linear regression function
#' 
#'The QR-decomposition was used  to estimated the regression coefficient. Model for using linreg formula is respons(numeric)~predicted variables
#' 
#' @param formula A formula on the form response~first_predictor + second_predictor + ... . The response variable and all predictors must be in the data set provided.
#' @param data The data set from which to choose the predictors and the response variable in the formula.
#' @examples
#' linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' @return An object of S3-type class "linreg": A list of 15 elements, including fitted values and residuals.
#' @seealso
#' The methods that use the linreg class: \link{print.linreg}, \link{plot.linreg}, \link{summary.linreg}, \link{coef.linreg}, \link{residuals.linreg} and \link{predict.linreg}.
#' @export
"linreg"

#' Linear regression package
#' 
#' A package containing a linear regression function, a linear regression class and some methods for that class.
#' @docType package
#' @name Lab4
NULL


#' Plot a linreg object
#' 
#' A method that creates two plots for a linreg object.
#' 
#' Two plots are made where residuals are plotted against fitted values, using the ggplot() function of the \link{ggplot2} library.
#' The first plot contains a dotted line for the mean value of the residuals and a regression line for the residuals regressed on the fitted values.
#' The second plot has the square root of the absolute value of the residuals as y-axis variable. Here too, there is a regression line fitted for the y-axis variable regressed on the fitted values.
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' plot(a)
#' @return Two residual plots.
#' @export
#' @seealso \link{plot}. The generic function from which plot.linreg is created.
"plot.linreg"




#' Print a linreg object
#' 
#' A method that print out the regression model and it's estimated coefficients nicely.
#' 
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' print(a)
#' @return a list of 2 elements, Formula and estimated coefficients.
#' @export
#' @seealso \link{print}. The generic function from which print.linreg is created.
"print.linreg"




#' Print residuals of a linreg object
#' 
#' A method that print out the residulas for the regression model.
#' 
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' residuals(a)
#' resid(a)
#' @return a numeric vector of  residuals.
#' @export
#' @seealso \link{residuals}. The generic function from which residuals.linreg is created.
"residuals.linreg"




#' Summarize the regression model of a linreg object
#' 
#' A method that prints a summary of the regression model.
#' 
#' The method prints a table of the coefficients in the model; their estimate, standard error and the t and p values of the estimate.
#' The residual standard error and the residual degrees of freedom in the model are also presented.
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' summary(a)
#' @return a list of 3 elements.
#' @export
#' @seealso \link{summary}. The generic function from which summary.linreg is created.
"summary.linreg"



#' Print the fitted values of a linreg object
#' 
#' A method that prints out the fitted values of the regression model.
#' 
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' predict(a)
#' @return a numeric vector of  fitted values.
#' @export
#' @seealso \link{predict}. The generic function from which predict.linreg is created.
"predict.linreg"




#' Print the estimated coefficient values of a linreg object
#' 
#' A method that prints out the estimated coefficients values of the regression model.
#' 
#' @param x A linreg object.
#' @examples
#' a <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#' coef(a)
#' coefficients(a)
#' @return a numeric vector of  estimated coefficients values.
#' @export
#' @seealso \link{coef}. The generic function from which coef.linreg is created.
"coef.linreg"



