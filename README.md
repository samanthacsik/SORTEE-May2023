## Integrating JavaScript Libraries into R for Dynamic Visualizations

### SORTEE Webinar Series, May 2023

JavaScript, a programming language used to create dynamic web page content, is becoming an increasingly popular data science tool for building interactive data visualizations. However, learning an entirely new programming language can be time prohibitive and unrealistic for many researchers. Lucky for R users, there’s an app (well, R packages) for that!

In this hands-on live-coding workshop, we’ll explore the `{DT}`, `{plotly}`, and `{leaflet}` packages, which make JavaScript libraries more accessible for R-users looking to infuse their static visualizations with interactivity. Together, we’ll build an interactive table, plot, and map, and demonstrate how these outputs can be shared using open data science communication tools, like RMarkdown and Quarto.

### **Materials:**  
- [Google Slides](https://docs.google.com/presentation/d/1F5wKhd_8nX2x3dMvxZM5sE-pPPDgrQAKkFC4KGlE8jw/edit?usp=sharing)

### **Setup Instructions:**
1. Be sure to have the following R packages installed/updated:
```
# install packages individually
install.packages("here")
install.packages("tidyverse")
install.packages("DT")
install.packages("plotly")
install.packages("leaflet")

# or all install packages all at once
install.packages(pkgs = c("here", "tidyverse", "DT", "plotly", "leaflet"))
```
2. Fork and clone this GitHub repository [link here] OR if you aren't using GitHub, setup an R project [provide step-by-step instructions for each of these options]
