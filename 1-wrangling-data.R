
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##             data wrangling (combining lobster & location data)           ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# coordinates found in metadata: https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.77

#.........................load libraries.........................
library(tidyverse)
library(here)
library(janitor)
library(naniar)

#..........................read in data..........................
lobsters_raw <- readRDS(file = here::here("data", "lobsters.rds"))

#....................create df of site coords....................
location <- tribble(
  ~site, ~lat, ~lon,
  "AQUE", 34.46774988, -120.11905,
  "NAPL", 34.4221216, -119.95154,
  "IVEE", 34.402783, -119.85755,
  "MOHK", 34.3940708, -119.72957,
  "CARP", 34.3916319, -119.5416933
)

#.....................clean lobster_raw data.....................
lobs_clean <- lobsters_raw |> 
  clean_names() |> 
  replace_with_na(replace = list(size_mm = -99999)) 

#.............combine lobster data and location data.............
lobs_loc <- full_join(lobs_clean, location)

#..........................save as RDS...........................
saveRDS(lobs_loc, file = here("data", "lobsters_locations.rds"))

#..............................test..............................
test <- readRDS(file = here("data", "lobsters_locations.rds"))
