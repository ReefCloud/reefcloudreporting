# Validate bounding box input

Ensures that the bounding box contains valid numeric coordinates and
correct names.

## Usage

``` r
validate_bbox(bbox)
```

## Arguments

- bbox:

  A bounding box object (`sf::bbox`), named vector, or list.

## Value

TRUE if valid, otherwise throws an error.

## Examples

``` r
# Example 1: Valid bbox
valid_bbox <- c(xmin = 142.0, ymin = -10.0, xmax = 145.0, ymax = -8.0)
validate_bbox(valid_bbox)  # Returns TRUE
#> [1] TRUE

# Example 2: Invalid bbox
invalid_bbox <- c(xmin = 145.0, ymin = -10.0, xmax = 142.0, ymax = -8.0)
if (FALSE) { # \dontrun{
validate_bbox(invalid_bbox)  # Throws an error
} # }
```
