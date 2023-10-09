## ----include=FALSE------------------------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 6, fig.height = 6, warning = FALSE,
  message = FALSE, results = "hide", out.width = "30%"
)
knitr::opts_knit$set(root.dir = tempdir())

pkgs <- c("VennDiagram")
successfully_loaded <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1L), quietly = TRUE)
can_evaluate <- all(successfully_loaded)

if (can_evaluate) {
  knitr::opts_chunk$set(eval = TRUE)
  vapply(pkgs, require, FUN.VALUE = logical(1L), quietly = TRUE, character.only = TRUE)
} else {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
install_if_not_installed("VennDiagram")

## -----------------------------------------------------------------------------
overlap_circle(1)

## -----------------------------------------------------------------------------
overlap_circle(3.5)

## -----------------------------------------------------------------------------
overlap_circle(6.84)

## -----------------------------------------------------------------------------
overlap_circle(3.12, categories = c("Humans", "Animals"))

## -----------------------------------------------------------------------------
plot <- overlap_circle(3.5)

## ----eval = FALSE-------------------------------------------------------------
#  ggplot2::ggsave(plot,
#    file = "overlap.pdf", width = 7, height = 7,
#    unit = "in", dpi = 300
#  )
#  # Change the path to where you would like to save it.
#  # If you copy-paste your path name, remember to
#  # use "R" slashes ('/' rather than '\').
#  # Also remember to specify the .pdf extension of the file.

## -----------------------------------------------------------------------------
overlap_circle(55, scoring = "percentage")

overlap_circle(100, scoring = "percentage")

overlap_circle(c(17, 10, 97),
  scoring = "direct",
  categories = c("Self", "Outgroup")
)

