
# Linn Zapffe, 21/02/2025

# This script will take the code from 01-scrape-page-one and make it into a function that can later be called by other scripts.

scrape_page <- function(url) {
  
  # Saving the html object of the overview page with all the art works in the variable "page"
  page <- read_html(url)
  
  # Saving the titles of the works from the page
  title_vect <- page %>%
    html_nodes(".record-title a") %>%
    html_text() %>%
    str_squish()
  
  # Scraping the URLs from the page
  url_vect <- page %>%
    html_nodes(".record-title a") %>%
    html_attr("href") %>%
    str_replace(".", "https://collections.ed.ac.uk/art")
  
  # Scraping the artist names from the web page
  artist_vect <- page %>%
    html_nodes(".iteminfo") %>%
    html_node(".artist") %>%
    html_text()
  
  # Organizing everything as a tibble
  tibble(title_vect, artist_vect, url_vect)
}

# Tested out the function with the following code and compared it to what I got from the 01-scrape-page-one script. The output was the same, so it seems like the function works the way it is supposed to
  # Attaching the code to check, commented out, for reference
    #second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"
    #scrape_page(second_url)