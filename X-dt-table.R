
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
          extensions = c("Buttons", "ColReorder"),
          options = list(
            pageLength = 10, 
            autoWidth = TRUE,
            searchHighlight = TRUE,
            search = list(regex = TRUE, caseInsensitive = TRUE),
            dom = "Bfrtip",
            buttons = c("copy", "csv", "excel", "pdf", "print", "colvis"),
            colReorder = TRUE)
          ) %>% 
  formatStyle(
    "site",
    backgroundColor = styleEqual(
      levels = list("NAPL", "IVEE", "AQUE", "MOHK", "CARP"),
      values = c("NAPL" = "#91B38A", 
                 "IVEE" = "#9565CC", 
                 "AQUE" = "#CCC065", 
                 "MOHK" = "#658ACC", 
                 "CARP" = "#CC6565")
    )
  )
