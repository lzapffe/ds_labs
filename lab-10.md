Lab 10 - Grading the professor, Pt. 2
================
Linn Zapffe
19/03/2025

### Load packages and data

``` r
library(tidyverse) 
```

    ## Warning: package 'ggplot2' was built under R version 4.3.3

    ## Warning: package 'tidyr' was built under R version 4.3.3

    ## Warning: package 'readr' was built under R version 4.3.3

    ## Warning: package 'purrr' was built under R version 4.3.3

    ## Warning: package 'lubridate' was built under R version 4.3.3

``` r
library(tidymodels)
```

    ## Warning: package 'tidymodels' was built under R version 4.3.3

    ## Warning: package 'broom' was built under R version 4.3.3

    ## Warning: package 'dials' was built under R version 4.3.3

    ## Warning: package 'infer' was built under R version 4.3.3

    ## Warning: package 'modeldata' was built under R version 4.3.3

    ## Warning: package 'parsnip' was built under R version 4.3.3

    ## Warning: package 'recipes' was built under R version 4.3.3

    ## Warning: package 'rsample' was built under R version 4.3.3

    ## Warning: package 'tune' was built under R version 4.3.3

    ## Warning: package 'workflows' was built under R version 4.3.3

    ## Warning: package 'workflowsets' was built under R version 4.3.3

    ## Warning: package 'yardstick' was built under R version 4.3.3

``` r
library(openintro)
```

    ## Warning: package 'openintro' was built under R version 4.3.3

    ## Warning: package 'airports' was built under R version 4.3.3

    ## Warning: package 'cherryblossom' was built under R version 4.3.3

    ## Warning: package 'usdata' was built under R version 4.3.3

### Exercise 1

Fitting a linear model between professor rating and beauty score:

``` r
m_bty <- lm(score ~ bty_avg, data = evals)
m_bty
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg, data = evals)
    ## 
    ## Coefficients:
    ## (Intercept)      bty_avg  
    ##     3.88034      0.06664

The linear model is teacher rating = 3.88 + 0.067 \* beauty rating.

``` r
summary(m_bty)
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg, data = evals)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.9246 -0.3690  0.1420  0.3977  0.9309 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  3.88034    0.07614   50.96  < 2e-16 ***
    ## bty_avg      0.06664    0.01629    4.09 5.08e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5348 on 461 degrees of freedom
    ## Multiple R-squared:  0.03502,    Adjusted R-squared:  0.03293 
    ## F-statistic: 16.73 on 1 and 461 DF,  p-value: 5.083e-05

The R^2 is .035 and the adjusted R^2 is .033. So 3.5 or 3.3% of the
variance in professor rankings is explained by beauty scores.

### Exercise 2

Fitting a linear model between professor rating and beauty score +
gender:

``` r
m_bty_gen <- lm(score ~ bty_avg + gender, data = evals)
m_bty_gen
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + gender, data = evals)
    ## 
    ## Coefficients:
    ## (Intercept)      bty_avg   gendermale  
    ##     3.74734      0.07416      0.17239

The model is professor rankings = 3.75 + 0.074 \* beauty ranking + 0.17
(if the professor is male).

``` r
summary(m_bty_gen)
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + gender, data = evals)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.8305 -0.3625  0.1055  0.4213  0.9314 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  3.74734    0.08466  44.266  < 2e-16 ***
    ## bty_avg      0.07416    0.01625   4.563 6.48e-06 ***
    ## gendermale   0.17239    0.05022   3.433 0.000652 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5287 on 460 degrees of freedom
    ## Multiple R-squared:  0.05912,    Adjusted R-squared:  0.05503 
    ## F-statistic: 14.45 on 2 and 460 DF,  p-value: 8.177e-07

The R^2 is .059 and the adjusted R^2 is .055. So 5.9 or 5.5% of the
variance in professor rankings is explained by beauty scores and the
professors’ gender.

## Exercise 3

I didn’t fit this model with an interaction, so I will fit another model
with the interaction.

Fitting a linear model between professor rating and beauty score +
gender, with an interaction:

``` r
m_bty_gen_int <- lm(score ~ bty_avg + gender + bty_avg*gender, data = evals)
m_bty_gen_int
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + gender + bty_avg * gender, data = evals)
    ## 
    ## Coefficients:
    ##        (Intercept)             bty_avg          gendermale  bty_avg:gendermale  
    ##            3.95006             0.03064            -0.18351             0.07962

The slope is in this case the professor ranking if they have a beauty
score of 0 and are female. The interaction is how much more of a boost
in ranking the professor gets for each additional beauty score because
they are male (so in addition to the 0.031 boost per beauty score).

## Exercise 4

``` r
summary(m_bty_gen_int)
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + gender + bty_avg * gender, data = evals)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.8084 -0.3828  0.0903  0.4037  0.9211 
    ## 
    ## Coefficients:
    ##                    Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)         3.95006    0.11800  33.475   <2e-16 ***
    ## bty_avg             0.03064    0.02400   1.277   0.2024    
    ## gendermale         -0.18351    0.15349  -1.196   0.2325    
    ## bty_avg:gendermale  0.07962    0.03247   2.452   0.0146 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5258 on 459 degrees of freedom
    ## Multiple R-squared:  0.07129,    Adjusted R-squared:  0.06522 
    ## F-statistic: 11.74 on 3 and 459 DF,  p-value: 1.997e-07

According to our R^2 value, 7.1% of the variance in professor rankings
are explained by our model: beauty scores, gender, and the interaction
between beauty scores and gender. If we use the adjusted R^2, it is
6.5%.

## Exercise 5

The professor rankings of male professors is:

professor rankings = 3.95 + 0.031 \* beauty ranking - 0.18 (if the
professor is male) + 0.080 per beauty ranking if professor is male.

THIS QUESTION IS NOT FINISHED
