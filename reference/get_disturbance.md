# Retrieve Environmental Disturbance Data from ReefCloud API

This function fetches environmental disturbance data (thermal stress or
storm exposure) for a specified region (tier) from the ReefCloud API.
Returns a data frame with disturbance details and the corresponding
year.

## Usage

``` r
get_disturbance(tier_id, e_type)
```

## Arguments

- tier_id:

  Character. Unique identifier for the region/tier to query.

- e_type:

  Character. Type of environmental disturbance to retrieve. Options:
  "thermal_stress", "storm_exposure_year" or "storm_exposure_event".

## Value

Data frame containing disturbance data for the specified region and
event type, with an added 'Year' column.

## Details

The function sends a GET request to the ReefCloud dashboard API, parses
the JSON response, and returns a tidy data frame.

## Examples

``` r
if (FALSE) { # \dontrun{
disturbances <- get_disturbance(tier_id = "1705", e_type = "thermal_stress")
head(disturbances)
} # }
```
