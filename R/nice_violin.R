#' @title Easy violin plots
#'
#' @description Make nice violin plots easily with 95% bootstrapped
#' confidence intervals.
#'
#' @param data The data frame.
#' @param group The group by which to plot the variable.
#' @param response The dependent variable to be plotted.
#' @param boot Logical, whether to use bootstrapping or not.
#' @param bootstraps How many bootstraps to use.
#' @param colours Desired colours for the plot, if desired.
#' @param xlabels The individual group labels on the x-axis.
#' @param ytitle An optional y-axis label, if desired.
#' @param xtitle An optional x-axis label, if desired.
#' @param has.ylabels Logical, whether the x-axis should have labels or not.
#' @param has.xlabels Logical, whether the y-axis should have labels or not.
#' @param comp1 The first unit of a pairwise comparison, if the
#' goal is to compare two groups. Automatically displays `*`,
#' `**`, or `***` depending on significance of the difference.
#' Can take either a numeric value (based on the group number)
#' or the name of the group directly. Must be provided along
#' with argument `comp2`.
#' @param comp2 The second unit of a pairwise comparison, if
#' the goal is to compare two groups. Automatically displays
#' "*", "**", or "***" depending on significance of the
#' difference. Can take either a numeric value (based on the
#' group number) or the name of the group directly. Must be
#' provided along with argument `comp1`.
#' @param signif_annotation Manually provide the required
#' annotations/numbers of stars (as character strings).
#' Useful if the automatic pairwise comparison annotation
#' does not work as expected, or yet if one wants more than
#' one pairwise comparison. Must be provided along with
#' arguments `signif_yposition`, `signif_xmin`, and `signif_xmax`.
#' @param signif_yposition Manually provide the vertical
#' position of the annotations/stars, based on the y-scale.
#' @param signif_xmin Manually provide the first part of
#' the horizontal position of the annotations/stars (start
#' of the left-sided bracket), based on the x-scale.
#' @param signif_xmax Manually provide the second part
#' of the horizontal position of the annotations/stars
#' (end of the right-sided bracket), based on the x-scale.
#' @param ymin The minimum score on the y-axis scale.
#' @param ymax The maximum score on the y-axis scale.
#' @param yby How much to increase on each "tick" on the y-axis scale.
#' @param CIcap.width The width of the confidence interval cap.
#' @param obs Logical, whether to plot individual observations or not.
#' @param alpha The transparency of the plot.
#' @param border.colour The colour of the violins border.
#' @param border.size The size of the violins border.
#' @param has.d Whether to display the d-value.
#' @param d.x The x-axis coordinates for the d-value.
#' @param d.y The y-axis coordinates for the d-value.
#'
#' @keywords violin plots
#' @return A violin plot of class ggplot, by group.
#' @export
#' @examples
#' # Make the basic plot
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   bootstraps = 200,
#' )
#' \donttest{
#' \dontshow{.old_wd <- setwd(tempdir())}
#' # Save a high-resolution image file to specified directory
#' ggsave("niceviolinplothere.pdf", width = 7,
#'   height = 7, unit = "in", dpi = 300
#' ) # change for your own desired path
#' \dontshow{setwd(.old_wd)}
#' # Change x- and y- axes labels
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   ytitle = "Length of Tooth",
#'   xtitle = "Vitamin C Dosage"
#' )
#'
#' # See difference between two groups
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   comp1 = "0.5",
#'   comp2 = "2"
#' )
#'
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   comp1 = 2,
#'   comp2 = 3
#' )
#'
#' # Compare all three groups
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   signif_annotation = c("*", "**", "***"),
#'   # manually enter the number of stars
#'   signif_yposition = c(30, 35, 40),
#'   # What height (y) should the stars appear
#'   signif_xmin = c(1, 2, 1),
#'   # Where should the left-sided brackets start (x)
#'   signif_xmax = c(2, 3, 3)
#' )
#' # Where should the right-sided brackets end (x)
#'
#' # Set the colours manually
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   colours = c("darkseagreen", "cadetblue", "darkslateblue")
#' )
#'
#' # Changing the names of the x-axis labels
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   xlabels = c("Low", "Medium", "High")
#' )
#'
#' # Removing the x-axis or y-axis titles
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   ytitle = NULL,
#'   xtitle = NULL
#' )
#'
#' # Removing the x-axis or y-axis labels (for whatever purpose)
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   has.ylabels = FALSE,
#'   has.xlabels = FALSE
#' )
#'
#' # Set y-scale manually
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   ymin = 5,
#'   ymax = 35,
#'   yby = 5
#' )
#'
#' # Plotting individual observations
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   obs = TRUE
#' )
#'
#' # Micro-customizations
#' nice_violin(
#'   data = ToothGrowth,
#'   group = "dose",
#'   response = "len",
#'   CIcap.width = 0,
#'   alpha = .70,
#'   border.size = 1,
#'   border.colour = "white",
#'   comp1 = 1,
#'   comp2 = 2,
#'   has.d = TRUE
#' )
#' }
#' @seealso
#' Visualize group differences via scatter plots:
#' \code{\link{nice_scatter}}. Tutorial:
#' \url{https://rempsyc.remi-theriault.com/articles/violin}
#'
#' @importFrom ggplot2 ggplot labs facet_grid ggtitle theme_bw
#' scale_fill_manual theme annotate scale_x_discrete ylab xlab
#' geom_violin geom_point geom_errorbar geom_dotplot
#' scale_y_continuous aes_string aes element_blank element_line
#' element_text
#' @importFrom rlang .data UQ

nice_violin <- function(data,
                        group,
                        response,
                        boot = TRUE,
                        bootstraps = 2000,
                        colours,
                        xlabels = NULL,
                        ytitle = ggplot2::waiver(),
                        xtitle = NULL,
                        has.ylabels = TRUE,
                        has.xlabels = TRUE,
                        comp1 = 1,
                        comp2 = 2,
                        signif_annotation = NULL,
                        signif_yposition = NULL,
                        signif_xmin = NULL,
                        signif_xmax = NULL,
                        ymin,
                        ymax,
                        yby = 1,
                        CIcap.width = 0.1,
                        obs = FALSE,
                        alpha = 1,
                        border.colour = "black",
                        border.size = 2,
                        has.d = FALSE,
                        d.x = mean(c(comp1, comp2)) * 1.1,
                        d.y = mean(data[[response]]) * 1.3) {
  data[[group]] <- as.factor(data[[group]])
  gform <- stats::reformulate(group, response)
  class(data[[response]]) <- "numeric"
  dataSummary <- rcompanion_groupwiseMean(gform,
    data = data,
    conf = 0.95,
    digits = 3,
    R = bootstraps,
    boot = TRUE,
    traditional = !boot,
    normal = FALSE,
    basic = FALSE,
    percentile = FALSE,
    bca = boot
  )
  if (has.d == TRUE & any(
    !missing(comp1), !missing(comp2),
    !missing(signif_xmin)
  )) {
    if (missing(comp1) & missing(comp2) & !missing(signif_xmin)) {
      comp1.temp <- signif_xmin[1]
      comp2.temp <- signif_xmax[1]
    } else {
      comp1.temp <- comp1
      comp2.temp <- comp2
    }
    data.d <- data %>%
      dplyr::filter(UQ(dplyr::sym(group)) %in% levels(
        data[[group]]
      )[c(comp1.temp, comp2.temp)]) %>%
      droplevels()
    d <- round(effectsize::cohens_d(response,
      y = group,
      data = data.d
    )$Cohens_d, 2)
    d <- format_d(abs(d))
    d <- paste("=", d)
  }
  ggplot(data, aes(
    x = .data[[group]],
    y = .data[[response]],
    fill = .data[[group]]
  )) +
    {
      if (!missing(colours)) scale_fill_manual(values = colours)
    } +
    {
      if (!missing(xlabels)) scale_x_discrete(labels = c(xlabels))
    } +
    ylab(ytitle) +
    xlab(xtitle) +
    geom_violin(color = border.colour, alpha = alpha, size = border.size) +
    geom_point(aes(y = .data$Mean),
      color = "black",
      size = 4,
      data = dataSummary
    ) +
    geom_errorbar(aes(
      y = .data$Mean,
      ymin = dataSummary[, 6],
      ymax = dataSummary[, 7]
    ),
    color = "black",
    size = 1,
    width = CIcap.width,
    data = dataSummary
    ) +
    theme_apa +
    {
      if (obs == TRUE) {
        geom_dotplot(
          binaxis = "y",
          stackdir = "center",
          position = "dodge",
          color = NA,
          fill = "black",
          alpha = 0.3,
          dotsize = 0.5
        )
      }
    } +
    {
      if (has.ylabels == FALSE) {
        theme(
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()
        )
      }
    } +
    {
      if (has.xlabels == FALSE) {
        theme(
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank()
        )
      }
    } +
    {
      if (!missing(ymin)) {
        scale_y_continuous(
          limits = c(ymin, ymax), breaks = seq(ymin, ymax, by = yby)
        )
      }
    } +
    {
      if (!missing(comp1)) {
        ggsignif::geom_signif(
          comparisons = list(c(comp1, comp2)), test = "t.test",
          map_signif_level = TRUE, size = 1.3, textsize = 8
        )
      }
    } +
    {
      if (!missing(signif_annotation)) {
        ggsignif::geom_signif(
          annotation = signif_annotation, y_position = signif_yposition,
          xmin = signif_xmin, xmax = signif_xmax, size = 1.3, textsize = 8
        )
      }
    } +
    if (has.d == TRUE & any(
      !missing(comp1), !missing(comp2),
      !missing(signif_xmin)
    )) {
      annotate(
        geom = "text",
        x = d.x,
        y = d.y,
        label = sprintf("italic('d')~'%s'", d),
        parse = TRUE,
        hjust = 1,
        vjust = -1,
        size = 7
      )
    }
}