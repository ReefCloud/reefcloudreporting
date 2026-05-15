# =============================================================
# File: plot_annual_disturbance.R
# Description: Stacked bar plot of disturbance severity by year
# Author: Samuel Chan
# Date: 2026-05-12
# =============================================================

#' Plot Disturbance Severity by Year
#'
#' @description
#' Creates a stacked bar plot showing the proportion of reef affected
#' by each disturbance severity level across years.
#'
#' @param df Data frame returned by \code{get_disturbance()}.
#'
#' @return A ggplot object.
#'
#' @examples
#' \dontrun{
#' df <- get_disturbance(1705, "thermal_stress")
#' plot_annual_disturbance(df)
#' }
#'
#' @import ggplot2 dplyr
#' @export
plot_annual_disturbance <- function(df) {
  
  # Load dependent functions
  source("R/get_regional_summary.R")
  
  if (!all(c("env_type", "tier_id", "year", "severity", "percentage_total_reef") %in% names(df))) {
    stop("Input must contain env_type, tier_id, year, severity, and percentage_total_reef. 
         Please use the dataframe from get_disturbance.")
  }
  
  # Get info
  info <- get_regional_summary(unique(df$tier_id))
  
  # Filter data
  xdf <- df |>
    dplyr::mutate(
      severity = as.factor(severity),
      percentage_total_reef = as.numeric(percentage_total_reef)
    )
  
  # Fix labels
  dist_label <- if (unique(df$env_type) == "thermal_stress") {
    "Thermal stress"
  } else {
    "Storm exposure"
  }
  
  # Build plot
  p <- ggplot2::ggplot(
    xdf,
    ggplot2::aes(
      x = year,
      y = percentage_total_reef,
      fill = severity
    )
  ) +
    ggplot2::geom_col(position = position_fill(reverse = TRUE), width = 0.8) +
    ggplot2::scale_y_continuous(
      labels = scales::label_percent(scale = 100)
    ) +
    ggplot2::scale_fill_manual(
      values = c("1" = "#ffffbf", "2" = "#fdae61", "3" = "#d7191c"),
      guide = 
    ) +
    ggplot2::labs(
      title = paste("Coral Reef ", dist_label, " Disturbance Severity for ", info$region_name),
      subtitle = "Annual disturbance data for reefs",
      x = "Year",
      y = "Reef Percentage Area Affected"
      ) +
    ggplot2::theme_minimal()
  
  return(p)
}