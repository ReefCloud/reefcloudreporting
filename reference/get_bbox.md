# Get Cleaned Sites and a Buffered WGS84 Bounding Box for a Tier

Retrieves sites via [`get_site_summary()`](get_site_summary.md),
extracts longitude/latitude from geometry, arranges and de-duplicates
records, optionally drops organisation fields, and computes a WGS84
(`EPSG:4326`) bounding box using a geodesic buffer.

## Usage

``` r
get_bbox(
  tier_id,
  buffer_m = 10,
  drop_org_cols = TRUE,
  return_bbox_as = c("bbox", "list", "polygon")
)
```

## Arguments

- tier_id:

  Character (or coercible). ReefCloud Tier ID.

- buffer_m:

  Numeric, non-negative. Buffer distance in meters around the sites'
  convex hull before computing the bbox. Default `10` (meters).

- drop_org_cols:

  Logical. Drop `org_name` and `org_id` if present. Default `TRUE`.

- return_bbox_as:

  Character. One of:

  - `"bbox"` (default): returns an `sf` bbox object.

  - `"list"`: named list with `xmin,ymin,xmax,ymax`.

  - `"polygon"`: buffered hull as an `sf` polygon (WGS84).

## Value

A list with:

- `sites`: an `sf` object of cleaned sites including `lon`, `lat`

- `bbox`: a bbox/list/polygon depending on `return_bbox_as`

## Details

- If sites are not in WGS84, they are transformed to EPSG:4326 before
  any processing.

- The function expands the bbox by \\buffer_m / 111000\\ degrees.

- To avoid zero-area bboxes for identical/near-identical site
  coordinates, a tiny minimal expansion is applied when the hull area is
  zero.

## Examples

``` r
if (FALSE) { # \dontrun{
# Basic: fetch, clean, and get a small buffered bbox
out <- get_bbox(tier_id = 1705, buffer_m = 10)
out$sites
out$bbox

# Supply a year to the underlying API:
out <- get_bbox(tier_id = "1705", buffer_m = 10,
                                return_bbox_as = "list")

out$bbox  # named list xmin/ymin/xmax/ymax
} # }
```
