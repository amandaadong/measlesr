#' Load data set of user's choice (helper function)
#'
#' @param string `cases_month`, `cases_year`, or `airquality` file to be loaded
#'
#' @return A tibble containing measles data
#' @importFrom stringr str_c
#' @export
load_data <- function(file = "cases_month") {
  if (!file %in% c("cases_month", "cases_year", "airquality")) {
    stop("Data file not found. Enter either 'cases_month', 'cases_year', or 'airquality'.")
  }

  path <- system.file("extdata", str_c(file, ".parquet"), package = "measlesr")

  if (path == "") {
    stop("Data file not found. Make sure the package is installed correctly")
  }

  arrow::read_parquet(path)
}

#' Load measles cases_year dataset
#'
#' @return A tibble containing measles data
#' @export
load_year <- function() {
  load_data("cases_year")
}

#' #' Load measles cases_month dataset
#'
#' @return A tibble containing measles data
#' @importFrom stringr str_c
#' @export
load_month <- function() {
  load_data("cases_year")
}


