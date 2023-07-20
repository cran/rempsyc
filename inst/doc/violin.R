## ----global_options, include=FALSE--------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 7, fig.height = 7, warning = FALSE,
  message = FALSE, out.width = "70%"
)
knitr::opts_knit$set(root.dir = tempdir())

pkgs <- c("ggplot2", "boot", "psych")
successfully_loaded <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1L), quietly = TRUE)
can_evaluate <- all(successfully_loaded)

if (can_evaluate) {
  knitr::opts_chunk$set(eval = TRUE)
  vapply(pkgs, require, FUN.VALUE = logical(1L), quietly = TRUE, character.only = TRUE)
} else {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
data("ToothGrowth")
head(ToothGrowth)

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
pkgs <- c("ggplot2", "boot", "psych")
install_if_not_installed(pkgs)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len"
)

## ---- eval = FALSE------------------------------------------------------------
#  ggplot2::ggsave("nice_violinplothere.pdf",
#    width = 7, height = 7,
#    unit = "in", dpi = 300
#  )
#  # Change the path to where you would like to save it.
#  # If you copy-paste your path name,
#  # remember to use "R" slashes ('/' rather than '\').
#  # Also remember to specify the .tiff extension of the file.

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  ytitle = "Length of Tooth",
  xtitle = "Vitamin C Dosage"
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  comp1 = "0.5",
  comp2 = "2"
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  comp1 = 2,
  comp2 = 3
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  signif_annotation = c("*", "**", "***"), # manually enter the number of stars
  signif_yposition = c(30, 36, 40), # What height (y) should the stars appear?
  signif_xmin = c(1, 2, 1), # Where should the left-sided brackets start (x)?
  signif_xmax = c(2, 3, 3)
) # Where should the right-sided brackets end (x)?

## -----------------------------------------------------------------------------
nice_violin(
  data = mtcars,
  group = "am",
  response = "mpg",
  comp1 = 1,
  comp2 = 2,
  has.d = TRUE
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  colours = c("darkseagreen", "cadetblue", "darkslateblue")
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  xlabels = c("Low", "Medium", "High")
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  ytitle = NULL,
  xtitle = NULL
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  has.ylabels = FALSE,
  has.xlabels = FALSE
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  ymin = 5,
  ymax = 35,
  yby = 5
)

## ---- fig.width=8-------------------------------------------------------------
ToothGrowth$six.groups <- sample(1:6, 60, replace = T)
nice_violin(
  data = ToothGrowth,
  group = "six.groups",
  response = "len"
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  obs = TRUE
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  CIcap.width = 0,
  alpha = .70,
  border.colour = "white"
)

## -----------------------------------------------------------------------------
nice_violin(
  data = ToothGrowth,
  group = "dose",
  response = "len",
  boot = TRUE,
  bootstraps = 200,
  ytitle = "Length of Tooth",
  xtitle = "Vitamin C Dosage",
  colours = c("darkseagreen", "cadetblue", "darkslateblue"),
  has.ylabels = TRUE,
  has.xlabels = TRUE,
  xlabels = c("Low", "Medium", "High"),
  ymin = 0,
  ymax = 45,
  yby = 15,
  signif_annotation = c("*", "NS", "***"),
  signif_yposition = c(30, 36, 41),
  signif_xmin = c(1, 2, 1),
  signif_xmax = c(2, 3, 3),
  CIcap.width = 0,
  alpha = 0.5,
  border.colour = "black",
  border.size = 1,
  obs = TRUE,
  has.d = TRUE,
  d.x = 1.7,
  d.y = 20
)

## -----------------------------------------------------------------------------
# Create our group variable:
ToothGrowth$groups <- factor(sample(1:6, 60, replace = T))

# Make the plot and save it to object "p"
p <- nice_violin(
  data = ToothGrowth,
  group = "groups",
  response = "len",
  border.size = 1
)

## ---- fig.width=8-------------------------------------------------------------
# Compute basic statistics and save to object
library(psych) # Install the psych package if you don't already have it
statsSummary <- describeBy(
  x = ToothGrowth$len, group = ToothGrowth$groups, mat = TRUE
)

# Add our annotations! (Warning: a bit more complicated code ahead!)
library(ggplot2)
p + annotate(
  geom = "text",
  # First annotation adds the average
  x = seq(length(levels(ToothGrowth$groups))),
  # Specifies annotations is for all groups/x-axis ticks
  y = statsSummary$mean + 2,
  # Puts mean at mean value on the y-axis (adds 2)
  label = paste0("m =", round(statsSummary$mean, 2))
) +
  # That prints the mean on the plot
  annotate(
    geom = "text",
    # (Second annotation adds the sample size)
    x = seq(length(levels(ToothGrowth$groups))),
    y = statsSummary$mean - 2,
    # Puts sample size at mean value on the y-axis (substracts 2)
    label = paste0("n =", round(statsSummary$n, 2))
  )
# That prints the sample size on the plot

