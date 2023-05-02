library(tidyverse)
library(lterdatasampler)
library(plotly)
library(ggiraph)

weather_2018 <- arc_weather %>% 
  filter(date > "2017-12-31") %>% 
  mutate(marker_text = paste("Date:", date, "<br>", "Mean air temp (F):", mean_airtemp))

weather_1990 <- arc_weather %>% 
  filter(date > "1989-12-31" & date < "1991-01-01") %>% 
  mutate(marker_text = paste("Date:", date, "<br>", "Mean air temp (F):", mean_airtemp))

max_temp <- weather_2018 %>% 
  filter(mean_airtemp == max(mean_airtemp))

static_2018 <- ggplot(data = weather_2018, aes(x = date, y = mean_airtemp)) +
  geom_point() +
  theme_classic()

static_1990 <- ggplot(data = weather_1990, aes(x = date, y = mean_airtemp)) +
  geom_point() +
  theme_classic()

ggplotly(static_2018)

plot_ly(data = weather_2018, x = ~date, y = ~mean_airtemp, type = "scatter", mode = "markers",
        marker = list(size = 10, 
                      color = "cornflowerblue", 
                      line = list(color = "coral", width = 2))) %>% 
  add_lines(name = "testline")

max_annotation <- list(
  x = max_temp$date,
  y = max_temp$mean_airtemp,
  text = "Maximum temperature recorded in 2018",
  xref = "x",
  yref = "y",
  showarrow = TRUE,
  arrowhead = 7,
  ax = 20,
  ay = -40
)

# creating marker text for later
marker_text <- paste("Mean air temp (F):", weather_2018$mean_airtemp, "<br>", "Date:", weather_2018$date)

# step 1. add your data
plotly_test <- plot_ly(data = weather_2018, 
        # adjust the hover box using marker_text object created up top
        hoverinfo = "text", text = ~marker_text) %>% 
  # add a line called "Average temperature line", adjust color and line width
  add_lines(x = ~date, y = ~mean_airtemp, name = "Average temperature line", 
            line = list(color = "#A8329E", width = 6)) %>% 
  # add markers called "Average temperature point", adjust color, symbol, and size
  add_markers(x = ~date, y = ~mean_airtemp, name = "Average temperature point", 
              marker = list(color = "#3248A8", symbol = "diamond", size = 10)) %>% 
  # add an annotation for max temperature
  add_annotations(# x and y coords
                  x = max_temp$date,
                  y = max_temp$mean_airtemp,
                  # text of annotation
                  text = "Maximum temperature recorded in 2018",
                  # arrow appearance adjustments
                  showarrow = TRUE,
                  arrowhead = 7,
                  # coordinates for text label
                  ax = 20,
                  ay = -40, 
                  # text font adjustments
                  font = list(color = "purple")) %>% 
  layout(title = "Toolik Field Station air temperature in 2018", 
         yaxis = list(zerolinecolor = "red"), plot_bgcolor = "green")

htmltools::save_html(plotly_test, "plotly_test.html")
  
  
  
plot <- ggplot(data = weather_2018, aes(x = date, y = mean_airtemp, 
                                        tooltip = marker_text, data_id = marker_text)) +
  geom_point_interactive()

  
girafe_plot <- girafe(ggobj = plot,
       options = list(
         opts_tooltip(
           opacity = 0.8, use_fill = TRUE,
           use_stroke = FALSE, 
           css = "padding:5pt;font-family: Garamond;font-size:1rem;color:white"),
         opts_hover_inv(css = "opacity:0.4"),
         opts_selection(
           type = "multiple",
           only_shiny = FALSE
         )
       ))

girafe_plot  

htmltools::save_html(girafe_plot, "girafe_plot.html")
  
  
  
ggplot(nwt_pikas, aes(x = site, concentration_pg_g)) +
  geom_jitter()
  

