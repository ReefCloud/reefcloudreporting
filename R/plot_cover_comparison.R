# =============================================================
# File: plot_cover_comparison.R
# Description: Plot site-level and tier-level benthic cover change
#              using get_cover_comparison() output
# Author: Samuel Chan
# Date: 2026-05-12
# Dependencies: ggplot2, dplyr, stringr
# =============================================================

#' Plot Coral Reef Site Cover Comparison Between Two Years
#'
#' @description
#' Produces a bar plot showing site-level changes in benthic cover
#' between two comparison years. Bars represent site-level changes,
#' while the tier-level change is displayed as a dashed reference line.
#'
#' The function supports plotting either absolute change (percentage
#' points) or percentage change relative to the baseline year.
#'
#' @param x A tibble returned by \code{get_cover_comparison()}.
#' @param metric Character. One of:
#'   \itemize{
#'     \item \code{"abs"} — absolute change in cover (percentage points)
#'     \item \code{"pct"} — percent change relative to baseline
#'   }
#'   Default is \code{"abs"}.
#' @param sort Logical. If TRUE (default), sites are ordered by the
#'   selected metric.
#' @param show_tier Logical. If TRUE (default), draw the tier-level
#'   change as a dashed horizontal reference line.
#'
#' @return A \code{ggplot} object.
#'
#' @import ggplot2 dplyr stringr
#' @export
plot_cover_comparison <- function(
    x,
    metric = c("abs", "pct"),
    sort = TRUE,
    show_tier = TRUE
) {
  
  metric <- match.arg(metric)
  
  if (!is.data.frame(x)) {
    stop("`x` must be the output of get_cover_comparison().")
  }
  
  required_cols <- c(
    "row_type", "tier_name",
    "year_first", "year_last",
    "diff_from_first", "pct_change_from_first",
    "cover_type", "depth"
  )
  
  missing_cols <- setdiff(required_cols, names(x))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }
  
  # ---- Select metric ----------------------------------------------------
  value_col <- if (metric == "abs") {
    "diff_from_first"
  } else {
    "pct_change_from_first"
  }
  
  y_label <- if (metric == "abs") {
    "Absolute change in cover (percentage points)"
  } else {
    "Percentage change in cover (%)"
  }
  
  change_label <- if (metric == "abs") {
    "Absolute change"
  } else {
    "Percentage change"
  }
  
  # ---- Separate tier and site rows -------------------------------------
  tier_row  <- x |> dplyr::filter(.data$row_type == "tier")
  site_rows <- x |> dplyr::filter(.data$row_type == "site")
  
  if (nrow(site_rows) == 0) {
    stop("No site-level rows available to plot.")
  }
  
  # ---- Prepare site labels ---------------------------------------------
  site_rows <- site_rows |>
    dplyr::mutate(site = .data$tier_name)
  
  if (isTRUE(sort)) {
    site_rows <- site_rows |>
      dplyr::mutate(
        site = reorder(.data$site, .data[[value_col]])
      )
  }
  
  # ---- Labels ----------------------------------------------------------
  region_name <- tier_row$tier_name[1]
  depth_label <- stringr::str_to_title(unique(x$depth))
  year_label  <- paste0(
    unique(x$year_first), " vs ", unique(x$year_last)
  )
  
  # ---- Build plot ------------------------------------------------------
  p <- ggplot2::ggplot(
    site_rows,
    ggplot2::aes(
      x = site,
      y = .data[[value_col]],
      fill = .data[[value_col]] > 0
    )
  ) +
    ggplot2::geom_col(width = 0.75) +
    ggplot2::coord_flip() +
    ggplot2::geom_hline(yintercept = 0, colour = "grey50") +
    ggplot2::scale_fill_manual(
      values = c("TRUE" = "#2b83ba", "FALSE" = "#d7191c"),
      guide = "none"
    ) +
    ggplot2::labs(
      title = paste0(
        'Coral Reef Site Comparison for ', region_name
      ),
      subtitle = paste0(
        change_label, ' in ', stringr::str_to_title(unique(x$cover_type)),
        ' for reefs in Depth: ', depth_label,
        ", Year: ", year_label
      ),
      x = NULL,
      y = y_label
    ) +
    ggplot2::theme_minimal()
  
  # ---- Tier reference line ---------------------------------------------
  if (isTRUE(show_tier) && nrow(tier_row) == 1) {
    p <- p +
      ggplot2::geom_hline(
        yintercept = tier_row[[value_col]],
        linetype = "dashed",
        linewidth = 0.9
      )
  }
  
  return(p)
}