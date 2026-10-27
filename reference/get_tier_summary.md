# Retrieve Tier Summary from ReefCloud API

Fetches tier summary (longitude, latitude, local region) for a tier ID
from the ReefCloud API and returns an sf object with tier boundaries

## Usage

``` r
get_tier_summary(tier_id)
```

## Arguments

- tier_id:

  Character. The unique identifier for the region/tier to query.

## Value

An sf spatial data frame (EPSG:4326) containing boundaries for the tier.

## Details

Requires httr, jsonlite, dplyr, sf, purrr.

## Examples

``` r
# tier_sf <- get_tier_summary("exampleTierID")
# print(tier_sf)
```
