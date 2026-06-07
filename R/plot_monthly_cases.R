#' Create a line plot of measles cases for a country in a given year
#'
#' @param numerical year
#' @param string country
#'
#' @return ggplot
#' @importFrom dplyr filter
#' @importFrom ggplot2 ggplot aes geom_line geom_point labs theme_minimal
#' @importFrom stringr str_c
#' @examples
#' plot_monthly_cases(year = 2018, country = "Madagascar")
#'
#' @export

plot_monthly_cases <- function(year = 2012, country = "Madagascar") {
  if (!(year >= 2012 && year <= 2025)) {
    stop("Enter a valid year. Year must be between 2012 and 2025.")
  }
  plot_data <- filter_by_country(country, by = "cases_month")  # <-- use helper
  plot_data <- plot_data[plot_data$year == year, ]

  plot_data$month <- factor(plot_data$month, levels = 1:12,
                            labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

  ggplot(plot_data, aes(x = month, y = measles_total, group = 1)) +
    geom_line() + geom_point() +
    labs(title = str_c("Monthly Measles Cases -", country, year, sep = " "),
         x = "Month",
         y = "Number of Cases") +
    theme_minimal()
}
