# Get Regional Summary from ReefCloud API

Retrieves summary metadata for a ReefCloud tier ID, including region
name, site counts, image counts, contributors, and site identifiers.

## Usage

``` r
get_regional_summary(tier_id)
```

## Arguments

- tier_id:

  Character scalar. ReefCloud Tier ID.

## Value

A named list containing:

- `region_name`

- `site_count`

- `photo_quadrats`

- `data_contributors`

- `site_id`

- `source`

## Details

Sends a GET request to the ReefCloud Dashboard API and parses the JSON
response. Fails early with informative errors if the request or response
is invalid.

## Examples

``` r
if (FALSE) { # \dontrun{
summary <- get_regional_summary("1705")
str(summary)
} # }
```
