# Fetches site summary (longitude, latitude, local region) for a set of site IDs from the ReefCloud API and returns an sf object with site coordinates.

Fetches site summary (longitude, latitude, local region) for a set of
site IDs from the ReefCloud API and returns an sf object with site
coordinates.

## Usage

``` r
get_site_summary(tier_id)
```

## Arguments

- tier_id:

  Character. The unique identifier for the region/tier to query.

## Value

An sf spatial data frame (EPSG:4326) containing longitude and latitude
for each site.

## Details

Requires httr, jsonlite, dplyr, sf, purrr.

## Examples

``` r
# sites_sf <- get_site_summary("exampleTierID")
# print(sites_sf)
```
