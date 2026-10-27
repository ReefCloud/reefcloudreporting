# =============================================================
# File: load_plot_palette.R
# Description: Defines color palettes for benthic cover ranges
# Author: Samuel Chan
# Date: 2026-01-07
# =============================================================
#
#' Benthic cover colour palettes
#'
#' @description
#' Named colour palettes used for plotting benthic cover categories and
#' benthic group classifications in ReefCloud reporting outputs.
#'
#' The palettes are keyed to either:
#' \itemize{
#'   \item \code{cover_prop}: cover proportion ranges.
#'   \item \code{cover_cat}: cover category codes.
#'   \item Benthic group names.
#'   \item Benthic group codes.
#' }
#'
#' @details
#' Cover proportion palettes use the levels:
#' \code{"50 - 100%"}, \code{"30 - 50%"},
#' \code{"10 - 30%"}, and \code{"0 - 10%"}.
#'
#' Cover category palettes use the levels:
#' \code{"A"}, \code{"B"}, \code{"C"}, and \code{"D"},
#' where \code{A} represents the highest cover category.
#'
#' @format Eight named character vectors:
#' \describe{
#'   \item{hc.pal_prop}{Hard coral palette keyed to cover proportion ranges.}
#'   \item{ma.pal_prop}{Macroalgae palette keyed to cover proportion ranges.}
#'   \item{sc.pal_prop}{Soft coral palette keyed to cover proportion ranges.}
#'   \item{hc.pal_cat}{Hard coral palette keyed to cover categories A-D.}
#'   \item{ma.pal_cat}{Macroalgae palette keyed to cover categories A-D.}
#'   \item{sc.pal_cat}{Soft coral palette keyed to cover categories A-D.}
#'   \item{group.pal}{Palette keyed to benthic group names.}
#'   \item{groupcode.pal}{Palette keyed to benthic group codes.}
#' }
#'
#' @examples
#' hc.pal_prop
#' ma.pal_cat
#' group.pal
#'
#' @name benthic_palettes
NULL

#' @rdname benthic_palettes
#' @export
hc.pal_prop <- c(
  "50 - 100%" = "#ae017e",
  "30 - 50%"  = "#f768a1",
  "10 - 30%"  = "#fbb4b9",
  "0 - 10%"   = "#feebe2"
)

#' @rdname benthic_palettes
#' @export
ma.pal_prop <- c(
  "50 - 100%" = "#238443",
  "30 - 50%"  = "#78c679",
  "10 - 30%"  = "#c2e699",
  "0 - 10%"   = "#ffffcc"
)

#' @rdname benthic_palettes
#' @export
sc.pal_prop <- c(
  "50 - 100%" = "#6a51a3",
  "30 - 50%"  = "#9e9ac8",
  "10 - 30%"  = "#cbc9e2",
  "0 - 10%"   = "#f2f0f7"
)

#' @rdname benthic_palettes
#' @export
hc.pal_cat <- c(
  "A" = "#ae017e",
  "B" = "#f768a1",
  "C" = "#fbb4b9",
  "D" = "#feebe2"
)

#' @rdname benthic_palettes
#' @export
ma.pal_cat <- c(
  "A" = "#238443",
  "B" = "#78c679",
  "C" = "#c2e699",
  "D" = "#ffffcc"
)

#' @rdname benthic_palettes
#' @export
sc.pal_cat <- c(
  "A" = "#6a51a3",
  "B" = "#9e9ac8",
  "C" = "#cbc9e2",
  "D" = "#f2f0f7"
)

#' @rdname benthic_palettes
#' @export
group.pal <- c(
  "hard coral" = "#f768a1",
  "soft coral" = "#9e9ac8",
  "macroalgae" = "#78c679",
  "turf algae" = "#80b1d3",
  "crustose coralline algae" = "#fdb462",
  "other" = "#ffffb3"
)

#' @rdname benthic_palettes
#' @export
groupcode.pal <- c(
  "hc" = "#f768a1",
  "sc" = "#9e9ac8",
  "ma" = "#78c679",
  "ta" = "#80b1d3",
  "ca" = "#fdb462",
  "ot" = "#ffffb3"
)
