# Retrieve Tier IDs from boundaries from ReefCloud API

Retrieves spatial tier from the ReefCloud API based on a specified tier
level and bounding box.

## Usage

``` r
get_tier_from_boundary(tier_level = 4, bbox)
```

## Arguments

- tier_level:

  Integer. The tier level to retrieve (must be between 2 and 6, default
  = 4).

- bbox:

  A named list or vector containing bounding box coordinates.

## Value

An `sf` object representing the tier boundaries.

## Details

The function gets all tier ids for a specified tier level and bounding
box using the ReefCloud API. Tier levels defaults to 4 (region) but can
be from 2 (country) to 6 (site).

## Examples

``` r
if (FALSE) { # \dontrun{
bbox <- list(xmin = 142, ymin = -20, xmax = 146, ymax = -18)
tiers_sf <- get_tier_from_boundary(tier_level = 4, bbox = bbox)
print(tiers_sf)
} # }
```
