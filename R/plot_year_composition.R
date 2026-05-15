# =============================================================
# File: plot_year_composition.R
# Description: Generates a stacked barplot of benthic cover per year for a
#              specified tier id, and depth using ReefCloud Public Dashboard data.
# Author: Samuel Chan
# Date: 2026-03-02
# Dependencies: ggplot2, dplyr, forcats, stringr, sf
# =============================================================

#' Create Stacked Year-Level Benthic Cover Plot 
#'
#' @description
#' Fetches year-level benthic cover via internal helpers and \code{get_benthic_cover()},
#' then produces a stacked bar chart of benthic groups per year for a single tier and depth.
#' 
#' Optional year-range subsetting allows users to restrict the plot
#' to a specific temporal window. The subtitle automatically reports
#' the effective year range used in the plot.
#'
#' @param tier_id Character or numeric. Region/tier ID used to retrieve site list and metadata.
#' @param depth Character. Depth category to filter (e.g., "shallow", "deep" or "none"). Default: "shallow". 
#' At tiers broader than the site level, depth is not assigned and regional data should assume "NA" for depth.
#' @param start_year Numeric or NULL. First year to include.
#'   If NULL (default), uses earliest available year.
#' @param end_year Numeric or NULL. Last year to include.
#'   If NULL (default), uses latest available year.
#' @param drop_zero_years Logical. If TRUE (default), remove years whose total stacked cover is 0 or all-NA.
#' @param fill_by Character. Choose which variable to use for fill: \code{"group"} (default) or \code{"group_code"}
#' @param coord_flip Logical. If TRUE, flip coordinates for readability. Default: TRUE.
#'
#' @return A list with components:
#'   \item{plot}{A \code{ggplot} object.}
#'   \item{df.sum}{The data frame used for plotting (tier_id, year, depth, group, cover, plotting_cover).}
#'
#' @details
#' This function mirrors the structure of \code{plot_temporal_cover()}, but stacks all benthic groups
#' instead of focusing on a single group with confidence intervals. It pulls group-wise cover via 
#' \code{get_benthic_cover()}. If multiple rows exist per group-depth, values are aggregated 
#' by mean (after ensuring percent scale).
#'
#' @examples
#' \dontrun{

#' # Default: all available years
#' res <- plot_year_composition(tier_id = 1705, depth = "NA")
#'
#' # Restrict to a time window
#' res <- plot_year_composition(
#'   tier_id = 1705,
#'   depth = "NA",
#'   start_year = 2014,
#'   end_year = 2022
#' )
#' }
#'
#' @import ggplot2 dplyr forcats stringr sf
#' @export
plot_year_composition <- function(
    tier_id,
    depth = "shallow",
    start_year = NULL,
    end_year = NULL,
    drop_zero_years = TRUE,
    fill_by = c("group", "group_code"),
    coord_flip = TRUE
) {
  
  # ---- Load required internal helpers (mirroring your reference) ----
  source("R/get_regional_summary.R")
  source("R/get_tier_summary.R")
  source("R/get_benthic_cover.R")
  source("R/load_plot_palette.R")
  
  # ---- Suppress messages ----
  old_opts <- options(dplyr.summarise.inform = FALSE)
  on.exit(options(old_opts), add = TRUE)
  
  # ---- Validate inputs ----
  fill_by <- match.arg(fill_by)
  
  if (missing(tier_id) || is.null(tier_id) || length(tier_id) != 1L) {
    stop("`tier_id` must be a single numeric identifier.")
  }
  if (!is.character(depth) || length(depth) != 1L) {
    stop("`depth` must be a single character scalar (e.g., 'shallow' or 'deep').")
  }
  if (!is.null(start_year) && !is.numeric(start_year)) {
    stop("`start_year` must be numeric.")
  }
  if (!is.null(end_year) && !is.numeric(end_year)) {
    stop("`end_year` must be numeric.")
  }
  if (!is.null(start_year) && !is.null(end_year) && start_year > end_year) {
    stop("`start_year` must be less than or equal to `end_year`.")
  }
  
  # ---- Region metadata and site list ----
  info <- get_regional_summary(tier_id)
  
  # ---- Fetch benthic cover for all sites in this tier ----
  raw <- get_benthic_cover(tier_id)
  
  if (is.null(raw) || !is.data.frame(raw) || nrow(raw) == 0) {
    stop("No benthic cover data returned by `get_benthic_cover()` for the provided sites. Check the depth provided.")
  }
  
  tdf <- get_tier_summary(tier_id) |> 
    sf::st_drop_geometry() |> 
    dplyr::select(- site_count)
  
  # ---- Filter by depth, join site names, and set default year if needed ----
  xdf <- raw |> 
    dplyr::filter(depth == !!depth) |> # keep minimal needed columns + join
    dplyr::mutate(year = as.numeric(year)) |>  
    dplyr::left_join(tdf)
  
  if (!is.null(start_year)) xdf <- dplyr::filter(xdf, year >= start_year)
  if (!is.null(end_year))   xdf <- dplyr::filter(xdf, year <= end_year)
  
  if (nrow(xdf) == 0) {
    stop("No data remaining after depth/year filtering.")
  }
  
  # ---- Select/rename plotting columns, ensure numeric percent ----
  xdf <- xdf |>
    dplyr::select(
      tier       = tier_name,
      tier_id    = tier_id,
      tier_level = tier_level,
      year       = year,
      depth      = depth,
      group      = type,
      group_code = type_code,
      cover      = mean
    ) |> 
    dplyr::mutate(cover = suppressWarnings(as.numeric(cover)))
  
  if (nrow(xdf) == 0) {
    stop("No rows after filtering for depth = '", depth, "'.")
  }
  
  # If multiple rows per year-group (replicates), aggregate by mean to get one bar segment
  xdf <- xdf |>
    dplyr::group_by(tier, year, depth, group, group_code) |>
    dplyr::summarise(plotting_cover = mean(cover, na.rm = TRUE), .groups = "drop")
  
  # ---- Optionally drop zero/NA-total sites ----
  if (isTRUE(drop_zero_years)) {
    keep_years <- xdf |>
      dplyr::group_by(year) |>
      dplyr::summarise(total = sum(plotting_cover, na.rm = TRUE)) |>
      dplyr::filter(total > 0) |>
      dplyr::pull(year)
    
    xdf <- dplyr::filter(xdf, year %in% keep_years)
  }
  
  if (nrow(xdf) == 0) {
    stop("No years remain after removing zero/NA total cover (if enabled).")
  }
  
  # ---- Derive year range for subtitle ----
  year_min <- min(xdf$year, na.rm = TRUE)
  year_max <- max(xdf$year, na.rm = TRUE)
  year_label <- if (year_min == year_max) {
    paste0(year_min)
  } else {
    paste0(year_min, "–", year_max)
  }
  
  # ---- Set fill ordering ----
  xdf <- xdf |>
    dplyr::mutate(
      fill_var = if (fill_by == "group") group else group_code,
      fill_fct = if (fill_by == "group") {
        forcats::fct_relevel(fill_var, names(group.pal))
      } else {
        forcats::fct_relevel(fill_var, names(groupcode.pal))
        }
    ) |> 
    dplyr::select(- fill_var)
  
  # ---- Build plot ----
  plot <- ggplot2::ggplot(xdf, ggplot2::aes(x = year, y = plotting_cover, fill = fill_fct)) +
    ggplot2::geom_col(width = 0.8, position = "fill") +
    ggplot2::scale_fill_manual(name = if (fill_by == "group") "Benthic Groups" else "Benthic Codes",  
                               values = if (fill_by == "group") group.pal else groupcode.pal) +
    ggplot2::scale_y_continuous(name = "Cover (%)", labels = scales::label_percent(suffix = "")) +
    ggplot2::scale_x_continuous(name = "Year") +
    ggplot2::theme_minimal() +
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(),  # Remove major grid lines
                   panel.grid.minor = ggplot2::element_blank()   # Remove minor grid lines
    ) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::labs(
      title = paste("Coral Reef Composition for ", info$region_name),
      subtitle = sprintf("Annual compositional data for reefs in Depth: %s, Years: %s", 
                         stringr::str_to_title(depth), 
                         stringr::str_to_title(year_label))
    )
  
  if (isTRUE(coord_flip)) {
    plot <- plot + ggplot2::coord_flip()
  }
  
  # ---- Save plot ----
  ggplot2::ggsave(plot,
                  filename = paste0("figures/", "YearComposition_", 
                                    info$region_name, 
                                    stringr:: str_to_title(depth), 
                                    stringr::str_to_title(year_label), 
                                    ".png"),
                  bg = "transparent", width = 12, height = 8
  )
  
  
  # ---- Return ----
  return(list(
    plot = plot,
    df.sum = xdf
  ))
}
