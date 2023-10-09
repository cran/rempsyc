## ----global_options, include=FALSE--------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 7, fig.height = 7,
  warning = FALSE, message = FALSE
)
knitr::opts_knit$set(root.dir = tempdir())

pkgs <- c("effectsize", "methods", "flextable", "broom", "report")
successfully_loaded <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1L), quietly = TRUE)
can_evaluate <- all(successfully_loaded)

if (can_evaluate) {
  knitr::opts_chunk$set(eval = TRUE)
  vapply(pkgs, require, FUN.VALUE = logical(1L), quietly = TRUE, character.only = TRUE)
} else {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
head(mtcars)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
pkgs <- c("effectsize", "flextable", "broom", "report")
install_if_not_installed(pkgs)

## -----------------------------------------------------------------------------
nice_t_test(
  data = mtcars,
  response = "mpg",
  group = "am",
  warning = FALSE
)

## -----------------------------------------------------------------------------
t.test.results <- nice_t_test(
  data = mtcars,
  response = names(mtcars)[1:6],
  group = "am",
  warning = FALSE
)
t.test.results

## -----------------------------------------------------------------------------
my_table <- nice_table(t.test.results)
my_table

## ----eval = FALSE-------------------------------------------------------------
#  # Open in Word
#  print(my_table, preview = "docx")
#  
#  # Save in Word
#  flextable::save_as_docx(my_table, path = "t-tests.docx")

## -----------------------------------------------------------------------------
nice_t_test(
  data = mtcars,
  response = "mpg",
  group = "am",
  var.equal = TRUE
) |>
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(
  data = mtcars,
  response = "mpg",
  group = "am",
  alternative = "less",
  warning = FALSE
) |>
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(
  data = mtcars,
  response = "mpg",
  mu = 17,
  warning = FALSE
) |>
  nice_table()

## ----eval = FALSE-------------------------------------------------------------
#  nice_t_test(
#    data = ToothGrowth,
#    response = "len",
#    group = "supp",
#    paired = TRUE
#  ) |>
#    nice_table()

## -----------------------------------------------------------------------------
nice_t_test(
  data = mtcars,
  response = names(mtcars)[1:6],
  group = "am",
  correction = "bonferroni",
  warning = FALSE
) |>
  nice_table()

## -----------------------------------------------------------------------------
model <- t.test(mpg ~ am, data = mtcars)

## -----------------------------------------------------------------------------
library(broom)
(stats.table <- tidy(model, conf.int = TRUE))
nice_table(stats.table, broom = "t.test")

## -----------------------------------------------------------------------------
library(report)
(stats.table <- as.data.frame(report(model)))
nice_table(stats.table, report = "t.test")

## -----------------------------------------------------------------------------
nice_table(stats.table, report = "t.test", short = TRUE)

