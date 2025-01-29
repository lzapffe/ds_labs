Lab 04 - La Quinta is Spanish for next to Denny’s, Pt. 1
================
Linn Zapffe
29/1/2025

### Load packages and data

``` r
# Ran this code and then commented it out so that it isn't re-run everytime this document is knitted
#install.packages("devtools")
#devtools::install_github("rstudio-education/dsbox")
```

``` r
library(tidyverse) 
library(dsbox) 
```

``` r
states <- read_csv("data/states.csv")
```

### Exercise 1

The dimensions of the Denny’s data set are 1643 rows and 6 columns. Each
row is a Denny’s location and the 6 variables are: address, city, state,
zip, longitude, latitude.

### Exercise 2

The dimensions of the La Quinta data set are 909 rows and 6 columns.
Each row is a La Quinta location and the 6 variables are: address, city,
state, zip, longitude, latitude. These variables are the same as for the
Denny’s locations data set.

### Exercise 3

Whether there are any Denny’s locations outside of the US depends on the
definition. Isn’t Texas its own country? If not, then there are no
Denny’s outside of the US.

La Quinta has locations all over the world, even though most of them are
in the US. The countries are Canada, Mexico, China, New Zealand, Turkey,
United Arab Emirates, Chile, Columbia, and Equador.

### Exercise 4

I would assume the state would be missing if the location is outside of
the US, so I would filter on state being missing.

### Exercise 5

``` r
dennys %>%
  filter(!(state %in% states$abbreviation))
```

    ## # A tibble: 0 × 6
    ## # ℹ 6 variables: address <chr>, city <chr>, state <chr>, zip <chr>,
    ## #   longitude <dbl>, latitude <dbl>

There are no Denny’s locations outside of the US.

### Exercise 6

``` r
dennys <- dennys %>%
  mutate(country = "United States")
```

### Exercise 7

``` r
laquinta %>%
  filter(!(state %in% states$abbreviation))
```

    ## # A tibble: 14 × 6
    ##    address                                  city  state zip   longitude latitude
    ##    <chr>                                    <chr> <chr> <chr>     <dbl>    <dbl>
    ##  1 Carretera Panamericana Sur KM 12         "\nA… AG    20345    -102.     21.8 
    ##  2 Av. Tulum Mza. 14 S.M. 4 Lote 2          "\nC… QR    77500     -86.8    21.2 
    ##  3 Ejercito Nacional 8211                   "Col… CH    32528    -106.     31.7 
    ##  4 Blvd. Aeropuerto 4001                    "Par… NL    66600    -100.     25.8 
    ##  5 Carrera 38 # 26-13 Avenida las Palmas c… "\nM… ANT   0500…     -75.6     6.22
    ##  6 AV. PINO SUAREZ No. 1001                 "Col… NL    64000    -100.     25.7 
    ##  7 Av. Fidel Velazquez #3000 Col. Central   "\nM… NL    64190    -100.     25.7 
    ##  8 63 King Street East                      "\nO… ON    L1H1…     -78.9    43.9 
    ##  9 Calle Las Torres-1 Colonia Reforma       "\nP… VE    93210     -97.4    20.6 
    ## 10 Blvd. Audi N. 3 Ciudad Modelo            "\nS… PU    75010     -97.8    19.2 
    ## 11 Ave. Zeta del Cochero No 407             "Col… PU    72810     -98.2    19.0 
    ## 12 Av. Benito Juarez 1230 B (Carretera 57)… "\nS… SL    78399    -101.     22.1 
    ## 13 Blvd. Fuerza Armadas                     "con… FM    11101     -87.2    14.1 
    ## 14 8640 Alexandra Rd                        "\nR… BC    V6X1…    -123.     49.2

The countries were listed already in question 3, see for reference.

### Exercise 8

``` r
laquinta <- laquinta %>%
  mutate(country = case_when(
    state %in% state.abb ~ "United States",
    state %in% c("ON", "BC") ~ "Canada",
    state == "ANT" ~ "Colombia",
    state %in% c("AG", "QR", "CH", "NL", "VE", "PU", "SL") ~ "Mexico",
    state == "FM" ~ "Honduras"
  ))
```

This countries I found by Googling did not seem to be the same as from
the La Quinta webpage. There was no Honduras on the webpage and there
are a lot of countries on the webpage missing in the data set. My best
guess is that the data set is older than the webpage and not updated
with all the current locations.

``` r
laquinta <- laquinta %>%
  filter(country == "United States")
```

### Exercise 9
