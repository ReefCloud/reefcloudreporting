# reefcloudreporting

A collection of functions to call upon the ReefCloud API to access the
ReefCloud Public Dashboard data for generating figures for use in
reporting.

## Installation

You can install the development version of reefcloudreporting from
[GitHub](https://github.com/ReefCloud/reefcloudreporting) with:

``` r

# install.packages("pak")
pak::pak("ReefCloud/reefcloudreporting")
```

## Guidelines

These functions and the package (TBD) are designed to be used with
ReefCloud data and aims to make the reporting pipeline through data
collection and analysis more efficient. There are four major groups of
functions and templates designed around different purposes.

### Functions

These are functions that call upon the ReefCloud API directly, to access
data that are made publicly available by the different project owners.
Many of these functions use the Tiers defined by reef regions or sites
at the most specific level and give aggregated information based on
modelled data as compared to raw individual data
(<https://docs.reefcloud.ai/get-results/public-dashboard>). Other
functions that use the data from the API functions to create standard
plots that are commonly used to in regular reporting for different
organisations, made in partnership with these organisations. The idea
here is that these functions can be called within the framework of a
Quarto markdown file within the *Reporting templates* section to
generate a relatively automated skeleton of a report that can then be
filled with more information to explain the status and trends. This is
designed to speed up reporting with ReefCloud data. Many of these
functions are wrapped around the ggplot2 package to make plots and can
be created on your own with ggplot as well.

### Vignettes

These are documentation and tutorials designed to guide users into
developing the steps or codes necessary to produce common data and
figures from the [ReefCloud public
dashboard](https://reefcloud.ai/dashboard/).
