library(tidyverse)
library(here)

lobsters <- read_csv(here("data", "Lobster_Abundance_All_Years_20220829.csv"))

saveRDS(lobsters, file = here("data", "lobsters.rds"))

lobsters <- readRDS(file = here("data", "lobsters.rds"))


