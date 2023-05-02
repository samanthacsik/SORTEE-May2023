library(tidyverse)
library(naniar)
library(janitor)


lobs <- readRDS(here::here("data", "lobsters.rds")) 

lobs_clean <- lobs |> 
  clean_names() |> 
  replace_with_na(replace = list(size_mm = -99999)) |> 
  group_by(transect) 
  #filter(site == "NAPL")

ggplot(lobs, aes(x = ))

ggplot(lobs_clean, aes(x = year, y = size_mm)) + 
  geom_jitter(width = 0.2)
  
