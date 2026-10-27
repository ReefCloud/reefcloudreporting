# Benthic cover colour palettes

Named colour palettes used for plotting benthic cover categories and
benthic group classifications in ReefCloud reporting outputs.

The palettes are keyed to either:

- `cover_prop`: cover proportion ranges.

- `cover_cat`: cover category codes.

- Benthic group names.

- Benthic group codes.

## Usage

``` r
hc.pal_prop

ma.pal_prop

sc.pal_prop

hc.pal_cat

ma.pal_cat

sc.pal_cat

group.pal

groupcode.pal
```

## Format

Eight named character vectors:

- hc.pal_prop:

  Hard coral palette keyed to cover proportion ranges.

- ma.pal_prop:

  Macroalgae palette keyed to cover proportion ranges.

- sc.pal_prop:

  Soft coral palette keyed to cover proportion ranges.

- hc.pal_cat:

  Hard coral palette keyed to cover categories A-D.

- ma.pal_cat:

  Macroalgae palette keyed to cover categories A-D.

- sc.pal_cat:

  Soft coral palette keyed to cover categories A-D.

- group.pal:

  Palette keyed to benthic group names.

- groupcode.pal:

  Palette keyed to benthic group codes.

An object of class `character` of length 4.

An object of class `character` of length 4.

An object of class `character` of length 4.

An object of class `character` of length 4.

An object of class `character` of length 4.

An object of class `character` of length 4.

An object of class `character` of length 6.

An object of class `character` of length 6.

## Details

Cover proportion palettes use the levels: `"50 - 100%"`, `"30 - 50%"`,
`"10 - 30%"`, and `"0 - 10%"`.

Cover category palettes use the levels: `"A"`, `"B"`, `"C"`, and `"D"`,
where `A` represents the highest cover category.

## Examples

``` r
hc.pal_prop
#> 50 - 100%  30 - 50%  10 - 30%   0 - 10% 
#> "#ae017e" "#f768a1" "#fbb4b9" "#feebe2" 
ma.pal_cat
#>         A         B         C         D 
#> "#238443" "#78c679" "#c2e699" "#ffffcc" 
group.pal
#>               hard coral               soft coral               macroalgae 
#>                "#f768a1"                "#9e9ac8"                "#78c679" 
#>               turf algae crustose coralline algae                    other 
#>                "#80b1d3"                "#fdb462"                "#ffffb3" 
```
