library(tidyverse)
library(lterdatasampler)
library(plotly)
library(ggiraph)

weather_2018 <- arc_weather %>% 
  filter(date > "2017-12-31")

ggplot(data = weather_2018, aes(x = date, y = mean_airtemp)) +
  geom_point()

plot_ly(data = weather_2018, x = ~date, y = ~mean_airtemp, type = "scatter", mode = "markers")
