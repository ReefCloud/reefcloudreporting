# =============================================================
# File: plot_temporal_cover.R
# Description: Generates and saves a temporal benthic cover trend plot
# Author: Manuel Gonzalez-Rivero and Samuel Chan
# Date: 2026-01-07
# =============================================================

#' Generate and Save Temporal Cover Plot
#'
#' Creates a temporal plot of benthic cover trends for a specified region
#' and cover type using modelled ReefCloud outputs.
#'
#' @param tier_id Character. Unique identifier for the region/tier.
#' @param cover_type Character. Benthic group to plot. One of
#'   \code{"hard coral"}, \code{"soft coral"}, \code{"macroalgae"},
#'   \code{"turf algae"}, \code{"crustose coralline algae"}, or
#'   \code{"other"}.
#'
#' @return A list containing:
#' \describe{
#'   \item{plot}{A ggplot object.}
#'   \item{df.sum}{Filtered cover data used in the plot.}
#' }
#'
#' @examples
#' \dontrun{
#' plot_temporal_cover(
#'   tier_id = "exampleTierID",
#'   cover_type = "hard coral"
#' )
#' }
#'
#' @export
plot_temporal_cover <- function(
    tier_id,
    cover_type = "hard coral"
    ) {

  # Retrieve data
  xdf <- get_benthic_cover(tier_id)

  # Colour palette
  pal <- group.pal

  if (!cover_type %in% names(pal)) {
    stop(
      "'cover_type' must be one of: ",
      paste(names(pal), collapse = ", ")
    )
  }

  plot_df <- xdf |>
    dplyr::filter(.data$type == cover_type) |>
    dplyr::mutate(
      year = lubridate::year(.data$date)
    )

  p <- ggplot2::ggplot(
    plot_df,
    ggplot2::aes(
      x = .data$year,
      y = .data$median
    )
  ) +
    ggplot2::geom_pointrange(
      ggplot2::aes(
        ymin = .data$low,
        ymax = .data$high
      ),
      colour = group.pal[[cover_type]],
      linewidth = 0.8
    ) +
    ggplot2::geom_line(
      colour = group.pal[[cover_type]],
      linewidth = 1.4
    ) +
    ggplot2::labs(
      title = paste0(
        tools::toTitleCase(cover_type),
        " Cover Trend"
      ),
      subtitle = "Median cover with 95% credible intervals",
      x = "Year",
      y = "Cover (%)"
    ) +
    ggplot2::scale_x_continuous(
      breaks = scales::breaks_pretty()
    ) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank()
    )

  return(
    list(
      plot = p,
      df.sum = plot_df
    )
  )
}
