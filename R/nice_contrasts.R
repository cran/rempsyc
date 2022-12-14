#' @title Easy planned contrasts
#'
#' @description Easily compute planned contrast analyses (pairwise
#' comparisons similar to t-tests but more powerful when more than
#' 2 groups), and format in publication-ready format. Supports only
#' three groups for the moment. In this particular case, the
#' confidence intervals are bootstraped on the Robust Cohen's d.
#'
#' @details Statistical power is lower with the standard *t* test
#' compared than it is with the planned contrast version for two
#' reasons: a) the sample size is smaller with the *t* test,
#' because only the cases in the two groups are selected; and b)
#' in the planned contrast the error term is smaller than it is
#' with the standard *t* test because it is based on all the cases
#' ([source](https://web.pdx.edu/~newsomj/uvclass/ho_planned%20contrasts.pdf)).
#'
#' @param response The dependent variable.
#' @param group The group for the comparison.
#' @param covariates The desired covariates in the model.
#' @param data The data frame.
#' @param bootstraps The number of bootstraps to use for the confidence interval
#' @keywords planned contrasts pairwise comparisons
#' group differences internal
#' @return A dataframe, with the selected dependent variable(s), comparisons of
#'         interest, degrees of freedom, t-values, p-values, robust Cohen's d
#'         (dR), and the lower and upper 95% confidence intervals of the
#'         effect size (i.e., dR).
#' @export
#' @examples
#' # Basic example
#' nice_contrasts(
#'   data = mtcars,
#'   response = "mpg",
#'   group = "cyl",
#'   bootstraps = 200
#' )
#' \donttest{
#' nice_contrasts(
#'   data = mtcars,
#'   response = "disp",
#'   group = "gear"
#' )
#'
#' # Multiple dependent variables
#' nice_contrasts(
#'   data = mtcars,
#'   response = c("mpg", "disp", "hp"),
#'   group = "cyl"
#' )
#'
#' # Adding covariates
#' nice_contrasts(
#'   data = mtcars,
#'   response = "mpg",
#'   group = "cyl",
#'   covariates = c("disp", "hp")
#' )
#' }
#' @seealso
#' Tutorial: \url{https://rempsyc.remi-theriault.com/articles/contrasts}
#'
#' @importFrom dplyr %>% bind_rows

nice_contrasts <- function(response, group, covariates = NULL,
                           data, bootstraps = 2000) {
  rlang::check_installed(c("bootES", "emmeans"), reason = "for this function.")
  data[[group]] <- as.factor(data[[group]])
  data[response] <- lapply(data[response], as.numeric)
  if (!missing(covariates)) {
    data[covariates] <- lapply(data[covariates], as.numeric)
    covariates.term <- paste("+", covariates, collapse = " ")
  } else {
    covariates.term <- ""
  }
  formulas <- paste(
    response, "~", group,
    covariates.term
  ) ### Add support for moderator(s)
  models.list <- lapply(formulas, lm, data = data)
  leastsquare.list <- lapply(models.list, emmeans::emmeans, group, data = data)
  groups.contrasts <- list(
    comp1 = stats::setNames(c(1, 0, -1), levels(data[[group]])),
    # Add support x groups
    comp2 = stats::setNames(c(0, 1, -1), levels(data[[group]])),
    # Add support x groups
    comp3 = stats::setNames(c(1, -1, 0), levels(data[[group]]))
  )
  # Add support x groups
  boot.lists <- lapply(groups.contrasts, function(y) {
    lapply(response, function(x) {
      bootES::bootES(
        data = stats::na.omit(data),
        R = bootstraps,
        data.col = x,
        group.col = group,
        contrast = y,
        effect.type = "akp.robust.d"
      )
    })
  })
  contrval.list <- lapply(leastsquare.list, emmeans::contrast,
    groups.contrasts,
    adjust = "none"
  )
  contrval.sums <- lapply(contrval.list, summary)
  # boot.sums <- lapply(unlist(boot.lists, recursive = FALSE), summary)

  boot.sums <- lapply(seq(length(response)), function(y) {
    lapply(boot.lists, function(x) {
      as.data.frame(summary(x[[y]]))
        }) %>%
      bind_rows
  })
  list.names <- c("estimates", "SE", "df", "tratio", "pvalue")
  stats.list <- list()
  for (i in seq_along(list.names)) {
    stats.list[[list.names[i]]] <- unlist(c(t((
      lapply(contrval.sums, `[[`, i + 1)))))
  }
  # list.names2 <- c("cohenD", "cohenDL", "cohenDH")
  # for (i in seq_along(list.names2)) {
  #   stats.list[[list.names2[i]]] <- bind_rows(boot.sums)
  # }
  response.names <- rep(response, each = length(contrval.sums[[1]]$contrast))
  comparisons.names <- rep(
    c(
      paste(
        levels(data[[group]])[1], "-",
        levels(data[[group]])[3]
      ), ###### support x groups
      paste(
        levels(data[[group]])[2], "-",
        levels(data[[group]])[3]
      ), ###### support x groups
      paste(
        levels(data[[group]])[1], "-",
        levels(data[[group]])[2]
      )
    ), ###### support x groups
    times = length(response)
  )
  table.stats <- data.frame(
    response.names,
    comparisons.names,
    stats.list[-c(1:2)],
    bind_rows(boot.sums)[1:3]
  )
  # table.stats <- table.stats[order(factor(table.stats$response.names,
  #   levels = response
  # )), ]
  names(table.stats) <- c(
    "Dependent Variable", "Comparison", "df",
    "t", "p", "dR", "CI_lower", "CI_upper"
  )
  row.names(table.stats) <- NULL
  table.stats
}
