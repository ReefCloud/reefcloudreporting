# Load ReefCloud Logo as a Raster Graphic

This function retrieves the ReefCloud logo from the specified URL,
converts it from SVG format to a raster image, and returns it as a
`rasterGrob` object suitable for use in plots or graphical layouts.

## Usage

``` r
load_logo()
```

## Value

A [`grid::rasterGrob`](https://rdrr.io/r/grid/grid.raster.html) object
containing the ReefCloud logo.

## Details

The function uses the `rsvg` package to render the SVG logo and the
`grid` package to create a raster graphic object.

## Examples

``` r
# Example usage:
logo_grob <- load_logo()
grid::grid.draw(logo_grob)

```
