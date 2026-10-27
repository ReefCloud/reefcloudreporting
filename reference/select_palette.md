# Select a palette by benthic group and domain

Convenience helper to retrieve a named palette vector for use with
`cover_prop` or `cover_cat`.

## Usage

``` r
select_palette(group = c("hc", "ma", "sc"), use = c("prop", "cat"))
```

## Arguments

- group:

  Character. One of `"hc"`, `"ma"`, `"sc"`.

- use:

  Character. Domain: `"prop"` for `cover_prop` labels, or `"cat"` for
  `cover_cat` A–D codes.

## Value

A named character vector of HEX colors suitable for
`ggplot2::scale_fill_manual()` or `ggplot2::scale_color_manual()`.

## Examples

``` r
if (FALSE) { # \dontrun{
select_palette("hc", use = "prop")

# Helper to pick palette by domain ('prop' or 'cat') and group ('hc', 'ma', 'sc')
ggplot(df_prop, aes(x = cover_prop, y = value, fill = cover_prop)) +
  geom_col() +
  scale_fill_manual(values = select_palette("hc", use = "prop"))
  } # }
```
