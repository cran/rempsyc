## ----global_options, include=FALSE--------------------------------------------
library(knitr)

knitr::opts_chunk$set(
  fig.width = 7, fig.height = 7,
  warning = FALSE, message = FALSE
)
knitr::opts_knit$set(root.dir = tempdir())

pkgs <- c("flextable")
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
install_if_not_installed("flextable")

## -----------------------------------------------------------------------------
set.seed(100)
nice_randomize()

## -----------------------------------------------------------------------------
set.seed(100)
nice_randomize(
  design = "between",
  Ncondition = 4,
  n = 8,
  condition.names = c("BP", "CX", "PZ", "ZL")
)
# Warning: sample size needs to be a multiple of your
# number of groups if using "between"!
# FYI: condition names stand for popular antidepressants:
# BP = Bupropion, CX = Celexa, PZ = Prozac, ZL = Zoloft.

## -----------------------------------------------------------------------------
set.seed(100)
nice_randomize(design = "within")

## -----------------------------------------------------------------------------
set.seed(100)
nice_randomize(
  design = "within",
  Ncondition = 4,
  n = 6,
  condition.names = c("SV", "AV", "ST", "AT")
)
# FYI: condition names stand for forms of multisensory stimulation:
# SV = Synchronous Visual, AV = Asynchronous Visual,
# ST = Synchronous Tactile, AT = Asynchronous Tactile.

## -----------------------------------------------------------------------------
set.seed(100)
nice_randomized_subjects <- nice_randomize(
  design = "within",
  Ncondition = 4,
  n = 128,
  condition.names = c("SV", "AV", "ST", "AT"),
  col.names = c(
    "id", "Condition", "Date/Time",
    "SONA ID", "Age/Gd.", "Handedness",
    "Tester", "Notes"
  )
)
head(nice_randomized_subjects)

## ---- eval = FALSE------------------------------------------------------------
#  runsheet <- nice_table(nice_randomized_subjects)
#  flextable::save_as_docx(runsheet, path = "runsheet.docx")
#  # Change the path to where you would like to save it.
#  # If you copy-paste your path name, remember to
#  # use "R" slashes ('/' rather than '\').
#  # Also remember to specify the .docx extension of the file.

