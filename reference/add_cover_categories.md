# Add Range-Based Cover Proportion and Category Columns (Ordered Factors)

Classifies benthic cover values from a specified numeric column into:

- A human-readable proportion range column: `cover_prop`

- An ordinal category column: `cover_cat` with levels `A` (highest) to
  `D` (lowest)

## Usage

``` r
add_cover_categories(
  df,
  column = "median",
  breaks = c(10, 30, 50),
  prop_labels = c("0 - 10%", "10 - 30%", "30 - 50%", "50 - 100%"),
  cat_labels = c("D", "C", "B", "A")
)
```

## Arguments

- df:

  A data frame containing a numeric column to classify.

- column:

  Character. The name of the column to classify.

- breaks:

  Numeric vector of length 3 giving the lower bounds for the second,
  third and fourth ranges respectively.

- prop_labels:

  Character vector of length 4 defining the labels for the ranges,
  ordered from lowest to highest.

- cat_labels:

  Character vector of length 4 defining category codes for the ranges,
  ordered from lowest to highest.

## Value

The input data frame with two additional ordered factor columns:

- `cover_prop`: One of `prop_labels`, ordered descending for plotting
  convenience.

- `cover_cat`: One of `cat_labels`, ordered descending (e.g.,
  `A > B > C > D`).

## Details

## Examples

``` r
if (FALSE) { # \dontrun{
df <- data.frame(median = c(NA, 5, 10, 15, 30, 35, 50, 55, 100))
add_cover_categories(df, column = "median")

# Custom breaks and labels
add_cover_categories(
  df, column = "median",
  breaks = c(10, 25, 40),
  prop_labels = c("0 - 10%", "10 - 25%", "25 - 40%", "40 - 100%"),
  cat_labels  = c("D", "C", "B", "A")
)
} # }
```
