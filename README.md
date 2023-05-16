# Integrating JavaScript Libraries into R for Dynamic Visualizations

## SORTEE Webinar Series, May 2023

JavaScript, a programming language used to create dynamic web page content, is becoming an increasingly popular data science tool for building interactive data visualizations. However, learning an entirely new programming language can be time prohibitive and unrealistic for many researchers. Lucky for R users, there’s an app (well, R packages) for that!

In this hands-on live-coding workshop, we’ll explore the `{DT}`, `{plotly}`, and `{leaflet}` packages, which make JavaScript libraries more accessible for R-users looking to infuse their static visualizations with interactivity. Together, we’ll build an interactive table, plot, and map, and demonstrate how these outputs can be shared using open data science communication tools, like RMarkdown and Quarto.

## **What's in this repo?**

All the files you need for following along with the live-coding exercises, plus a few you don't need to worry about. Here's a roadmap:

```
.
├── data/                           # data files
│   └── lobsters.rds                # the pre-processed data we'll we using  
|
├── example-reports/                # ficticous reports with embedded interactive objects
|   └── report-qmd.qmd                  # report created using a Quarto Markdown file (`.qmd`)
|   └── report-rmd.rmd                  # report created using an R Markdown file (`.rmd`)
|
├── keys/                           # keys, to follow along with if you get lost or want to spend some more time with the material! pick whichever file format you're using to write your code in
|   └── workshop-KEY.qmd            # for the Quarto users
|   └── workshop-KEY.rmd            # for the R Markdown users
|   └── workshop-KEY.r              # for the R script users
|     
├── lib/                            # JS libraries that are loaded when using R??
|   
├── media/                          # images
│   └── lobster.png                 # lobster image used to create leaflet map markers
|
├── old/                            # [DELETE THIS LATER]
│   
├── outputs/                        # saved JS objects live here
│   └── dt.html                     # DT table
│   └── leaflet.html                # leaflet map 
│   └── plotly.html                 # plotly boxplot
|
├── planning-scripts/               # Sam & An's "scratch paper" -- we won't be using these in the workshop
│  
├── templates/                      # WRITE YOUR CODE HERE! feel free use whichever file format you're most comfortable with (they are all set up similarly), and reference the corresponding KEY in the `/keys` folder
|   └── workshop-TEMPLATE.qmd       # for the Quarto users
|   └── workshop-TEMPLATE.rmd       # for the R Markdown users
|   └── workshop-TEMPLATE.r         # for the R script users
 
```

## **Setup Instructions:**
1. Be sure to have the following R packages installed/updated:

```
# install packages individually
install.packages("here")
install.packages("tidyverse")
install.packages("DT")
install.packages("plotly")
install.packages("leaflet")
install.packages("leaflet.extras")

# or all install packages all at once
install.packages(pkgs = c("here", "tidyverse", "DT", "plotly", "leaflet", "leaflet.extras"))
```

2. Fork and clone this GitHub repository OR if you aren't using GitHub, download the repository to work locally. Find detailed instructions for both options on [our wiki](https://github.com/samanthacsik/SORTEE-May2023/wiki): 

- [Instructions for forking & cloning a GitHub repo](https://github.com/samanthacsik/SORTEE-May2023/wiki/Forking-&-cloning-a-GitHub-repo)
- [Intructions for downloading the repository to work locally](https://github.com/samanthacsik/SORTEE-May2023/wiki/Download-the-GitHub-repository-to-work-locally)

3. (OPTIONAL) If you'd like to use [Quarto](https://quarto.org/), you'll want to make sure that you have RStudio v2022.07.1+ installed. Choose **Help > Check for Updates** from the menu bar to update RStudio (it'll open a browser window where you can download the latest version). Quarto *should* be automatically installed with the RStudio update, but if not, download it [here](https://quarto.org/docs/get-started/) and install separately. Quarto is installed as a directory (i.e. folder) of files on your machine (within the **Applications** folder on a Mac, or likely within **Program Files** on a PC -- though you may specify the Destination Folder using the setup wizard). **Note:** Quarto is neither an application nor an R package, but rather a command-line interface (CLI) -- however, you *do not* need to be familiar with the command line to use it's awesome features (RStudio provides the graphical user interface, e.g. buttons)! 

## **Additional Materials:**  
- [Google Slides](https://docs.google.com/presentation/d/1F5wKhd_8nX2x3dMvxZM5sE-pPPDgrQAKkFC4KGlE8jw/edit?usp=sharing)
- [Workshop reference code](https://samanthacsik.github.io/SORTEE-May2023/) 


