#' @title Easy t-tests
#'
#' @description Easily compute t-test analyses, with effect sizes,
#' and format in publication-ready format. The 95% confidence interval
#' is for the effect size, Cohen's d, both provided by the `effectsize` package.
#'
#' This function relies on the base R `t.test` function, which
#' uses the Welch t-test per default (see why here:
#' \url{https://daniellakens.blogspot.com/2015/01/always-use-welchs-t-test-instead-of.html}).
#' To use the Student t-test, simply add the following
#' argument: `var.equal = TRUE`.
#'
#' @param data The data frame.
#' @param response The dependent variable.
#' @param correction What correction for multiple comparison
#' to apply, if any. Default is "none" and the only other option
#' (for now) is "bonferroni".
#' @param group The group for the comparison.

#' @param warning Whether to display the Welch test warning or not.
#' @param ... Further arguments to be passed to the `t.test`
#' function (e.g., to use Student instead of Welch test, to
#' change from two-tail to one-tail, or to do a paired-sample
#' t-test instead of independent samples).
#'
#' @keywords t-test group differences
#' @return A formatted dataframe of the specified model, with DV, degrees of
#'         freedom, t-value, p-value, the effect size, Cohen's d, and its
#'         95% confidence interval lower and upper bounds.
#' @export
#' @examples
#' # Make the basic table
#' nice_t_test(
#'   data = mtcars,
#'   response = "mpg",
#'   group = "am"
#' )
#'
#' # Multiple dependent variables at once
#' nice_t_test(
#'   data = mtcars,
#'   response = names(mtcars)[1:7],
#'   group = "am"
#' )
#'
#' # Can be passed some of the regular arguments
#' # of base `t.test()`
#'
#' # Student t-test (instead of Welch)
#' nice_t_test(
#'   data = mtcars,
#'   response = "mpg",
#'   group = "am",
#'   var.equal = TRUE
#' )
#'
#' # One-sided instead of two-sided
#' nice_t_test(
#'   data = mtcars,
#'   response = "mpg",
#'   group = "am",
#'   alternative = "less"
#' )
#'
#' # One-sample t-test
#' nice_t_test(
#'   data = mtcars,
#'   response = "mpg",
#'   mu = 10
#' )
#'
#' # Paired t-test instead of independent samples
#' nice_t_test(
#'   data = ToothGrowth,
#'   response = "len",
#'   group = "supp",
#'   paired = TRUE
#' )
#' # Make sure cases appear in the same order for
#' # both levels of the grouping factor
#' @importFrom methods hasArg
#'
#' @seealso
#' Tutorial: \url{https://rempsyc.remi-theriault.com/articles/t-test}
#'

nice_t_test <- function(data,
                        response,
                        group = NULL,
                        correction = "none",
                        warning = TRUE,
                        ...) {
  args <- list(...)
  if (hasArg(var.equal)) {
    if (args$var.equal == TRUE) message_white("Using Student t-test. \n ")
    if (args$var.equal == FALSE) message_white("Using Welch t-test. \n ")
  }
  if (hasArg(paired)) {
    paired <- args$paired
    if (paired == TRUE) message_white("Using paired t-test. \n ")
    if (paired == FALSE) message_white("Using independent samples t-test. \n ")
  } else {
    paired <- FALSE
  }
  if (!hasArg(var.equal) & paired == FALSE & warning == TRUE) {
    message_white(
      "Using Welch t-test (base R's default; ",
      "cf. https://doi.org/10.5334/irsp.82).
For the Student t-test, use `var.equal = TRUE`. \n "
    )
  }
  if (!missing(group)) {
    data[[group]] <- as.factor(data[[group]])
    formulas <- paste0(response, " ~ ", group)
    formulas <- lapply(formulas, stats::as.formula)
  } else {
    message_white("Using one-sample t-test. \n ")
    formulas <- lapply(data[response], as.numeric)
  }
  if (hasArg(mu)) {
    mu <- args$mu
  } else {
    mu <- 0
  }
  mod.list <- lapply(formulas, stats::t.test, data = data, ...)
  list.names <- c("statistic", "parameter", "p.value")
  sums.list <- lapply(mod.list, function(x) {
    (x)[list.names]
  })
  lapply(formulas, function(x) {
    effectsize::cohens_d(x,
      data = data,
      paired = paired,
      mu = mu
    )
  }) -> boot.lists
  list.stats <- list()
  for (i in seq_along(list.names)) {
    list.stats[[list.names[i]]] <- unlist(c(t((lapply(sums.list, `[[`, i)))))
  }
  d <- unlist(lapply(boot.lists, function(x) {
    (x)["Cohens_d"]
  }))
  CI_lower <- unlist(lapply(boot.lists, `[[`, "CI_low"))
  CI_higher <- unlist(lapply(boot.lists, `[[`, "CI_high"))
  table.stats <- data.frame(
    response,
    list.stats,
    d,
    CI_lower,
    CI_higher
  )
  row.names(table.stats) <- NULL
  names(table.stats) <- c(
    "Dependent Variable", "t", "df", "p",
    "d", "CI_lower", "CI_upper"
  )
  if (correction == "bonferroni") {
    table.stats$p <- table.stats$p * nrow(table.stats)
  }
  table.stats
}
