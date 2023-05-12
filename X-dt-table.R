
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                        Create interactive data table                     ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(DT)

#..........................read in data..........................
lobs <- readRDS(file = here::here("data", "lobsters_locations.rds"))

#................create a basic interactive table................
datatable(data = lobs)

#................customize your interactive table................
datatable(data = lobs, 
          colnames = c("Year", "Date", "Site", "Protection status", "Transect", "Replicate", 
                       "Size (mm)", "Count", "Latitude", "Longitude"),
          filter = "top", 
          options = list(
            pageLength = 10, 
            autoWidth = TRUE,
            searchHighlight = TRUE
          ))
