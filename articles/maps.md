# Create maps of data location

## Setting up

``` r

# Load packages
library(reefcloudreporting)
library(sf)
library(ggplot2)
library(dplyr)
library(purrr)
library(stringi)
```

## 1. Generate tiers id

``` r

tierids <- extract_tierid(c("Palau", "Koror"))
```

## 2. Extract bounding box and site locations

``` r

bboxes <- purrr::map(tierids, function(ids) {
  purrr::map(ids, get_bbox)
})
```

## 4. Create the map
