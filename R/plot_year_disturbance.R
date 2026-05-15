# =============================================================
# File: plot_year_disturbance.R
# Description: Donut plot of disturbance severity for one year
# Author: Samuel Chan
# Date: 2026-05-12
# =============================================================

#' Plot Disturbance Severity for one Year
#'
#' @description
#' Creates a donut chart showing the distribution of reef disturbance
#' severity for a selected year. If no year is provided, the most recent
#' available year in the dataset is used.
#'
#' @param df Data frame returned by \code{get_disturbance()}.
#' @param year Numeric or NULL. Year to plot. If NULL (default), uses
#'   the most recent year available in the data.
#'
#' @return A ggplot object.
#'
#' @examples
#' \dontrun{
#' df <- get_disturbance(1705, "storm_exposure_year")
#'
#' # Defaults to latest year
#' plot_year_disturbance(df)
#'
#' # Specific year
#' plot_year_disturbance(df, year = 2011)
#' }
#'
#' @import ggplot2 dplyr
#' @export
plot_year_disturbance <- function(df, year = NULL) {
  
  if (!all(c("env_type", "tier_id", "year", "severity", "percentage_total_reef") %in% names(df))) {
    stop("Input must contain env_type, tier_id, year, severity, and percentage_total_reef. 
         Please use the dataframe from get_disturbance.")
  }
  
  # Load dependent functions
  source("R/get_regional_summary.R")
  
  # Determine default year
  if (is.null(year)) {
    year <- max(df$year, na.rm = TRUE)
  }
  
  # Get info
  info <- get_regional_summary(unique(df$tier_id))
  
  # Filter data
  xdf <- df |>
    dplyr::filter(.data$year == !!year) |>
    dplyr::mutate(
      severity = as.factor(severity),
      percentage_total_reef = as.numeric(percentage_total_reef),
      label = scales::percent(percentage_total_reef, accuracy = 1, suffix = "")   
      )
  
  if (nrow(df) == 0) {
    stop("No data for selected year.")
  }
  
  # Fix labels
  dist_label <- if (unique(df$env_type) == "thermal_stress") {
    "Thermal stress"
  } else {
    "Storm exposure"
  }
  
  # Build donut plot
  p <- ggplot2::ggplot(
    xdf,
    ggplot2::aes(
      x = 2,
      y = percentage_total_reef,
      fill = severity
    )
  ) +
    ggplot2::geom_col(color = "white") +
    ggplot2::geom_text(
      ggplot2::aes(label = label),
      position = ggplot2::position_stack(vjust = 0.5),
      size = 4,
      colour = "black"
    ) +
    ggplot2::scale_fill_manual(
      values = c("1" = "#ffffbf", "2" = "#fdae61", "3" = "#d7191c")    
      ) +
    ggplot2::coord_polar(theta = "y") +
    ggplot2::xlim(0.5, 2.5) +
    ggplot2::scale_y_continuous(
      labels = scales::label_number(scale = 1)
    ) +
    ggplot2::labs(
      title = paste("Coral Reef ", dist_label, " Disturbance Severity for ", info$region_name),
      subtitle = sprintf("Disturbance data for reefs in Year: %s", stringr::str_to_title(year)),
      y = "Reef Percentage Area Affected"
    ) +
    ggplot2::theme_void()
  
  return(p)
}