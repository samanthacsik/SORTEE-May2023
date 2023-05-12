
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                  Create interactive leaflet map of sites                 ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.........................load libraries.........................
library(leaflet)
library(leaflet.extras)
library(tidyverse)

#..........................read in data..........................
lobs <- readRDS(file = here::here("data", "lobsters_locations.rds"))

#..................get unique site/location data.................
sites <- lobs |> 
  select(site, protection_status, lat, lon) |> 
  distinct()

#......................split MPA vs non-MPA......................
mpa <- sites |> 
  filter(protection_status == "MPA")

non_mpa <- sites |> 
  filter(protection_status == "non-MPA")
  
#.......................create custom icon.......................
lobster_icon <- makeIcon(
  iconUrl = "media/lobster.png",
  iconWidth = 30, iconHeight = 30
)

#...........................create map...........................

# initialize map ----
site_map <- leaflet() |> 
  
  # add base map tiles (use `addTiles()` for Google maps tiles, OR `addProviderTiles()` for 3rd party base maps: https://leaflet-extras.github.io/leaflet-providers/preview/) ----
  addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World Imagery") |> # modify base map appearance with options: `providerTileOptions(opacity = 0.5, noWrap = FALSE)`
  addProviderTiles(providers$Esri.OceanBasemap, group = "ESRI Oceans") |> 
  
  # add mini map ----
  addMiniMap(toggleDisplay = TRUE, minimized = TRUE) |> 
  
  # set view over Santa Barbara Channel ----
  setView(lng =  -119.83, lat = 34.44, zoom = 9) |> 
  
  # add MPA markers ----
  addMarkers(data = mpa, group = "MPA Sites",
             icon = lobster_icon,
             lng = ~lon, lat = ~lat,
             popup = paste("Site Name:", sites$site, "<br>",
                           "Coorinates (lat/long):", sites$lat, ",", sites$lon)) |>
  
  # add non-MPA markers ----
  addMarkers(data = non_mpa, group = "Non-MPA Sites",
             icon = lobster_icon,
             lng = ~lon, lat = ~lat,
             popup = paste("Site Name:", sites$site, "<br>",
                           "Coorinates (lat/long):", sites$lat, ",", sites$lon)) |>

  # add layers control (toggle base map tiles & markers based on group IDs) ----
  addLayersControl(
    baseGroups = c("ESRI World Imagery", "ESRI Oceans"),
    overlayGroups = c("MPA Sites", "Non-MPA Sites")) |> 
  
  # add reset map button ----
  leaflet.extras::addResetMapButton()
                   

# print map ----
site_map

#............................save html...........................
# htmltools::save_html(lplot, "leaflet.html")