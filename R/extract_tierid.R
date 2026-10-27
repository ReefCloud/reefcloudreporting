#' Extract ReefCloud tier IDs by geographic name
#'
#' @description
#' Searches the ReefCloud lookup table for one or more geographic names
#' and returns the corresponding tier IDs. Only lookup rows with
#' observations are searched.
#'
#' Names are matched against the following columns:
#' \itemize{
#'   \item \code{tier2_name}: country-level names; returns \code{tier2}.
#'   \item \code{tier3_name}: regional names; returns \code{tier3}.
#'   \item \code{tier4_name}: sub-regional names; returns \code{tier4}.
#' }
#'
#' Matching ignores case, accent marks, and leading or trailing whitespace.
#' For example, \code{"Islas de la Bahia"} matches
#' \code{"Islas de la Bahía"}. Otherwise, the full name must match;
#' partial names are not supported.
#'
#' If a row has the same normalized name in \code{tier2_name} and
#' \code{tier3_name}, its tier3 ID is excluded in favour of tier2.
#' Tier4 matches are unaffected by this rule.
#'
#' A name may match multiple locations or tiers. All matching IDs are
#' returned, subject to the tier3 exclusion above, with duplicates removed.
#' Matching a country name does not automatically return the IDs of its
#' regions or sub-regions.
#'
#' @param name A character vector containing one or more geographic names.
#'   Missing values and empty or whitespace-only names are not allowed.
#' @param lookup_file Path to a UTF-8 CSV containing \code{tier2},
#'   \code{tier2_name}, \code{tier3}, \code{tier3_name}, \code{tier4},
#'   \code{tier4_name}, and \code{contains_data}.
#'
#' @return An unnamed vector of unique tier IDs, ordered by input name
#'   and then by tier2, tier3, and tier4 matches within each name.
#'   An error is raised if any supplied name has no eligible match or
#'   if a matching ID is missing.
#'
#' @export

extract_tierid <- function(
    name,
    lookup_file = "extdata/reefcloud_dashboard_tier_lookup.csv") {

  if (!is.character(name) || length(name) == 0L ||
      anyNA(name) || any(trimws(name) == "")) {
    stop("`name` must contain non-empty character strings.", call. = FALSE)
  }

  if (!file.exists(lookup_file)) {
    stop("Lookup file not found: ", lookup_file, call. = FALSE)
  }

  lookup_table <- readr::read_csv(
    lookup_file,
    locale = readr::locale(encoding = "UTF-8"),
    show_col_types = FALSE
  ) %>%
    dplyr::filter(contains_data == 1)

  tier_columns <- c("tier2", "tier3", "tier4")
  name_columns <- paste0(tier_columns, "_name")
  required_columns <- c(tier_columns, name_columns)
  required_columns <- c(required_columns, "contains_data")
  missing_columns <- setdiff(required_columns, names(lookup_table))

  if (length(missing_columns) > 0L) {
    stop(
      "Lookup table is missing columns: ",
      paste(missing_columns, collapse = ", "),
      call. = FALSE
    )
  }

   normalize_name <- function(x) {
      x <- stringi::stri_trans_general(x, "NFD; [:Nonspacing Mark:] Remove; NFC")
      stringi::stri_trans_toupper(trimws(x))
  }

   keys <- normalize_name(name)

ids_by_name <- lapply(seq_along(keys), function(i) {
  ids <- unlist(lapply(tier_columns, function(tier) {
    table_keys <- normalize_name(lookup_table[[paste0(tier, "_name")]])
    matched <- !is.na(table_keys) & table_keys == keys[i]

    # Exclude tier3 when its name is the same as tier2.
    if (tier == "tier3") {
      tier2_names <- normalize_name(lookup_table$tier2_name)
      same_as_tier2 <- !is.na(tier2_names) & tier2_names == table_keys
      matched <- matched & !same_as_tier2
    }

    lookup_table[[tier]][matched]
  }), use.names = FALSE)

  if (length(ids) == 0L) {
    stop("Name '", name[i], "' not found in the lookup table.", call. = FALSE)
  }

  if (anyNA(ids)) {
    stop("Missing tier ID for name '", name[i], "'.", call. = FALSE)
  }

  unique(ids)
})

  unique(unlist(ids_by_name, use.names = FALSE))
}

