#' @title Attempt to visualize variance per group
#'
#' @description Attempt to visualize variance per group.
#'
#' @param variable The dependent variable to be plotted.
#' @param group The group by which to plot the variable.
#' @param data The data frame
#' @param colours Desired colours for the plot, if desired.
#' @param groups.labels How to label the groups.
#' @param grid Logical, whether to keep the default background
#' grid or not. APA style suggests not using a grid in the
#' background, though in this case some may find it useful to
#' more easily estimate the slopes of the different groups.
#' @param shapiro Logical, whether to include the p-value from
#' the Shapiro-Wilk test on the plot.
#' @param ytitle An optional y-axis label, if desired.
#'
#' @keywords variance
#' @return A scatter plot of class ggplot attempting to display the
#'         group variances. Also includes the max variance ratio
#'         (maximum variance divided by the minimum variance).
#' @export
#' @examplesIf requireNamespace("ggplot2", quietly = TRUE) && requireNamespace("ggrepel", quietly = TRUE)
#' # Make the basic plot
#' nice_varplot(
#'   data = iris,
#'   variable = "Sepal.Length",
#'   group = "Species"
#' )
#'
#' # Further customization
#' nice_varplot(
#'   data = iris,
#'   variable = "Sepal.Length",
#'   group = "Species",
#'   colours = c(
#'     "#00BA38",
#'     "#619CFF",
#'     "#F8766D"
#'   ),
#'   ytitle = "Sepal Length",
#'   groups.labels = c(
#'     "(a) Setosa",
#'     "(b) Versicolor",
#'     "(c) Virginica"
#'   )
#' )
#'
#' @seealso
#' Other functions useful in assumption testing:
#' \code{\link{nice_assumptions}}, \code{\link{nice_density}},
#' \code{\link{nice_normality}}, \code{\link{nice_qq}},
#' \code{\link{nice_var}}. Tutorial:
#' \url{https://rempsyc.remi-theriault.com/articles/assumptions}
#'
#' @importFrom dplyr mutate %>% select group_by summarize rowwise do rename

nice_varplot <- function(data,
                         variable,
                         group,
                         colours,
                         groups.labels,
                         grid = TRUE,
                         shapiro = FALSE,
                         ytitle = variable) {
  check_col_names(data, c(group, variable))
  rlang::check_installed(c("ggplot2", "ggrepel"),
    version = c(get_dep_version("ggplot2"), NA),
    reason = "for this function."
  )
  data[[group]] <- as.factor(data[[group]])
  {
    if (!missing(groups.labels)) levels(data[[group]]) <- groups.labels
  }
  # Calculate variance
  var <- data %>%
    group_by(.data[[group]]) %>%
    summarize(var = stats::var(.data[[variable]], na.rm = TRUE))
  diff <- max(var[, "var"]) / min(var[, "var"])
  # Make annotation dataframe
  dat_text <- var %>%
    mutate(text = paste0("var = ", round(var, 2)))
  # Make plot
  nice_scatter(
    data = data,
    predictor = group,
    response = variable,
    group = group,
    colours = colours,
    groups.labels = groups.labels,
    xtitle = NULL,
    ytitle = ytitle,
    has.points = FALSE,
    has.jitter = FALSE,
    has.legend = FALSE
  ) +
    ggplot2::geom_jitter(size = 2, width = 0.10) +
    ggplot2::annotate(
      geom = "text",
      x = stats::median(seq_along(levels(data[[group]])), na.rm = TRUE),
      y = max(data[[variable]], na.rm = TRUE),
      label = paste0(
        "max/min = ",
        round(diff, 2),
        "x bigger"
      ),
      hjust = 0.5,
      size = 6
    ) +
    ggrepel::geom_text_repel(
      data = dat_text,
      mapping = ggplot2::aes(
        x = .data[[group]],
        y = -Inf,
        label = text
      ),
      inherit.aes = FALSE,
      size = 6
    )
}
