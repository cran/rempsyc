## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(fig.width = 6, fig.height = 6, warning = FALSE, 
                      message = FALSE, results = 'hide', out.width = "30%")
knitr::opts_knit$set(root.dir = tempdir())

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
overlap_circle(1)

## -----------------------------------------------------------------------------
overlap_circle(3.5)

## -----------------------------------------------------------------------------
overlap_circle(6.84)

## -----------------------------------------------------------------------------
overlap_circle(3.12, categories = c("Humans","Animals"))

## -----------------------------------------------------------------------------
plot <- overlap_circle(3.5)

## ---- eval = FALSE------------------------------------------------------------
#  ggsave(plot, file = "overlap.pdf", width = 7, height = 7, unit = 'in', dpi = 300)
#  # Change the path to where you would like to save it.
#  # If you copy-paste your path name, remember to use "R" slashes ('/' rather than '\').
#  # Also remember to specify the .pdf extension of the file.

