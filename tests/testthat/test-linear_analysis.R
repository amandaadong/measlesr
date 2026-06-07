test_that("linear analysis works", {
  result <- linear_analysis()
  expect_s3_class(result, "gt_tbl")

  data <- result$'_data'
  expect_equal(2, nrow(data))

  expect_equal(c(2.448016029, 0.000901163), data$Estimate)
})
