# Retrieve Benthic Cover Trend Data for One or Multiple Tiers from ReefCloud API

This function fetches and processes survey data for one or more
specified tiers from the ReefCloud dashboard API. It returns a tidy data
frame containing estimated cover (percent) and credible intervals for
each surveyed year, major functional groups, and tier identifier.

## Usage

``` r
get_benthic_cover(tier_ids)
```

## Arguments

- tier_ids:

  Character vector. One or more unique identifiers for the
  region/tier(s) to query.

## Value

A data frame containing the survey compositions for the specified
tier(s). The data frame excludes the survey ID, unnests the compositions
field, and includes a `tier_id` column.

## Details

The function sends a GET request to the ReefCloud dashboard API for each
tier ID, parses the JSON response, and returns the combined survey data
as a tidy data frame. Requires the `httr`, `jsonlite`, `dplyr`, `tidyr`,
and `lubridate` packages.

If a tier ID returns no data or the API request fails, a warning is
issued and that tier is skipped.

## Examples

``` r
# Example usage:
# Single tier
surveys_single <- get_benthic_cover("exampleTierID")
#> Warning: API request failed for tier_id: exampleTierID (status: 422)
print(surveys_single)
#> # A tibble: 0 × 0

# Multiple tiers
surveys_multi <- get_benthic_cover(c("tierID1", "tierID2"))
#> Warning: API request failed for tier_id: tierID1 (status: 422)
#> Warning: API request failed for tier_id: tierID2 (status: 422)
print(surveys_multi)
#> # A tibble: 0 × 0
```
