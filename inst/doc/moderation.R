## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 5, fig.height = 3, warning = FALSE, 
                      message = FALSE, out.width = "70%")
knitr::opts_knit$set(root.dir = tempdir())

## -----------------------------------------------------------------------------
head(mtcars)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
mtcars2 <- lapply(mtcars, scale) |> as.data.frame()

## -----------------------------------------------------------------------------
moderations <- nice_mod(
  data = mtcars2,
  response = "mpg",
  predictor = "gear",
  moderator = "wt")
moderations

## -----------------------------------------------------------------------------
(my_table <- nice_table(moderations, highlight = TRUE))

## ---- eval = FALSE------------------------------------------------------------
#  flextable::save_as_docx(my_table, path = "moderations.docx")

## -----------------------------------------------------------------------------
slopes <- nice_slopes(
  data = mtcars2,
  response = "mpg",
  predictor = "gear",
  moderator = "wt")
slopes
nice_table(slopes, highlight = TRUE)

## -----------------------------------------------------------------------------
# Moderations
nice_mod(data = mtcars2,
         response = c("mpg", "disp", "hp"),
         predictor = "gear",
         moderator = "wt") |>
  nice_table(highlight = TRUE)

# Simple slopes
nice_slopes(data = mtcars2,
            response = c("mpg", "disp", "hp"),
            predictor = "gear",
            moderator = "wt") |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
nice_mod(data = mtcars2,
         response = "mpg",
         predictor = "gear",
         moderator = "wt",
         covariates = c("am", "vs")) |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
nice_slopes(data = mtcars2,
            response = "mpg",
            predictor = "gear",
            moderator = "wt",
            covariates = c("am", "vs")) |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
# First need to define model for plot function
mod <- lm(mpg ~ gear * wt + am + vs, data = mtcars2)

# Plot the model
library(interactions)
interact_plot(mod, pred = "gear", modx = "wt", interval = TRUE)

## -----------------------------------------------------------------------------
mtcars2$am <- mtcars$am

## -----------------------------------------------------------------------------
nice_mod(response = "mpg",
         predictor = "gear",
         moderator = "disp",
         moderator2 = "am",
         data = mtcars2) |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
nice_slopes(data = mtcars2,
            response = "mpg",
            predictor = "gear",
            moderator = "disp",
            moderator2 = "am") |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
model1 <- lm(mpg ~ cyl + wt * hp, mtcars2)
model2 <- lm(qsec ~ disp + drat * carb, mtcars2)
my.models <- list(model1, model2)
nice_lm(my.models) |> 
  nice_table(highlight = TRUE)

## -----------------------------------------------------------------------------
model1 <- lm(mpg ~ gear * wt, mtcars2)
model2 <- lm(disp ~ gear * wt, mtcars2)
my.models <- list(model1, model2)
nice_lm_slopes(my.models, predictor = "gear", moderator = "wt") |> 
  nice_table(highlight = TRUE)

