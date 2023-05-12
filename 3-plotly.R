
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##             Create an interactive plot using {plotly}                    ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#...................source 2-static-graph.R......................

source("2-static-graph.R")

#.........................load libraries.........................

library(plotly)

#..................most basic interactive plot...................

ggplotly(static)

# but we want to make this better!

lobs_summary_marker <- lobs_summary %>% 
  
  # create a new column called "marker" ----
  mutate(marker = paste("Site:", site, "<br>",
                      "Year:", year, "<br>",
                      "Status:", protection_status, "<br>",
                      "Lobster count:", n))

static_with_marker <- lobs_summary_marker %>% 
  
  # create boxplot of mpa vs non-mpa lobster counts ----
  ggplot(aes(x = protection_status, y = n, text = marker, group = protection_status)) +
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

interactive <- ggplotly(static_with_marker, tooltip = "text") %>% 
  layout(hoverlabel = list(
    font = list(
      family = "Times",
      size = 13,
      color = "#FFFFFF",
      align = "left"
    )
  ))

fig <- plotly_build(interactive)

fig

# doing it in plot_ly:

# plot_ly(ggplot2::diamonds, y = ~price, color = ~cut, type = "box")

plot_ly(lobs_summary_marker, 
        y = ~ n,
        color = ~ protection_status,
        type = "box",
        boxpoints = "all",
        pointpos = 0,
        jitter = 0.25,
        hoverinfo = "text", 
        text = ~ marker) 











