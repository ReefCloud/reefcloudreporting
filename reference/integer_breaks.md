# Generate integer breaks for ggplot2 Axis

This helper function returns a function that generates integer breaks
for ggplot2 axes using [`pretty()`](https://rdrr.io/r/base/pretty.html)
and [`floor()`](https://rdrr.io/r/base/Round.html).

## Usage

``` r
integer_breaks(n = 5, ...)
```

## Arguments

- n:

  Integer. Desired number of breaks (default is 5).

- ...:

  Additional arguments passed to
  [`pretty()`](https://rdrr.io/r/base/pretty.html).

## Value

A function that takes a numeric vector and returns integer axis breaks.

## Examples

``` r
if (FALSE) { # \dontrun{
scale_x_continuous(breaks = integer_breaks())
} # }
```
