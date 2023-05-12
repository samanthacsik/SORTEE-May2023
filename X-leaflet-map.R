
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                  Create interactive leaflet map of sites                 ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(leaflet)
library(tidyverse)

#..........................read in data..........................
lobs <- readRDS(file = here::here("data", "lobsters_locations.rds"))

#..................get unique site/location data.................
sites <- lobs |> 
  select(site, protection_status, lat, lon) |> 
  distinct()
  
#.......................create custom icon.......................
lobster_icon <- makeIcon(
  iconUrl = "media/lobster.png",
  iconWidth = 30, iconHeight = 30
)

#...........................create map...........................

# initialize map ----
site_map <- leaflet(data = sites) |> 
  
  # add base map tiles (use `addTiles()` for Google maps tiles, OR `addProviderTiles()` for 3rd party base maps: https://leaflet-extras.github.io/leaflet-providers/preview/) ----
  addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World Imagery",
                   options = providerTileOptions(noWrap = FALSE)) |> # modify base map appearance with options: `providerTileOptions(opacity = 0.5, noWrap = FALSE)`
  addProviderTiles(providers$Esri.OceanBasemap, group = "ESRI Oceans") |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = TRUE) |> 
  
  # set view over Santa Barbara Channel ----
  setView(lng =  -119.8276, lat = 34.4358, zoom = 9) |> 
  
  # add markers
  addMarkers(icon = lobster_icon,
             lng = ~lon, lat = ~lat,
             popup = paste("Site Name:", sites$site, "<br>",
                           "Coorinates (lat/long):", sites$lat, ",", sites$lon)) |>

  # add layers control (toggle base map tiles & markers based on group IDs)
  addLayersControl(
    baseGroups = c("ESRI World Imagery", "ESRI Oceans")
  )
                   

site_map
