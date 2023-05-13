
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
  
  # clean col names & replace missing values with NA
  clean_names() |> 
  replace_with_na(replace = list(size_mm = -99999)) |> 
  
  # add col for site protection status
  mutate(protection_status = case_when(
    site == "AQUE" ~ "non-MPA",
    site == "NAPL" ~ "MPA",
    site == "IVEE" ~ "MPA",
    site == "MOHK" ~ "non-MPA",
    site == "CARP" ~ "non-MPA",
  )) |> 
  
  # add column with total lobs per observation
  mutate(total_count = count + num_ao) 

#.............combine lobster data and location data.............
lobs_loc <- full_join(lobs_clean, location) |> 
  
  # reorder factors for plotting (done here and not in last step above bc joining datasets on `site` coerces site back to character)
  mutate(site = as.factor(site),
         protection_status = fct_relevel(protection_status, "MPA", "non-MPA"),
         site = fct_relevel(site, "NAPL", "IVEE", "AQUE", "MOHK", "CARP")) |> 
  
  # select/rearrange desired cols
  select(year, date, site, protection_status, transect, replicate, size_mm, total_count, lat, lon)

#..........................save as RDS...........................
saveRDS(lobs_loc, file = here("data", "lobsters_locations.rds"))

#..............................test..............................
test <- readRDS(file = here("data", "lobsters_locations.rds"))





