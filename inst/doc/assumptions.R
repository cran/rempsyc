## ----include=FALSE------------------------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 8, fig.height = 7, warning = FALSE,
  message = FALSE, out.width = "70%"
)

pkgs <- c(
  "rlang", "flextable", "performance", "see", "lmtest",
  "ggplot2", "qqplotr", "ggrepel", "patchwork", "boot"
)
successfully_loaded <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1L), quietly = TRUE)
can_evaluate <- all(successfully_loaded)

if (can_evaluate) {
  knitr::opts_chunk$set(eval = TRUE)
  vapply(pkgs, require, FUN.VALUE = logical(1L), quietly = TRUE, character.only = TRUE)
} else {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
# Load necessary libraries
library(performance)
library(see)
# Note: if you haven't installed the packages above,
# you'll need to install them first by using:
# install_if_not_installed(c("performance", "see"))

# Create a regression model (using data available in R by default)
model <- lm(mpg ~ wt * cyl + gear, data = mtcars)

## ----out.width="90%"----------------------------------------------------------
# Check model assumptions
check_model(model)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
pkgs <- c(
  "flextable", "performance", "see", "lmtest", "ggplot2",
  "qqplotr", "ggrepel", "patchwork", "boot"
)
install_if_not_installed(pkgs)

## ----eval = FALSE-------------------------------------------------------------
# View(nice_assumptions(model))

## -----------------------------------------------------------------------------
nice_table(nice_assumptions(model), col.format.p = 2:4)

## -----------------------------------------------------------------------------
# Define our dependent variables
DV <- names(mtcars[-1])
# Make list of all formulas
formulas <- paste(DV, "~ mpg")
# Make list of all models
models.list <- lapply(X = formulas, FUN = lm, data = mtcars)
# Make diagnostic table
assumptions.table <- nice_assumptions(models.list)

## ----eval = FALSE-------------------------------------------------------------
# View(assumptions.table)

## -----------------------------------------------------------------------------
nice_table(assumptions.table, col.format.p = 2:4)

## -----------------------------------------------------------------------------
nice_qq(
  data = iris,
  variable = "Sepal.Length",
  group = "Species"
)

## -----------------------------------------------------------------------------
nice_qq(
  data = iris,
  variable = "Sepal.Length",
  group = "Species",
  colours = c("#00BA38", "#619CFF", "#F8766D"),
  groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica"),
  grid = FALSE,
  shapiro = TRUE,
  title = NULL
)

## -----------------------------------------------------------------------------
nice_density(
  data = iris,
  variable = "Sepal.Length",
  group = "Species"
)

## -----------------------------------------------------------------------------
nice_density(
  data = iris,
  variable = "Sepal.Length",
  group = "Species",
  colours = c("#00BA38", "#619CFF", "#F8766D"),
  xtitle = "Sepal Length",
  ytitle = "Density (vs. Normal Distribution)",
  groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica"),
  grid = FALSE,
  shapiro = TRUE,
  histogram = TRUE,
  title = "Density (Sepal Length)"
)

## ----fig.width=12, fig.height=7, out.width="100%"-----------------------------
nice_normality(
  data = iris,
  variable = "Sepal.Length",
  group = "Species",
  shapiro = TRUE,
  histogram = TRUE,
  title = "Density (Sepal Length)"
)

## -----------------------------------------------------------------------------
plot_outliers(
  airquality,
  group = "Month",
  response = "Ozone"
)

## -----------------------------------------------------------------------------
plot_outliers(
  airquality,
  response = "Ozone"
)

## -----------------------------------------------------------------------------
plot_outliers(
  airquality,
  group = "Month",
  response = "Ozone",
  method = "sd",
  criteria = 3.29,
  colours = c("white", "black", "purple", "grey", "pink"),
  ytitle = "Ozone",
  xtitle = "Month of the Year"
)

## -----------------------------------------------------------------------------
find_mad(airquality, names(airquality), criteria = 3)

## -----------------------------------------------------------------------------
winsorize_mad(airquality$Ozone, criteria = 3) |>
  head(30)

## -----------------------------------------------------------------------------
check_outliers(na.omit(airquality), method = "mcd")

## ----eval = FALSE-------------------------------------------------------------
# View(nice_var(
#   data = iris,
#   variable = "Sepal.Length",
#   group = "Species"
# ))

## -----------------------------------------------------------------------------
# Define our dependent variables
DV <- names(iris[1:4])

# Make diagnostic table
var.table <- nice_var(
  data = iris,
  variable = DV,
  group = "Species"
)

## ----eval = FALSE-------------------------------------------------------------
# View(var.table)

## -----------------------------------------------------------------------------
nice_varplot(
  data = iris,
  variable = "Sepal.Length",
  group = "Species"
)

## -----------------------------------------------------------------------------
nice_varplot(
  data = iris,
  variable = "Sepal.Length",
  group = "Species",
  colours = c("#00BA38", "#619CFF", "#F8766D"),
  ytitle = "Sepal Length",
  groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica")
)

