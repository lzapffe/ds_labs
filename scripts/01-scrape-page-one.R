
# Linn Zapffe, 21/02/2025
# This script belongs to lab 5 and will web scrape the first two page on the art collection webpage. This code will then later be used to scale up and create a function to scrape all the pages.

# Loading libraries for data handling
library(tidyverse)
# rvest isn't a part of the core Tidyverse universe, so it needs to be loaded separately
library(rvest)

# Saving the first URL
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# Saving the html object of the overview page with all the art works in the variable "page"
page <- read_html(first_url)

# Using SelectorGadget, I found that the titles can be access with ".record-title a"
# Interestingly, this is different from what is in the lab itself, which says ".iteminfo"
# I'll try mine and see what happens, they could have updated the html tags/attributes on the webpage

# Scraping the art titles with my attribute
page %>%
  html_nodes(".record-title a")


# Scraping the art titles with the attributes from the lab
page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a")

# I get the same output with both methods. Mine seemed a little more concise, so I will stick with that

# Saving the titles of the works from page one
title_vect_p1 <- page %>%
  html_nodes(".record-title a") %>%
  html_text()

# There is a lot of white space in the strings. str_squish() can remove unecessary white space
title_vect_p1 <- title_vect_p1 %>%
  str_squish()

# That removed the uneccessary white spaces from the strings


## Getting the URLs ###############

# Scraping the urls from the first web page
url_vect_p1 <- page %>%
  html_nodes(".record-title a") %>%
  html_attr("href")

# The URLs are relative links, so we need to use str_replace() to add the parts that make it a full URL
# From looking at the actual URL of one of the webpages, it looks like we need to replace the "." with "https://collections.ed.ac.uk/art"

# Changing out the period with the base URL
url_vect_p1 <- url_vect_p1 %>%
  str_replace(".", "https://collections.ed.ac.uk/art")


## Getting the artist names ########################
artist_vect_p1 <- page %>%
  html_nodes(".artist") %>%
  html_text()


## Organizing everything as a tibble ##############
df_p1 <- tibble(title_vect_p1, artist_vect_p1, url_vect_p1)


## Doing it all again for page 2 #####################

# Saving the URL of the second page
second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

# Saving the html object of the overview page with all the art works in the variable "page"
page <- read_html(second_url)

# Saving the titles of the works from page two
title_vect_p2 <- page %>%
  html_nodes(".record-title a") %>%
  html_text() %>%
  str_squish()

# Scraping the urls from the second web page
url_vect_p2 <- page %>%
  html_nodes(".record-title a") %>%
  html_attr("href") %>%
  str_replace(".", "https://collections.ed.ac.uk/art")


# Scraping the artist names from the second web page
artist_vect_p2 <- page %>%
  html_nodes(".artist") %>%
  html_text()


## Organizing everything as a tibble ##############
df_p2 <- tibble(title_vect_p2, artist_vect_p2, url_vect_p2)

