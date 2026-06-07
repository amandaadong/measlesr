test_that("filter by country works", {
  madagascar <- filter_by_country("Madagascar")

  expect_s3_class(madagascar, "tbl")
})
