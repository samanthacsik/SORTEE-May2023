
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                            Create a static plot                          ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(tidyverse)

#..........................read in data..........................

lobs <- readRDS(file = here::here("data", "lobsters_locations.rds"))

#.............................wrangle............................

# creating new data frame
lobs_summary <- lobs %>% 
  
  # calculate total lobster counts by protection status, site, & year (each point will represent lobster counts at a single site for each year from 2012-2018) ----
  group_by(protection_status, site, year) %>% 
  count() 

#.........................create boxplot.........................
static <- lobs_summary %>% 
  
  # create boxplot of mpa vs non-mpa lobster counts ----
  ggplot(aes(x = protection_status, y = n)) +
  geom_boxplot(width = 0.5, outlier.shape = NA) +
  geom_point(aes(color = site, shape = site), size = 4, alpha = 0.8, 
             # turn the points into a jitter (with a little more control than geom_jitter)
             position = position_jitter(width = 0.25, height = 0, seed = 1)) +
  
  # update colors ----
  scale_color_manual(values = c("#91B38A", "#9565CC", "#CCC065", "#658ACC", "#CC6565")) +
  scale_shape_manual(values = c(15, 25, 17, 18, 19)) +
  
  # update labels ----
  labs(x = "Protection Status",
       y = "Lobster Counts",
       color = "Site", 
       shape = "Site") + 
  
  # theme ----
  theme_linedraw() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 13),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 11))

static
   
