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
 expect_error(Lab4::print.linreg("a"))
 expect_error(Lab4::plot.linreg("a"))
 expect_error(Lab4::summary.linreg("a"))
 expect_error(Lab4::predict.linreg("a"))
 expect_error(Lab4::residuals.linreg("a"))
 expect_error(Lab4::coefficients.linreg("a"))
})

test_that("function returns correct results from specific data.", {

  expect_equal(as.vector(unname(predict(testobject1))),unname(controlobject1$fitted.values))
  expect_equal(as.vector(unname(resid(testobject1))),unname(controlobject1$residuals))
  expect_equal(as.vector(unname(coef(testobject1))),unname(controlobject1$coef))
  
  
})


