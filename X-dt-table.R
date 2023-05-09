
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
datatable(data = lobs)
