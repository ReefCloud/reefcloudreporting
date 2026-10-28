# Extract ReefCloud tier IDs by geographic name

Searches the ReefCloud lookup table for one or more geographic names and
returns the corresponding tier IDs. Only lookup rows with observations
are searched.

Names are matched against the following columns:

- `tier2_name`: country-level names; returns `tier2`.

- `tier3_name`: regional names; returns `tier3`.

- `tier4_name`: sub-regional names; returns `tier4`.

Matching ignores case, accent marks, and leading or trailing whitespace.
For example, `"Islas de la Bahia"` matches `"Islas de la Bahía"`.
Otherwise, the full name must match; partial names are not supported.

If a row has the same normalized name in `tier2_name` and `tier3_name`,
its tier3 ID is excluded in favour of tier2. Tier4 matches are
unaffected by this rule.

A name may match multiple locations or tiers. All matching IDs are
returned, subject to the tier3 exclusion above, with duplicates removed.
Matching a country name does not automatically return the IDs of its
regions or sub-regions.

## Usage

``` r
extract_tierid(
  name,
  lookup_file = "extdata/reefcloud_dashboard_tier_lookup.csv"
)
```

## Arguments

- name:

  A character vector containing one or more geographic names. Missing
  values and empty or whitespace-only names are not allowed.

- lookup_file:

  Path to a UTF-8 CSV containing `tier2`, `tier2_name`, `tier3`,
  `tier3_name`, `tier4`, `tier4_name`, and `contains_data`.

## Value

An unnamed vector of unique tier IDs, ordered by input name and then by
tier2, tier3, and tier4 matches within each name. An error is raised if
any supplied name has no eligible match or if a matching ID is missing.
