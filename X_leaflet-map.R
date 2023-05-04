
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                  Create interactive leaflet map of sites                 ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(leaflet)

#..........................read in data..........................
lobs <- readRDS(file = here::here("data", "lobsters_locations.rds"))

#.......................create custom icon.......................
lobster_icon <- makeIcon(
  iconUrl = "media/lobster2.png",
  iconWidth = 20, iconHeight = 20
)

#...........................create map...........................

# initialize map ----
site_map <- leaflet() |> 
  
  # add base map tiles (use `addTiles()` for Google maps tiles, OR `addProviderTiles()` for 3rd party base maps: https://leaflet-extras.github.io/leaflet-providers/preview/) ----
  addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World Imagery") |> # modify base map appearance with options: `providerTileOptions(opacity = 0.5, noWrap = FALSE)`
  addProviderTiles(providers$Esri.OceanBasemap, group = "ESRI Oceans") |> 
  
  # set view over Santa Barbara Channel ----
  setView(lng =  -119.8276, lat = 34.4358, zoom = 9) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = TRUE) |> 
  
  # add markers - CURRENTLY SOOOO SLOW
  # addMarkers(data = lobs, #icon = lobster_icon,
  #            lng = ~lon, lat = ~lat,
  #            label = paste("Site Name:", lobs$site, "<br>",
  #                          "Coorinates (lat/long):", lobs$lat, ",", lobs$lon)) |>
  
  # add layers control (toggle base map tiles & markers based on group IDs)
  addLayersControl(
    baseGroups = c("ESRI World Imagery", "ESRI Oceans")
  )
                   

site_map
