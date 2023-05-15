
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                0. Setting up                             ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(tidyverse) # general use
library(plotly) # JS plots!
library(DT) # JS tables!
library(leaflet) # JS maps!
library(leaflet.extras) # leaflet add-ons!

# reading in the RDS (saved data object)
lobs <- readRDS(file = here::here("data", "lobsters.rds"))

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                          1. Summarizing the data                         ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# creating new data frame
lobs_summary <- lobs %>% 
  
  # calculate total lobster counts by protection status, site, & year (each point will represent lobster counts at a single site for each year from 2012-2018) ----
  group_by(protection_status, site, year) %>% 
  count()

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                2. `plotly`                               ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ a. create a static plot  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

static <- lobs_summary %>% 
  
  # create boxplot of mpa vs non-mpa lobster counts ----
ggplot(aes(x = protection_status, y = n)) +
  
  # geoms: a boxplot and points with jitter
  geom_boxplot(width = 0.5, outlier.shape = NA) +
  geom_point(aes(color = site, shape = site), size = 4, alpha = 0.8, 
             # turn the points into a jitter (with a little more control than geom_jitter)
             position = position_jitter(width = 0.25, height = 0, seed = 1)) +
  
  # update colors ----
scale_color_manual(values = c("NAPL" = "#91B38A", 
                              "IVEE" = "#9565CC", 
                              "AQUE" = "#CCC065", 
                              "MOHK" = "#658ACC", 
                              "CARP" = "#CC6565")) +
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

# print plot ----
static

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ b. create an interactive plot  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ c. create a better interactive plot  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.......................i. create a marker.......................


#....ii. make a new static plot with `text = marker` aes arg.....

# creating a new static plot
static_with_marker <- lobs_summary_marker %>% 
  
  # create boxplot of mpa vs non-mpa lobster counts ----
ggplot(aes(x = protection_status, y = n, text = marker, group = protection_status)) +
  
  # geoms: boxplot and jitter
  geom_boxplot(width = 0.5, outlier.shape = NA) +
  geom_point(aes(color = site, shape = site), size = 4, alpha = 0.8, 
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

# running the ggplot object will give you a scary warning - that's ok!
static_with_marker

#................iii. create a plot with markers.................


#..................iv. doing things in `plot_ly`.................


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                    `DT`                                  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ a. create a basic interactive table  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ b. customizing your DT  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                  `leaflet`                               ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ a. some cleaning and filtering  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# create df of unique sites ----
sites <- lobs %>% 
  select(site, protection_status, lat, lon) %>% 
  distinct()

# just mpa sites ----
mpa <- sites %>% 
  filter(protection_status == "MPA")

# just non-mpa sites ----
non_mpa <- sites %>% 
  filter(protection_status == "non-MPA")

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ b. create a custom icon  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ c. create a map!  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                          4. save your html objects                       ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

htmltools::save_html(lobs_interactive, here::here("outputs", "plotly.html"))
htmltools::save_html(lobs_dt, here::here("outputs", "dt.html"))
htmltools::save_html(site_map, here::here("outputs", "leaflet.html"))

