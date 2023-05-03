library(tidyverse)
library(naniar)
library(janitor)


lobs_clean <- lobsters |> 
  clean_names() |> 
  replace_with_na(replace = list(size_mm = -99999)) %>% 
  mutate(mpa_status = case_when(
    site == "NAPL" ~ "MPA",
    site == "IVEE" ~ "MPA",
    site == "AQUE" ~ "non-MPA",
    site == "MOHK" ~ "non-MPA",
    site == "CARP" ~ "non-MPA"
  ), 
  mpa_status = fct_relevel(mpa_status, "MPA", "non-MPA")) %>% 
  mutate(site = fct_relevel(site, "NAPL", "IVEE", "AQUE", "MOHK", "CARP"))


lobs_clean %>% 
  group_by(mpa_status, site, year) %>% 
  count() %>% 
  ggplot(aes(x = mpa_status, y = n)) +
  geom_boxplot(width = 0.15, outlier.shape = NA) +
  geom_jitter(width = 0.1, aes(color = site))
