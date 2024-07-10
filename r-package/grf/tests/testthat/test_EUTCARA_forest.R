library(grf)

set.seed(1234)

extract_samples <- function(tree) {

  # Keep only leaf nodes
  leaf_nodes <- Filter(f = function(x) x$is_leaf, tree$nodes)

  # Leaf nodes' 'samples' are estimation samples
  estimation_sample <- unlist(Map(f = function(x) x$samples, leaf_nodes))

  # Split = Drawn - Samples
  split_sample <- base::setdiff(tree$drawn_samples, estimation_sample)

  return(list(
    estimation_sample = estimation_sample,
    split_sample = split_sample
  ))
}

test_that("changing honest.fraction behaves as expected", {
  sample_fraction_1 <- 0.5
  honesty_fraction_1 <- 0.25

  sample_fraction_2 <- 0.25
  honesty_fraction_2 <- 0.1

  sample_fraction_3 <- 0.25
  honesty_fraction_3 <- 0.9

  n <- 16
  k <- 10
  X <- matrix(runif(n * k), nrow = n, ncol = k)
  Y <- runif(n)
  forest_1 <- grf::regression_forest(X, Y,
    sample.fraction = sample_fraction_1,
    honesty = TRUE, honesty.fraction = honesty_fraction_1
  )
  samples <- extract_samples(get_tree(forest_1, 1))

  expect_equal(length(samples$split_sample), n * sample_fraction_1 * honesty_fraction_1)
  expect_equal(length(samples$estimation_sample), n * sample_fraction_1 * (1 - honesty_fraction_1))
  # Checking for the runtime_error:
  # "The honesty fraction is too close to 1 or 0, as no observations will be sampled."
  expect_error(
    grf::regression_forest(X, Y,
      sample.fraction = sample_fraction_2,
      honesty = TRUE, honesty.fraction = honesty_fraction_2
    ),
    class = "std::runtime_error"
  )
  expect_error(
    grf::regression_forest(X, Y,
      sample.fraction = sample_fraction_3,
      honesty = TRUE, honesty.fraction = honesty_fraction_3
    ),
    class = "std::runtime_error"
  )
})

test_that("regression variance estimates are positive", {
  p <- 6
  n <- 1000

  ticks <- 101
  X.test <- matrix(0, ticks, p)
  xvals <- seq(-1, 1, length.out = ticks)
  X.test[, 1] <- xvals
  truth <- xvals > 0

  X <- matrix(2 * runif(n * p) - 1, n, p)
  Y <- (X[, 1] > 0) + 2 * rnorm(n)

  forest <- regression_forest(X, Y, num.trees = 1000, ci.group.size = 4)
  preds.oob <- predict(forest, estimate.variance = TRUE)
  preds <- predict(forest, X.test, estimate.variance = TRUE)

  expect_true(all(preds$variance.estimate > 0))
  expect_true(all(preds.oob$variance.estimate > 0))

  error <- preds$predictions - truth
  expect_lt(mean(error^2), 0.2)

  truth.oob <- (X[, 1] > 0)
  error.oob <- preds.oob$predictions - truth.oob
  expect_lt(mean(error.oob^2), 0.2)

  Z.oob <- error.oob / sqrt(preds.oob$variance.estimate)
  expect_lt(mean(abs(Z.oob) > 1), 0.5)
})


test_that("EUTCARA gradient descent works properly", {
  n <- 10
  X <- matrix(0, n, 5)
  # X[, 2] <- rnorm(100, 0, 4)
  X[1:5, 1] <- 10
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  
  Y <- c(pred_param1[1:(n/2)], pred_param2[(n/2+1):n])
  
  eutcara.forest <- EUTCARA_forest(X, Y, p_H, p_L, 1)
  eutcara.forest
})


test_that("EUTCARA estimates are close when given EUTCARA DGP", {
  # create a test with two subjects, each with 50 choices, that have a distinct
  # covariate difference 
  set.seed(12)
  n <- 22
  X <- matrix(0, n, 5)
  # X[, 2] <- rnorm(n, 0, 4)
  X[1:(n/2), 1] <- 10
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  
  Y <- c(pred_param1[1:(n/2)], pred_param2[(n/2+1):n])
  # Y <- pred_param1
  # Y <- pred_param2
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=p_H, p_L=p_L, num.trees = 1, 
                                   seed=12, honesty = FALSE, num.threads = 10)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
  
  expect_lt(mean(error$predictions), 0.001)
})


test_that("GRF-EUT can discriminate along two variables", {
  # create a test with three subjects, each with 11 choices, that have a distinct
  # covariate difference 
  set.seed(12)
  n <- 33
  X <- matrix(0, n, 5)
  X[1:(2*n/3), 1] <- 10 # first dimension separates 1+2 from 3
  X[1:(n/3), 2] <- -1 # second dimension separates 1 from 2+3
  X[(n/3+1):(2*n/3), 3] <- 3 # third dimension separates 2 from 1+3
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5, 0.25)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  pred_param3 <- (params[3]+p_L*log(p_L/p_H))/(2*params[3]+(p_L-p_H)*log(p_L/p_H))
  
  Y <- c(pred_param1[1:(n/3)], pred_param2[(n/3+1):(2*n/3)], pred_param3[(2*n/3+1):n])
  # Y <- pred_param1
  # Y <- pred_param2
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=p_H, p_L=p_L, 
                                   num.trees = 1000, seed=12, honesty = FALSE, num.threads = 10)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
})


score <- function(theta, theta_hat, p_H, p_L){
  return(min((theta_hat+p_L*log(p_L/p_H))/(2*theta_hat+(p_L-p_H)*log(p_L/p_H))-
           (theta+p_L*log(p_L/p_H))/(2*theta+(p_L-p_H)*log(p_L/p_H)), 1))
}


score_deriv <- function(theta_hat, p_H, p_L){
  return(-(p_L+p_H)*log(p_L/p_H)/((2*theta_hat+(p_L-p_H)*log(p_L/p_H))^2))
}



test_that("GRF-EUT can handle larger data sets.", {
  # create a test with 1000 subjects, each with 25 choices, with random covariates
  set.seed(12)
  n <- 1000*25
  X <- matrix(0, n, 5)
  X[1:(2*n/3), 1] <- 10 # first dimension separates 1+2 from 3
  X[1:(n/3), 2] <- -1 # second dimension separates 1 from 2+3
  X[(n/3+1):(2*n/3), 3] <- 3 # third dimension separates 2 from 1+3
  X[, 4] <- rnorm(n, 0, 4)
  
  p_H <- runif(25, 0.01, 0.05)
  p_L <- runif(25, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- (1:1000)/1000
  
  Y <- matrix(nrow=n, ncol=1)
  for (i in 1:1000){
    Y[(25*(i-1)+1):(25*i), ] <- min((params[i]+p_L*log(p_L/p_H))
                                    /(2*params[i]+(p_L-p_H)*log(p_L/p_H)), 1)
  }
  
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=rep(p_H, 1000), 
                                   p_L=rep(p_L, 1000), num.trees = 100, 
                                   seed=12, honesty = FALSE, num.threads = 10)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
})


test_that("GRF-EUT is sufficiently powerful.", {
  data_742 <- data[data$ID == 742, ]
  
  X_742 <- data_742[, c('age', 'nettohh', 'gender', 'educ_low', 'educ_med',
                        'educ_high', 'occup_market', 'occup_house', 
                        'occup_retired', 'occup_else', 'partner', 'nkids')]
  
  y_742 <- ifelse(data_742$`XM/YM` >= 1, data_742$prop_x, 1-data_742$prop_x)
  
  cheapM_742 <- pmax(data_742$XM, data_742$YM)
  expM_742 <- pmin(data_742$XM, data_742$YM)
  
  p_L_742 <- 1/expM_742
  p_H_742 <- 1/cheapM_742
  
  predict_742 <- predict(eut_grf, X_742, p_H_742, p_L_742, num.threads = 10)
  
  
  small_forest <- EUTCARA_forest(X_742, y_742, p_H_742, p_L_742, 10, seed=12, 
                                 honesty=TRUE, num.threads = 10)
  
  predict_small_742 <- predict(small_forest, X_742, p_H_742, p_L_742, num.threads = 10)
  
  
})


test_that("GRF-EUT can estimate risk-neutral.", {
  # create a test with three subjects, each with 11 choices, that have a distinct
  # covariate difference 
  set.seed(12)
  n <- 33
  X <- matrix(0, n, 5)
  X[1:(2*n/3), 1] <- 10 # first dimension separates 1+2 from 3
  X[1:(n/3), 2] <- -1 # second dimension separates 1 from 2+3
  X[(n/3+1):(2*n/3), 3] <- 3 # third dimension separates 2 from 1+3
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5, 0.0013)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  pred_param3 <- pmin((params[3]+p_L*log(p_L/p_H))/(2*params[3]+(p_L-p_H)*log(p_L/p_H)), 1)
  
  Y <- c(pred_param1[1:(n/3)], pred_param2[(n/3+1):(2*n/3)], pred_param3[(2*n/3+1):n])
  # Y <- pred_param1
  # Y <- pred_param2
  Y <- pred_param3
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=p_H, p_L=p_L, 
                                   num.trees = 1, seed=12, honesty = FALSE, num.threads = 10,
                                   ci.group.size = 1, sample.fraction = 1)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
})


test_that("GRF-EUT can estimate risk-neutral and risk averse.", {
  # create a test with three subjects, each with 11 choices, that have a distinct
  # covariate difference 
  set.seed(12)
  n <- 33
  X <- matrix(0, n, 5)
  X[1:(2*n/3), 1] <- 10 # first dimension separates 1+2 from 3
  X[1:(n/3), 2] <- -1 # second dimension separates 1 from 2+3
  X[(n/3+1):(2*n/3), 3] <- 3 # third dimension separates 2 from 1+3
  X[(2*n/3+1):n, 4] <- 2 # give 3 its own distinction from the other two
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5, 0.0013)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  pred_param3 <- pmin((params[3]+p_L*log(p_L/p_H))/(2*params[3]+(p_L-p_H)*log(p_L/p_H)), 1)
  
  Y <- c(pred_param1[1:(n/3)], pred_param2[(n/3+1):(2*n/3)], pred_param3[(2*n/3+1):n])
  # Y <- pred_param1
  # Y <- pred_param2
  # Y <- pred_param3
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=p_H, p_L=p_L, 
                                   num.trees = 10, seed=12, honesty = FALSE, 
                                   num.threads = 10, min.node.size = 0, alpha=0,
                                   sample.fraction=0.5, ci.group.size = 1)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
  
  
  
})



test_that(".", {
  # create a test with three subjects, each with 11 choices, that have a distinct
  # covariate difference 
  set.seed(12)
  n <- 33
  X <- matrix(0, n, 5)
  X[1:(2*n/3), 1] <- 10 # first dimension separates 1+2 from 3
  X[1:(n/3), 2] <- -1 # second dimension separates 1 from 2+3
  X[(n/3+1):(2*n/3), 3] <- 3 # third dimension separates 2 from 1+3
  X[(2*n/3+1):n, 4] <- 2 # give 3 its own distinction from the other two
  
  p_H <- runif(n, 0.01, 0.05)
  p_L <- runif(n, 0.05, 0.1)
  p_H[1] <- 0.01
  p_L[1] <- 0.1
  params <- c(0.06, 0.5, 0.0013)
  
  pred_param1 <- (params[1]+p_L*log(p_L/p_H))/(2*params[1]+(p_L-p_H)*log(p_L/p_H))
  pred_param2 <- (params[2]+p_L*log(p_L/p_H))/(2*params[2]+(p_L-p_H)*log(p_L/p_H))
  pred_param3 <- pmin((params[3]+p_L*log(p_L/p_H))/(2*params[3]+(p_L-p_H)*log(p_L/p_H)), 1)
  
  Y <- c(pred_param1[1:(n/3)], pred_param2[(n/3+1):(2*n/3)], pred_param3[(2*n/3+1):n])
  # Y <- pred_param1
  # Y <- pred_param2
  # Y <- pred_param3
  
  vec <- c(26,  2, 12,  1,  4, 31, 29,  7, 18, 27, 13, 10, 23, 25, 15, 17)+1
  vec <- sort(vec)
  
  X <- X[vec, ]
  Y <- Y[vec]
  p_L <- p_L[vec]
  p_H <- p_H[vec]
  
  
  eutcara.forest <- EUTCARA_forest(X=X, Y=Y, p_H=p_H, p_L=p_L, 
                                   num.trees = 1000, seed=12, honesty = FALSE, 
                                   num.threads = 10, min.node.size = 0, alpha=0,
                                   sample.fraction=1, ci.group.size = 1)
  eutcara.forest
  eutcara.forest$predictions
  eutcara.forest$`_leaf_samples`
  eutcara.forest$predictions-Y
  
  predictions <- predict(eutcara.forest, X, p_H, p_L, num.threads = 10)
  predictions
  predictions - Y
  error <- (predictions - Y)^2
  error$predictions
  mean(error$predictions)
  
  
  
})