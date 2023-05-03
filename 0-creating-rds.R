
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                     Converting downloaded .csv to .rds                   ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(tidyverse)
library(here)

#..........................read in data..........................
# downloaded at: https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.77
lobsters <- read_csv(here("data", "Lobster_Abundance_All_Years_20220829.csv"))

#..........................save as RDS...........................
saveRDS(lobsters, file = here("data", "lobsters.rds"))

#..............................test..............................
lobsters <- readRDS(file = here("data", "lobsters.rds"))

