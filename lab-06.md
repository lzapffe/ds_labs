Lab 06 - Ugly charts and Simpson’s paradox
================
Linn Zapffe
5/2/2025

### Load packages and data

``` r
library(tidyverse) 
library(dsbox)
library(mosaicData)
```

    ## Warning: package 'mosaicData' was built under R version 4.3.3

``` r
# To highlight certain lines in a graph
library(ggrepel)
```

    ## Warning: package 'ggrepel' was built under R version 4.3.3

## Instructional staff employment trends

### Exercise 1

``` r
staff <- read_csv("data/instructional-staff.csv")
```

    ## Rows: 5 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (1): faculty_type
    ## dbl (11): 1975, 1989, 1993, 1995, 1999, 2001, 2003, 2005, 2007, 2009, 2011
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
staff_long <- staff %>%
  pivot_longer(cols = -faculty_type, names_to = "year") %>%
  mutate(value = as.numeric(value))

staff_long
```

    ## # A tibble: 55 × 3
    ##    faculty_type              year  value
    ##    <chr>                     <chr> <dbl>
    ##  1 Full-Time Tenured Faculty 1975   29  
    ##  2 Full-Time Tenured Faculty 1989   27.6
    ##  3 Full-Time Tenured Faculty 1993   25  
    ##  4 Full-Time Tenured Faculty 1995   24.8
    ##  5 Full-Time Tenured Faculty 1999   21.8
    ##  6 Full-Time Tenured Faculty 2001   20.3
    ##  7 Full-Time Tenured Faculty 2003   19.3
    ##  8 Full-Time Tenured Faculty 2005   17.8
    ##  9 Full-Time Tenured Faculty 2007   17.2
    ## 10 Full-Time Tenured Faculty 2009   16.8
    ## # ℹ 45 more rows

Line graph of the data set:

``` r
staff_long %>%
  ggplot(aes(
    x = year,
    y = value,
    group = faculty_type,
    color = faculty_type
  )) +
  geom_line()
```

![](lab-06_files/figure-gfm/standard_line_plot-1.png)<!-- -->

### Exercise 2

Improving the above plot:

I tried first doing this without additional libraries. After getting
labels that overlapped, I gave up and used the library ggrepel. That
seems easier than to start adjusting labels individually.

``` r
staff_long %>%
  mutate(
    color_crit = case_when(
      faculty_type == "Part-Time Faculty" ~ "red",
      faculty_type %in% c("Full-Time Tenured Faculty", "Full-Time Tenure-Track Faculty", "Full-Time Non-Tenure-Track Faculty") ~ "darkblue",
      faculty_type == "Graduate Student Employees" ~ "grey"
    )
  ) %>%
  ggplot(aes(
    x = year,
    y = value,
    group = faculty_type,
    color = color_crit
  )) +
  geom_line(linewidth = 1) +
  scale_color_identity() +
  theme_minimal() +
  labs(
    title = "Percentage of Hires per Faculty Type over Time",
    x = "Year",
    y = "Proportion of hires",
    color = "Faculty type"
  ) +
  geom_label_repel(aes(label = if_else(year == 2003, faculty_type, "")))
```

![](lab-06_files/figure-gfm/staff_line_graph-1.png)<!-- -->

I am trying to highlight that there are more part-time faculty, and
fewer full-time faculty. Therefore, I chose to color the part-time
faculty as being red, to draw the viewer’s attention there. I colored
all the full-time positions as blue, because the distinction doesn’t
matter that much in this case and left graduate student employees grey
as that is not as important. I could also have collapsed the data for
all full-time faculty and removed that for part-time faculty.

### Exercise 3

Here are some thoughts about how to improve the Fisheries plot:

- Not using 3D for the plots, because it is distracting and harder to
  interpret (area vs surface)
- Not use pie charts, but instead bar charts, because we are better at
  interpreting surface than area
- Maybe change the scale of the y-axis of the filled-line plot, since I
  can’t see anything for most of the countries, since China is an
  extreme outlier. Alternatively, zoom in on the data with smaller
  values in China isn’t that important.
- Remove the background color for the pie charts, makes it harder to see
  contrast
- Add a legend to the filled-line graph. I don’t know what the two
  colors mean
- Add titles to the graphs
- Add a caption with the source of the data
- Remove shading from the pie chart, as that is only distracting
- Maybe add some texture in addition to the colors to make it more
  accessible and easier to read in grey scale printing. Alternatively,
  make colors that contrast more or add labels where the data is instead
  of having a legend.
- It is a little hard to know exactly what the graphs show, since it
  isn’t explained well. However, it seems like the filled-line graph and
  pie chart is showing the same information, which seems unnecessary. I
  might make both, but I would think only one of them would be needed.
- I would also test out flipping the axes for the filled-line graph,
  since it is a little hard to read the country names when they are
  tilted.
- Not have more colored area that countries. The pie charts have 6
  countries, but maybe 30 different sections. Are the country data
  divided into several categories? In that case, it should be collapsed
  into just one data point per country.

``` r
fisheries <- read_csv("data/fisheries.csv")
```

    ## Rows: 216 Columns: 4
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): country
    ## dbl (3): capture, aquaculture, total
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Looking at the data, there are way to many countries to graph.
Therefore, I will try seeing what the top countries are based on total
fishery production:

``` r
fisheries %>%
  arrange(desc(total))
```

    ## # A tibble: 216 × 4
    ##    country        capture aquaculture    total
    ##    <chr>            <dbl>       <dbl>    <dbl>
    ##  1 China         17800000    63700000 81500000
    ##  2 Indonesia      6584419    16600000 23184419
    ##  3 India          5082332     5703002 10785334
    ##  4 Vietnam        2785940     3634531  6420471
    ##  5 United States  4931017      444369  5375386
    ##  6 Russia         4773413      173840  4947253
    ##  7 Japan          3275263     1067994  4343257
    ##  8 Philippines    2027992     2200914  4228906
    ##  9 Peru           3811802      100187  3911989
    ## 10 Bangladesh     1674770     2203554  3878324
    ## # ℹ 206 more rows

I think top 10 countries might be good. There might be political reasons
to include other specific countries, but I don’t have any of those, so I
will stick with top 10.

``` r
fisheries_top_10 <- fisheries %>%
  slice_max(order_by = total, n = 10)
fisheries_top_10
```

    ## # A tibble: 10 × 4
    ##    country        capture aquaculture    total
    ##    <chr>            <dbl>       <dbl>    <dbl>
    ##  1 China         17800000    63700000 81500000
    ##  2 Indonesia      6584419    16600000 23184419
    ##  3 India          5082332     5703002 10785334
    ##  4 Vietnam        2785940     3634531  6420471
    ##  5 United States  4931017      444369  5375386
    ##  6 Russia         4773413      173840  4947253
    ##  7 Japan          3275263     1067994  4343257
    ##  8 Philippines    2027992     2200914  4228906
    ##  9 Peru           3811802      100187  3911989
    ## 10 Bangladesh     1674770     2203554  3878324

Making a bar graph:

``` r
fisheries_top_10 %>%
  mutate(total = total / 100000) %>%
  ggplot(aes(x = reorder(country, -total), y = total, fill = country)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    total = "Total Fish Harvest by Top 10 Countries",
    x = "Countries",
    y = "Total Harvest (in 100 000s)"
  ) +
  guides(fill = "none") +
  theme_minimal()
```

![](lab-06_files/figure-gfm/plot_fish_bar_graph-1.png)<!-- -->

It could also be interesting to see the distribution of fish captures
and harvested for each country in the bar graph. I will make that
version of the plot too.

``` r
# Make a new data set that is long instead of wide to make the capture and aquaculture variables one variable that can be stacked by
fisheries_top_10_long <- fisheries_top_10 %>%
  pivot_longer(cols = c(capture, aquaculture), names_to = "type", values_to = "tons_fish")

# Creating the stacked bar plot
fisheries_top_10_long %>%
  # Mutating to make the variable in 100 000s, so that the scale is more readable
  mutate(tons_fish = tons_fish / 100000) %>%
  ggplot(aes(x = reorder(country, -total), y = tons_fish, fill = type)) +
  geom_bar(stat = "identity", position = "stack") +
  coord_flip() +
  labs(
    total = "Total Fish Harvest by Top 10 Countries",
    x = "Countries",
    y = "Total Harvest (in 100 000s)"
  ) +
  theme_minimal()
```

![](lab-06_files/figure-gfm/dist_fish_bar_graph-1.png)<!-- -->

### Exercise 4

``` r
data(Whickham)
```

#### Question 1

I think the data comes from an observational study, because they are
looking at smoking and survival rate. It would hard to design an ethical
study where some people will smoke regularly and others won’t, so it is
most like observational.

#### Question 2
