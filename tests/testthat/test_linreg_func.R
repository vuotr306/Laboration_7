context("linreg function")


test_that("function rejects errounous input.", {
  expect_error(linreg(Petal.Length~Sepdsal.Width+Sepal.Length, data=iris))
  expect_error(linreg(Petal.Length~Sepdsal.Width+Sepal.Length, data=irfsfdis))
})


testobject1 <- linreg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
controlobject1 <- lm(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
# testobject2 <- linreg(Petal.Length~Species, data=iris)
# controlobject2 <- lm(Petal.Length~Species, data=iris)

test_that("function returns correct results from specific data.", {
  expect_is(testobject1, class = "linreg")
  expect_true(is.list(testobject1))
  expect_equal(length(testobject1), 15)
  expect_equal(as.vector(unname(testobject1$B_hat)), as.vector(unname(controlobject1$coefficients)))
  expect_equal(as.vector(unname(testobject1$y_hat)), unname(controlobject1$fitted.values))
  expect_equal(as.vector(unname(testobject1$res)), unname(controlobject1$residuals))
  expect_equal(as.vector(unname(testobject1$df)), unname(controlobject1$df.residual))
  #   expect_equal(as.vector(unname(testobject1$p_values)), ?????) 
})



context("linreg methods")

test_that("function rejects errounous input.", {
 expect_error(Lab7::print.linreg("a"))
 expect_error(Lab7::plot.linreg("a"))
 expect_error(Lab7::summary.linreg("a"))
 expect_error(Lab7::predict.linreg("a"))
 expect_error(Lab7::residuals.linreg("a"))
 expect_error(Lab7::coefficients.linreg("a"))
})

test_that("function returns correct results from specific data.", {

  expect_equal(as.vector(unname(predict(testobject1))),unname(controlobject1$fitted.values))
  expect_equal(as.vector(unname(resid(testobject1))),unname(controlobject1$residuals))
  expect_equal(as.vector(unname(coef(testobject1))),unname(controlobject1$coef))
  
})







context("ridgereg function")

test_that("function rejects errounous input.", {
  expect_error(ridgereg(Petal.Length~Sepdsal.Width+Sepal.Length, data=iris))
  expect_error(ridgereg(Petal.Length~Sepal.Width+Sepal.Length, data=irfsfdis))
  expect_error(ridgereg(Petal.Length~Sepal.Width+Sepal.Length, data=iris, "10"))
})



testobject1 <- ridgereg(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
SL <- scale(iris$Sepal.Length)
SW <- scale(iris$Sepal.Width)
PL <- iris$Petal.Length
controlobject1 <- lm(PL~SW + SL)

test_that("function returns correct results from specific data.", {
  expect_is(testobject1, class = "ridgereg")
  expect_true(is.list(testobject1))
  # expect_equal(length(testobject1), 15)
  expect_equal(as.vector(unname(testobject1$B_ridge_hat)), as.vector(unname(controlobject1$coefficients)))
  expect_equal(as.vector(unname(testobject1$y_hat)), unname(controlobject1$fitted.values))
  expect_equal(as.vector(unname(testobject1$res)), unname(controlobject1$residuals))
})




context("ridgereg methods")

test_that("function rejects errounous input.", {
  expect_error(Lab7::print.ridgereg("a"))
  expect_error(Lab7::plot.ridgereg("a"))
  expect_error(Lab7::summary.ridgereg("a"))
  expect_error(Lab7::predict.ridgereg("a"))
  expect_error(Lab7::residuals.ridgereg("a"))
  expect_error(Lab7::coefficients.ridgereg("a"))
})


