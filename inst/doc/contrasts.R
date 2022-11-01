## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 7, warning = FALSE, 
                      message = FALSE, out.width = "70%")
knitr::opts_knit$set(root.dir = tempdir())

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
table.stats <- nice_contrasts(response = "Sepal.Length",
                              group = "Species",
                              data = iris)
table.stats

## -----------------------------------------------------------------------------
(my_table <- nice_table(table.stats))

## ---- eval = FALSE------------------------------------------------------------
#  save_as_docx(my_table, path = "contrasts.docx")

## ----fig.width=7, fig.height=7------------------------------------------------
(figure <- nice_violin(group = "Species", 
                       response = "Sepal.Length", 
                       data = iris,
                       ytitle = "Length of Sepal", 
                       signif_annotation = c("***", "***", "***"),
                       signif_yposition = c(8.7, 7.3, 8.2),
                       signif_xmin = c("setosa", "setosa", "versicolor"),
                       signif_xmax = c("virginica", "versicolor", "virginica")))

## ---- eval = FALSE------------------------------------------------------------
#  ggplot2::ggsave('Figure 1.pdf', figure, width = 7, height = 7,
#                  unit = 'in', dpi = 300)

## -----------------------------------------------------------------------------
data <- read.csv("https://osf.io/qkmnp//?action=download", header=TRUE)

## -----------------------------------------------------------------------------
(data$Group <- factor(data$Group, levels = c("Embodied", "Mental", "Control")))

## -----------------------------------------------------------------------------
library(dplyr)
(DV <- data %>% select(QCAEPR:IOS) %>% names)

## -----------------------------------------------------------------------------
table.stats <- nice_contrasts(response = DV,
                              group = "Group",
                              data = data)
table.stats


## -----------------------------------------------------------------------------
table.stats[1] <- rep(c("Peripheral Responsivity (QCAE)",
                        "Perspective-Taking (IRI)", 
                        "Fantasy (IRI)", "Empathic Concern (IRI)", 
                        "Personal Distress (IRI)",
                        "Inclusion of Other in the Self (IOS)"), each = 3)

## -----------------------------------------------------------------------------
(my_table <- nice_table(table.stats, highlight = TRUE))

## ---- eval = FALSE------------------------------------------------------------
#  save_as_docx(my_table, path = "contrasts.docx")

## -----------------------------------------------------------------------------
Data <- na.omit(data)

## -----------------------------------------------------------------------------
(EC <- nice_violin(group = "Group",
                   response = "IRIEC", 
                   data = Data,
                   colours = c("#00BA38", "#619CFF", "#F8766D"), 
                   ytitle = "Empathic Concern (from IRI)", 
                   signif_annotation = "*", 
                   signif_yposition = 5.2, 
                   signif_xmin = 1, 
                   signif_xmax = 3))

## -----------------------------------------------------------------------------
(PD <- nice_violin(group = "Group", 
                   response = "IRIPD", 
                   data = Data,
                   colours = c("#00BA38", "#619CFF", "#F8766D"), 
                   ytitle = "Personal Distress (from IRI)", 
                   signif_annotation = "*", 
                   signif_yposition = 5, 
                   signif_xmin = 1,
                   signif_xmax = 3))

## -----------------------------------------------------------------------------
(PR <- nice_violin(group = "Group", 
                   response = "QCAEPR", 
                   data = Data,
                   colours = c("#00BA38", "#619CFF", "#F8766D"), 
                   ytitle = "Peripheral Responsivity (from QCAE)", 
                   signif_annotation="*",
                   signif_yposition=4.2,
                   signif_xmin=1,
                   signif_xmax=3))

## -----------------------------------------------------------------------------
(IOS <- nice_violin(group = "Group", 
                    response = "IOS", 
                    data = Data,
                    colours = c("#00BA38", "#619CFF", "#F8766D"), 
                    ytitle = "Self-Other Merging (from IOS)", 
                    signif_annotation=c("***", "*", "*"),
                    signif_yposition=c(8.25, 7.5, 6.75),
                    signif_xmin=c(1,1,2),
                    signif_xmax=c(3,2,3)))

## ----fig.width=14, fig.height=14, out.width="100%"----------------------------
library(ggpubr)
(figure <- ggarrange(EC, PD, PR, IOS,
                     labels = "AUTO",
                     ncol = 2, nrow = 2))

## ---- eval = FALSE------------------------------------------------------------
#  ggplot2::ggsave('Figure 1.pdf', figure, width = 14, height = 14,
#                  unit = 'in', dpi = 300)

