Lab 08 - University of Edinburgh Art Collection
================
Linn Zapffe
21/02/2025

### Load packages and data

``` r
# Library for plots, data handling, and web scraping
library(tidyverse) 
library(skimr)
```

    ## Warning: package 'skimr' was built under R version 4.3.3

``` r
# Library to check access to the web page URL through web scraping
library(robotstxt)
```

    ## Warning: package 'robotstxt' was built under R version 4.3.3

Checking that we have access to web scrape from the web page with the
data:

``` r
paths_allowed("https://collections.ed.ac.uk/art)")
```

    ##  collections.ed.ac.uk

    ## [1] TRUE

As seen, we have access to web scrape from the web page, so we can move
forward with out project.

``` r
# Remove eval = FALSE or set it to TRUE once data is ready to be loaded
uoe_art <- read_csv("data/uoe-art.csv")
```

### Exercise 9

``` r
uoe_art <- uoe_art %>%
  separate(title, into = c("title", "date"), sep = "\\(") %>%
  mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
  select(title, artist, year, ___)
```

    ## Error in parse(text = input): <text>:4:32: unexpected input
    ## 3:   mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
    ## 4:   select(title, artist, year, __
    ##                                   ^

### Exercise 10

Remove this text, and add your answer for Exercise 10 here. Add code
chunks as needed. Don’t forget to label your code chunk. Do not use
spaces in code chunk labels.

### Exercise 11

…

Add exercise headings as needed.
