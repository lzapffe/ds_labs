
# Linn Zapffe, 24/02/2025
# This code will make a data frame with the URLs we will need to iterate over with our function from 02-scrape-page-function. Then we will use this 

# Load libraries
# To deal with tables better
library(tidyverse)
# To scrape html pages
library(rvest)
# To glue strings together
library(glue)

# Defining a root html to add the specific page information to
root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
# Creating a sequence of the page numbers, by 10s
numbers <- seq(from = 10, to = 70, by = 10)
# numbers <- seq(from = 0, to = 2909, by = 10)
# Creating all the URL variations for the pages
urls <- glue("{root}{numbers}")
# Pasting the root URL and number to get a vector with the individual URLs
urls_test <- paste0(root, numbers)
# Mapping over the URLs and scraping them, using the scrape_page function we defined in 02-scrape-page-function
uoe_art <- map_dfr(urls, scrape_page)
uoe_art <- map_dfr(urls_test, scrape_page)

urls_test[1] <- trimws(urls_test[1])
urls_test[1] <- gsub(">$", "", urls_test[1])

mapply()

write_csv(url_df, path = "data/url_df.csv")