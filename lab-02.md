Lab 02 - Plastic waste
================
Linn Zapffe
24/01/2025

## Load packages and data

``` r
library(tidyverse) 
```

``` r
plastic_waste <- read.csv("data/plastic-waste.csv")
```

## Exercises

### Exercise 1

Remove this text, and add your answer for Exercise 1 here.

``` r
ggplot(data = plastic_waste, mapping = aes(x = plastic_waste_per_cap)) +
  geom_histogram() +
  facet_wrap(~ continent)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 51 rows containing non-finite values (`stat_bin()`).

![](lab-02_files/figure-gfm/plastic-waste-continent-1.png)<!-- -->

``` r
ggplot(
  data = plastic_waste,
  aes(x = plastic_waste_per_cap)
) +
  geom_density()
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_density()`).

![](lab-02_files/figure-gfm/demon%201-1.png)<!-- -->

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = plastic_waste_per_cap,
    color = continent
  )
) +
  geom_density()
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_density()`).

![](lab-02_files/figure-gfm/demon%202-1.png)<!-- -->

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = plastic_waste_per_cap,
    color = continent,
    fill = continent
  )
) +
  geom_density()
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_density()`).

![](lab-02_files/figure-gfm/demon%203-1.png)<!-- -->

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = plastic_waste_per_cap,
    color = continent,
    fill = continent
  )
) +
  geom_density(alpha = 0.7)
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_density()`).

![](lab-02_files/figure-gfm/demon%204-1.png)<!-- -->

### Exercise 2

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = plastic_waste_per_cap,
    color = continent,
    fill = continent
  )
) +
  geom_density(alpha = 0.45)
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_density()`).

![](lab-02_files/figure-gfm/plastic-waste-density-1.png)<!-- -->

What we add to aes() is what variables we somehow want to divide up our
data by. So there is a difference for each instance. For example, an
axis with all possible scores or a color for each continent. The things
we add in the geom, such as alpha, is the same for all the data.

### Exercise 3

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = continent,
    y = plastic_waste_per_cap
  )
) +
  geom_boxplot()
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_boxplot()`).

![](lab-02_files/figure-gfm/demon%205-1.png)<!-- -->

Changing it to violin plots

``` r
ggplot(
  data = plastic_waste,
  mapping = aes(
    x = continent,
    y = plastic_waste_per_cap
  )
) +
  geom_violin()
```

    ## Warning: Removed 51 rows containing non-finite values (`stat_ydensity()`).

![](lab-02_files/figure-gfm/plastic-waste-violin-1.png)<!-- -->

It is a lot easier to see the distributions with the violing plots than
the box plots. With the box plots you have to interpret where the median
is relative to the interquartiles, while for the violin plots, it is
very easy to see whether there is more data for lower or higher values
just by looking at the shape of it. You also see “all” the scores in the
distribution and not just the 5 summary statistics.

### Exercise 4

Remove this text, and add your answer for Exercise 4 here.

``` r
ggplot(data = plastic_waste, mapping = aes(x = plastic_waste_per_cap, y = mismanaged_plastic_waste_per_cap)) + 
  geom_point()
```

    ## Warning: Removed 51 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/plastic-waste-mismanaged-1.png)<!-- -->

There doesn’t seem to be that much of a relationship between plastic
waste per capita and mismanaged plastic waste capita. There is a weak
positive relationship. The relationship seems fairly consistent though.

``` r
ggplot(data = plastic_waste, mapping = aes(x = plastic_waste_per_cap, y = mismanaged_plastic_waste_per_cap, color = continent)) + 
  geom_point()
```

    ## Warning: Removed 51 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/plastic-waste-mismanaged-continent-1.png)<!-- -->

I don’t see any clear distinctions for this relationship based on
continent. Except for the fact that Africa has a very clear (but weak)
positive relationship. The other continents seem to have a relationship
that is a little less consistent.

``` r
ggplot(data = plastic_waste, mapping = aes(x = plastic_waste_per_cap, y = total_pop)) + 
  geom_point()
```

    ## Warning: Removed 61 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/plastic-waste-population-total-1.png)<!-- -->

``` r
ggplot(data = plastic_waste, mapping = aes(x = plastic_waste_per_cap, y = coastal_pop)) + 
  geom_point()
```

    ## Warning: Removed 51 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/plastic-waste-population-coastal-1.png)<!-- -->

The relationship for both of these graphs is still fairly weak. However,
there seems to be more of a relationship for coastal population, which
has more of a line, than total population, where most of the data is
centered for lower values of the total population and some centered at
higher values, but fewer in the middle of the relationship.

### Exercise 5

``` r
filter(plastic_waste, plastic_waste_per_cap < 3)

#plastic_waste %>% filter(plastic_waste_per_cap < 3)
```

I hid the output, since we don’t need 188 rows of data displayed.

``` r
library(viridis)
```

    ## Warning: package 'viridis' was built under R version 4.3.3

    ## Loading required package: viridisLite

``` r
plastic_waste$coastal_proportion <- plastic_waste$coastal_pop / plastic_waste$total_pop

plastic_waste %>% 
  filter(plastic_waste_per_cap < 3) %>%
    ggplot(mapping = aes(x = coastal_proportion, y = plastic_waste_per_cap)) +
      geom_point(mapping = aes(color = continent)) +
      geom_smooth(color = "black") +
    scale_color_viridis_d() +
    labs(title = "Plastic waste vs. coastal population proportion",
         subtitle = "by continent",
         x = "Coastal population proportion (Coastal / total population)", y = "Plastic waste per capita",
         color = "Continent") +
          theme_bw()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

    ## Warning: Removed 10 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 10 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/recreate-viz-1.png)<!-- -->

``` r
plastic_waste %>%
  mutate(coastal_pop_prop = coastal_pop / total_pop) %>%
  filter(plastic_waste_per_cap < 3) %>%
  ggplot(aes(
    x = coastal_pop_prop,
    y = plastic_waste_per_cap,
    color = continent
  )) +
  geom_point() +
  geom_smooth(color = "black") +
  scale_color_viridis_d() +
  labs(
    x = "Coastal population proportion (Coastal / total population)",
    y = "Plastic waste per capita ",
    color = "Continent",
    title = "Plastic waste vs. coastal population proportion",
    subtitle = "by continent"
  ) +
  theme_minimal()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

    ## Warning: Removed 10 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 10 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/answer%20from%20code-1.png)<!-- -->

Why can you put continent inside of aesthetics for ggplot, without
getting smooth properties for each continent, while when I try with
this, code, I get a line for each continent?

Apparently, it is because of the color = black part of geom_smooth(). I
don’t fully understand why that is the case. Wouldn’t color just make
the line following the data set black? See the two code blocks with
color = black and not in geom_smooth().

``` r
library(viridis)

plastic_waste$coastal_proportion <- plastic_waste$coastal_pop / plastic_waste$total_pop

plastic_waste %>% 
  filter(plastic_waste_per_cap < 3) %>%
    ggplot(mapping = aes(x = coastal_proportion, y = plastic_waste_per_cap, color = continent)) +
      geom_point() +
      geom_smooth(color = "black") +
    scale_color_viridis_d() +
    labs(title = "Plastic waste vs. coastal population proportion",
         subtitle = "by continent",
         x = "Coastal population proportion (Coastal / total population)", y = "Plastic waste per capita",
         color = "Continent") +
          theme_bw()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

    ## Warning: Removed 10 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 10 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/testing-1.png)<!-- -->

``` r
library(viridis)

plastic_waste$coastal_proportion <- plastic_waste$coastal_pop / plastic_waste$total_pop

plastic_waste %>% 
  filter(plastic_waste_per_cap < 3) %>%
    ggplot(mapping = aes(x = coastal_proportion, y = plastic_waste_per_cap, color = continent)) +
      geom_point() +
      geom_smooth() +
    scale_color_viridis_d() +
    labs(title = "Plastic waste vs. coastal population proportion",
         subtitle = "by continent",
         x = "Coastal population proportion (Coastal / total population)", y = "Plastic waste per capita",
         color = "Continent") +
          theme_bw()
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

    ## Warning: Removed 10 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 10 rows containing missing values (`geom_point()`).

![](lab-02_files/figure-gfm/testing%202-1.png)<!-- -->

Apart from this, it looks like the only difference is that I used
theme_bw instead of theme_minimal(). From what I can see,
theme_minimal() also makes the outline of the plot dissapear. The rest
looks identical.
