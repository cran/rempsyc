## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 7, 
                      warning = FALSE, message = FALSE)
knitr::opts_knit$set(root.dir = tempdir())

## -----------------------------------------------------------------------------
head(mtcars)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = "mpg",
            group = "am",
            warning = FALSE)

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = names(mtcars)[1:6],
            group = "am",
            warning = FALSE) -> t.test.results
t.test.results

## -----------------------------------------------------------------------------
my_table <- nice_table(t.test.results)
my_table

## ---- eval = FALSE------------------------------------------------------------
#  save_as_docx(my_table, path = "t-tests.docx")

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = "mpg",
            group = "am",
            var.equal = TRUE) |> 
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = "mpg",
            group = "am",
            alternative = "less",
            warning = FALSE) |> 
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = "mpg",
            mu = 17,
            warning = FALSE) |> 
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(data = ToothGrowth,
            response = "len",
            group = "supp",
            paired = TRUE) |> 
  nice_table()

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = names(mtcars)[1:6],
            group = "am",
            correction = "bonferroni",
            warning = FALSE) |> 
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

