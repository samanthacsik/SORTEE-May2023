
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
          # make the column names nice ----
          colnames = c("Year", "Date", "Site", "Protection status", "Transect", "Replicate", 
                       "Size (mm)", "Count", "Latitude", "Longitude"),
          
          # column filters: sliders and drop down menus ----
          filter = "top", 
          
          # extensions: lots of these! ----
          extensions = c("Buttons", "ColReorder"),
          
          # options ----
          options = list(
            # list 10 entries at once
            pageLength = 10, 
            # automatically size columns
            autoWidth = TRUE,
            # highlight entries that match search term
            searchHighlight = TRUE,
            # allow regular expressions and case insensitive searches
            search = list(regex = TRUE, caseInsensitive = TRUE),
            dom = "Bfrtip",
            # buttons options
            buttons = c("copy", "csv", "excel", "pdf", "print", "colvis"),
            # links to extension call
            colReorder = TRUE)
          ) %>% 
  
  # styling cells: coloring site background
  formatStyle(
    "site",
    # styleEqual allows matches to column contents
    backgroundColor = styleEqual(
      levels = list("NAPL", "IVEE", "AQUE", "MOHK", "CARP"),
      values = c("NAPL" = "#91B38A", 
                 "IVEE" = "#9565CC", 
                 "AQUE" = "#CCC065", 
                 "MOHK" = "#658ACC", 
                 "CARP" = "#CC6565")
    )
  )
