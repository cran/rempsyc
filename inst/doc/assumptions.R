## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(fig.width = 8, fig.height = 7, warning = FALSE, 
                      message = FALSE, out.width = "70%")

## -----------------------------------------------------------------------------
# Load necessary libraries
library(performance)
library(see)
# Note: if you haven't installed the packages above, 
# you'll need to install them first by using:
# install.packages("performance") and install.packages("see")

# Create a regression model (using data available in R by default)
model <- lm(mpg ~ wt * cyl + gear, data = mtcars)

## ---- out.width="90%"---------------------------------------------------------
# Check model assumptions
check_model(model)

## -----------------------------------------------------------------------------
library(rempsyc)

## ---- eval = FALSE------------------------------------------------------------
#  View(nice_assumptions(model))

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
assumptions.table <- do.call("rbind", lapply(models.list, nice_assumptions))

## ---- eval = FALSE------------------------------------------------------------
#  View(assumptions.table)

## -----------------------------------------------------------------------------
nice_table(assumptions.table, col.format.p = 2:4)

## -----------------------------------------------------------------------------
nice_qq(data = iris,
        variable = "Sepal.Length",
        group = "Species")

## -----------------------------------------------------------------------------
nice_qq(data = iris,
        variable = "Sepal.Length",
        group = "Species",
        colours = c("#00BA38", "#619CFF", "#F8766D"),
        groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica"),
        grid = FALSE,
        shapiro = TRUE,
        title = NULL)

## -----------------------------------------------------------------------------
nice_density(data = iris,
             variable = "Sepal.Length",
             group = "Species")

## -----------------------------------------------------------------------------
nice_density(data = iris,
             variable = "Sepal.Length",
             group = "Species",
             colours = c("#00BA38", "#619CFF", "#F8766D"),
             xtitle = "Sepal Length",
             ytitle = "Density (vs. Normal Distribution)",
             groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica"),
             grid = FALSE,
             shapiro = TRUE,
             histogram = TRUE,
             title = "Density (Sepal Length)")

## ---- fig.width=12, fig.height=7, out.width="100%"----------------------------
nice_normality(data = iris,
               variable = "Sepal.Length",
               group = "Species",
               shapiro = TRUE,
               histogram = TRUE,
               title = "Density (Sepal Length)")

## ---- eval = FALSE------------------------------------------------------------
#  View(nice_var(data=iris,
#                variable="Sepal.Length",
#                group="Species"))

## -----------------------------------------------------------------------------
# Define our dependent variables
DV <- names(iris[1:4])

# Make diagnostic table
var.table <- do.call("rbind", lapply(DV, nice_var, data=iris, group="Species"))

## ---- eval = FALSE------------------------------------------------------------
#  View(var.table)

## -----------------------------------------------------------------------------
nice_varplot(data = iris,
             variable = "Sepal.Length",
             group = "Species")

## -----------------------------------------------------------------------------
nice_varplot(data = iris,
             variable = "Sepal.Length", 
             group = "Species",
             colours = c("#00BA38", "#619CFF", "#F8766D"),
             ytitle = "Sepal Length",
             groups.labels = c("(a) Setosa", "(b) Versicolor", "(c) Virginica"))

