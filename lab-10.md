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

The equation if the professor is male is 3.95 + 0.031 \* beauty
ranking - 0.18 + 0.080 per beauty ranking if professor is male = 3.77 +
0.031 \* beauty ranking + 0.080 per beauty ranking if professor is male

## Exercise 6

For professors with the same beauty score, the males scores higher, as
they get a general penalty of -0.18 points, but also get 0.080
additional points for the ranking per beauty score. So unless the
professor in question get ranked as very low in beauty, male professors
will get a higher score than female professors with the same beauty
rankings

## Exercise 7

There is an interaction effect of + 0.080 for men, which means that
there is a stronger relationship between beauty scores and professor
rankings for male than female professors.

## Exercise 8

The R^2 for m_bty_gen_int is 0.071, while it is .035 for m_bty. The
model with beauty, gender and the interaction therefore seem to explain
twice the amount of variance in the professor rankings compared to the
model using just the beauty scores.

Gender (and its interaction with beauty scores) therefore seem to
explain an additional 0.036 of the variance in professor rankings.

## Exercise 9

The slope of beauty in the m_bty_gen_int model is 0.031, while it is
0.067 in m_bty. The addition of gender decreased the general slope, but
this would be if only considering female professors. If looking at male
professors, you would have to also look at the interaction, which adds
0.080 to the slope, giving a steeper slope for males in the
m_bty_gen_int model compared to m_bty.

## Exerxise 10

Fitting a linear model between professor rating and beauty score + rank,
with an interaction:

``` r
m_bty_rank_int <- lm(score ~ bty_avg + rank + bty_avg*rank, data = evals)
m_bty_rank_int
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + rank + bty_avg * rank, data = evals)
    ## 
    ## Coefficients:
    ##              (Intercept)                   bty_avg          ranktenure track  
    ##                  4.09811                   0.04171                  -0.01885  
    ##              ranktenured  bty_avg:ranktenure track       bty_avg:ranktenured  
    ##                 -0.40910                  -0.02640                   0.06586

The equation is professor ranking = 4.10 + 0.04 per beauty point - 0.02
if on tenure track - 0.41 if tenured - 0.03 if tenure track per beauty
point + 0.07 if tenured per beauty point.

The intercept is the professor ranking of a teaching professor that has
a beauty score of 0, which is 4.10.

The slope is how much better the rating get per beauty score for
teaching professors, which is 0.04.

If the professor is tenure track, they get a penalty of -0.02 to the
intercept and -0.03 to the slope (penalty per beauty score).

If the professor is tenured, they get a penalty of -0.41 to the
intercept and -0.07 to the slope (penalty per beauty score).

## Exercise 11

I think the worst predictor would be cls_profs, as I don’t think how
many professors are teaching the sections would have that much of an
impact on professor rankings. It might have some predictive power, but I
don’t think it would be much.

## Exercise 12

Fitting a linear model between professor rating and number of professors
teaching sections:

``` r
m_bty_num_prof <- lm(score ~ bty_avg + cls_profs, data = evals)
m_bty_num_prof
```

    ## 
    ## Call:
    ## lm(formula = score ~ bty_avg + cls_profs, data = evals)
    ## 
    ## Coefficients:
    ##     (Intercept)          bty_avg  cls_profssingle  
    ##         3.89116          0.06722         -0.03952

If the professor is the only one teaching sections in a course, the
professor ranking decreases by 0.04 points. This is not nothing, but not
a lot. There could be other predcitors that explain less variance in the
data set though.

## Exercise 13

If I am including cls_perc_eval and cls_students in my model, I would
not want to include cls_did_eval. This is because cls_perc_eval is the
percent of students completing the evaluation, whicl cls_students is the
number of students in the class. The product of these two variables
would be equal to the variable cls_did_eval. We therefore do not want to
include this variable as it would be perfectly related to the other two
variables and the predictive power of them would be masked as the
estimates only show unique predictive power.

## Exercise 14

Fitting a linear model between professor rating and all variables except
for cls_did_eval:

``` r
m_bty_all <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
m_bty_all
```

    ## 
    ## Call:
    ## lm(formula = score ~ rank + ethnicity + gender + language + age + 
    ##     cls_perc_eval + cls_students + cls_level + cls_profs + cls_credits + 
    ##     bty_avg, data = evals)
    ## 
    ## Coefficients:
    ##           (Intercept)       ranktenure track            ranktenured  
    ##             3.5305036             -0.1070121             -0.0450371  
    ## ethnicitynot minority             gendermale    languagenon-english  
    ##             0.1869649              0.1786166             -0.1268254  
    ##                   age          cls_perc_eval           cls_students  
    ##            -0.0066498              0.0056996              0.0004455  
    ##        cls_levelupper        cls_profssingle  cls_creditsone credit  
    ##             0.0187105             -0.0085751              0.5087427  
    ##               bty_avg  
    ##             0.0612651

Currently, it seems like the number of students in the class has the
lowest predictive power, with 0.0004 points to the rankings. This is a
little surprising, so before making this conclusion as a definite, I
would look into the relationship of this variables with others, such as
cls_level, as there could be some relationship between the cls_students
variable and other variable in the data set that decreases the estimate
for the cls_students predictor in the model.

## Exercise 15

Fitting a linear model between professor rating and all variables except
for cls_did_eval, then going backwards and removing variables:

``` r
m_bty_all_backwards <- lm(score ~ ethnicity + gender + language + cls_credits + bty_avg, data = evals)
summary(m_bty_all_backwards)
```

    ## 
    ## Call:
    ## lm(formula = score ~ ethnicity + gender + language + cls_credits + 
    ##     bty_avg, data = evals)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.85036 -0.32953  0.08822  0.38957  0.91810 
    ## 
    ## Coefficients:
    ##                       Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)            3.55590    0.10714  33.189  < 2e-16 ***
    ## ethnicitynot minority  0.17036    0.07543   2.259  0.02438 *  
    ## gendermale             0.14992    0.04898   3.061  0.00234 ** 
    ## languagenon-english   -0.16770    0.10484  -1.600  0.11040    
    ## cls_creditsone credit  0.56203    0.10589   5.308 1.74e-07 ***
    ## bty_avg                0.08208    0.01577   5.204 2.95e-07 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5111 on 457 degrees of freedom
    ## Multiple R-squared:  0.1265, Adjusted R-squared:  0.117 
    ## F-statistic: 13.24 on 5 and 457 DF,  p-value: 4.64e-12

Fitting a linear model between professor rating and all variables except
for cls_did_eval, then going backwards and removing variables::

``` r
m_bty_all_backwards <- lm(score ~ ethnicity + gender + cls_perc_eval + cls_credits + bty_avg, data = evals)
summary(m_bty_all_backwards)
```

    ## 
    ## Call:
    ## lm(formula = score ~ ethnicity + gender + cls_perc_eval + cls_credits + 
    ##     bty_avg, data = evals)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.8857 -0.3294  0.1066  0.3774  1.0540 
    ## 
    ## Coefficients:
    ##                       Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)           3.137381   0.146450  21.423  < 2e-16 ***
    ## ethnicitynot minority 0.233794   0.071275   3.280 0.001117 ** 
    ## gendermale            0.157832   0.048493   3.255 0.001219 ** 
    ## cls_perc_eval         0.005208   0.001443   3.608 0.000343 ***
    ## cls_creditsone credit 0.541067   0.104669   5.169 3.52e-07 ***
    ## bty_avg               0.073644   0.015773   4.669 3.98e-06 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5053 on 457 degrees of freedom
    ## Multiple R-squared:  0.146,  Adjusted R-squared:  0.1366 
    ## F-statistic: 15.62 on 5 and 457 DF,  p-value: 3.338e-14

I tried to approaches since my first one didn’t work that well.
Originally, I removed the predictors with the lowest estimates one by
one. Then next time, I removed then based on p-values, which worked
better. The second model explain 13.66% of the variance, while the first
explains 11.70% of the variance in professor rankings.

Professor rankings = 3.14 + 0.23 if professor is not an ethnic
minority + 0.16 if professor is male + 0.005 per percent of students
completed the evaulation 0.54 if class is one credit + 0.74 per beauty
score.

## Exercise 16

The slope for not being a minority is 0.233794, so if the professor is
not an ethnic minority, they get a boost in ranking of 0.23, while if
they are a minority, they do not get this boost.

The slope for bty_avg is 0.073, so for each additional beauty point, the
ranking increases by 0.073.

## Exercise 17

According to the final model, a professor would get a good ranking at
the University of Austin Texas if they are of not an ethnic minority,
male, and attractive, as well as if the class is one credit and has a
high percentage of students filling out the evaluations.

## Exercise 18

There is probably some truth to these characteristics and the rankings
professors get. However, there might also be some characteristics that
are more specific to the University of Austin Texas due to its location
and characteristics of the student body. There would maybe for example
not be as much of a difference in etnic minority status in an university
that has a larger percent of their student body that is an ethinc
minority themselves. I would therefore not generalize it to all other
universities, but rather instead consider it a general suggestion of
what seems to matter for professor rankings, which require more broad
data or data specific to the university of interest to draw more certain
conclusions.
