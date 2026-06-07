#' Fit a linear regression of log-average measles cases on Air Quality Index and runs a statistical analysis on the model
#'
#' @return A \code{gt} table object with linear model analysis
#' @export
#'
#' @examples
#' aqi_regression_table()

linear_analysis <- function() {

  data <- load_data("airquality")

  model <- lm(log_avg_cases ~ total_aqi, data = data)

  wide_model <- broom::tidy(model, conf.int = TRUE) |>
    dplyr::mutate(
      term = dplyr::recode(term,
                           "(Intercept)" = "Intercept",
                           "total_aqi"   = "Air Quality Index"
      ),
      conf_int = stringr::str_c("(", round(conf.low, 3), ", ", round(conf.high, 3), ")")
    ) |>
    dplyr::select(term, estimate, std.error, statistic, p.value, conf_int) |>
    dplyr::rename(
      Term            = term,
      Estimate        = estimate,
      SE              = std.error,
      Statistic       = statistic,
      "P-value"       = p.value,
      "Conf. Interval" = conf_int
    )

  wide_model |>
    gt::gt() |>
    gt::fmt_number(columns = -"Conf. Interval", decimals = 3) |>
    gt::tab_style(
      style     = gt::cell_text(weight = "bold"),
      locations = gt::cells_column_labels()
    ) |>
    gt::tab_style(
      style     = gt::cell_text(weight = "bold"),
      locations = gt::cells_body(
        columns = Term,
        rows    = Term %in% c("Intercept", "Air Quality Index")
      )
    ) |>
    gt::tab_caption(caption = "Linear Regression coefficients for the
                    association between measles cases and AQI.")
}
