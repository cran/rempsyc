## ----global_options, include=FALSE--------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 8, fig.height = 7, warning = FALSE,
  message = FALSE, out.width = "70%"
)
knitr::opts_knit$set(root.dir = tempdir())

pkgs <- c("ggplot2")
successfully_loaded <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1L), quietly = TRUE)
can_evaluate <- all(successfully_loaded)

if (can_evaluate) {
  knitr::opts_chunk$set(eval = TRUE)
  vapply(pkgs, require, FUN.VALUE = logical(1L), quietly = TRUE, character.only = TRUE)
} else {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
data("mtcars")
head(mtcars)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
install_if_not_installed("ggplot2")

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg"
)

## ---- eval = FALSE------------------------------------------------------------
#  ### Save a high-resolution image file to specified directory
#  ggplot2::ggsave("nice_scatterplothere.pdf",
#    width = 7, height = 7,
#    unit = "in", dpi = 300
#  )
#  # Change the path to where you would like to save it.
#  # If you copy-paste your path name, remember to
#  # use "R" slashes ('/' rather than '\').
#  # Also remember to specify the .tiff extension of the file.

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  ytitle = "Miles/(US) gallon",
  xtitle = "Weight (1000 lbs)"
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.jitter = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  alpha = 1
) # default is 0.7

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.points = FALSE,
  has.jitter = FALSE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.confband = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  xmin = 1,
  xmax = 6,
  xby = 1,
  ymin = 10,
  ymax = 35,
  yby = 5
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  colours = "blueviolet"
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.r = TRUE,
  has.p = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.r = TRUE,
  r.x = 4,
  r.y = 25,
  has.p = TRUE,
  p.x = 5,
  p.y = 20
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl"
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  has.fullrange = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  groups.order = c(8, 4, 6)
)
# These are the levels of 'mtcars$cyl', so we place lvl 8
# first, then lvl 4, etc.

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  groups.labels = c("Weak", "Average", "Powerful")
)
# Warning: This applies after changing order of level

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  legend.title = "Cylinders"
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  colours = c("burlywood", "darkgoldenrod", "chocolate")
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  has.linetype = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  has.shape = TRUE
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  group = "cyl",
  legend.title = "Cylinders",
  has.linetype = TRUE,
  has.shape = TRUE,
  colours = rep("black", 3)
)

## -----------------------------------------------------------------------------
nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  ytitle = "Miles/(US) gallon",
  xtitle = "Weight (1000 lbs)",
  has.points = FALSE,
  has.jitter = TRUE,
  alpha = 1,
  has.confband = TRUE,
  has.fullrange = FALSE,
  group = "cyl",
  has.linetype = TRUE,
  has.shape = TRUE,
  xmin = 1,
  xmax = 6,
  xby = 1,
  ymin = 10,
  ymax = 35,
  yby = 5,
  has.r = TRUE,
  has.p = TRUE,
  r.x = 5.5,
  r.y = 25,
  colours = c("burlywood", "darkgoldenrod", "chocolate"),
  legend.title = "Cylinders",
  groups.labels = c("Weak", "Average", "Powerful")
)

## -----------------------------------------------------------------------------
# This simply copies the 'mtcars' dataset
new.Data <- mtcars
# That would be your "Group" variable normally
# And this operation fills all cells of that column with the word
# "Average" to identify our new 'group'
new.Data$cyl <- "Average"
# This adds the new "Average" group rows to the original data rows
XData <- rbind(mtcars, new.Data)

## -----------------------------------------------------------------------------
(p <- nice_scatter(
  data = XData,
  predictor = "wt",
  response = "mpg",
  has.points = FALSE,
  group = "cyl",
  colours = c("black", "#00BA38", "#619CFF", "#F8766D"),
  # We add colours manually because we want average to be black to stand out
  groups.order = c("Average", "4", "6", "8"),
  # We do this to have average on top since it's the most important
  groups.alpha = c(1, 0.5, 0.5, 0.5)
))
# This adds 50% transparency to all lines except
# the first one (Average) which is 100%

## -----------------------------------------------------------------------------
library(ggplot2)
p + geom_point(
  data = mtcars,
  size = 2,
  alpha = 0.5,
  shape = 16,
  # We use shape 16 because the default shape 19 sometimes
  # causes problems when exporting to PDF
  mapping = aes(
    x = wt,
    y = mpg,
    colour = factor(cyl),
    fill = factor(cyl)
  )
)

## -----------------------------------------------------------------------------
(p <- nice_scatter(
  data = mtcars,
  predictor = "wt",
  response = "mpg",
  has.points = FALSE,
  has.legend = TRUE,
  # Important argument! Else the next legend won't appear on the second layer!
  colours = "black"
))

## -----------------------------------------------------------------------------
p + geom_point(
  data = mtcars,
  size = 2,
  alpha = 0.5,
  shape = 16,
  mapping = aes(
    x = wt,
    y = mpg,
    colour = factor(cyl)
  )
)

