## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 8, fig.height = 7, warning = FALSE, 
                      message = FALSE)
knitr::opts_knit$set(root.dir = tempdir())

## -----------------------------------------------------------------------------
library(rempsyc)

## -----------------------------------------------------------------------------
nice_table(mtcars[1:3, ], 
           title = c("Table 1", "Motor Trend Car Road Tests"),
           footnote = c("The data was extracted from the 1974 Motor Trend US magazine.",
                        "* p < .05, ** p < .01, *** p < .001"))

## -----------------------------------------------------------------------------
# Standardize variables to get standardized coefficients
mtcars.std <- lapply(mtcars, scale)
# Create a simple linear model
model <- lm(mpg ~ cyl + wt * hp, mtcars.std)
# Gather summary statistics
stats.table <- as.data.frame(summary(model)$coefficients)
# Get the confidence interval (CI) of the regression coefficient
CI <- confint(model)
# Add a row to join the variables names and CI to the stats
stats.table <- cbind(row.names(stats.table), stats.table, CI)
# Rename the columns appropriately
names(stats.table) <- c("Term", "B", "SE", "t", "p", "CI_lower", "CI_upper")

## -----------------------------------------------------------------------------
stats.table

## -----------------------------------------------------------------------------
nice_table(stats.table)

## -----------------------------------------------------------------------------
my_table <- nice_table(stats.table)

## ---- eval = FALSE------------------------------------------------------------
#  save_as_docx(my_table, path = "nice_tablehere.docx")

## -----------------------------------------------------------------------------
test <- head(mtcars, 3)
names(test) <- c("dR", "N", "M", "SD", "W", "np2", "ges", "z", "r", "R2", "sr2")
test[, 10:11] <- test[, 10:11]/10
nice_table(test)

## -----------------------------------------------------------------------------
nice_table(stats.table, highlight = TRUE)

## -----------------------------------------------------------------------------
nice_table(stats.table, highlight = .01)

## -----------------------------------------------------------------------------
library(broom)
model <- lm(mpg ~ cyl + wt * hp, mtcars)
(stats.table <- tidy(model, conf.int = TRUE))
nice_table(stats.table, broom = "lm")

## -----------------------------------------------------------------------------
library(report)
model <- lm(mpg ~ cyl + wt * hp, mtcars)
(stats.table <- as.data.frame(report(model)))
nice_table(stats.table)

## -----------------------------------------------------------------------------
nice_table(stats.table, short = TRUE)

## -----------------------------------------------------------------------------
nice_t_test(data = mtcars,
            response = c("mpg", "disp", "drat"),
            group = "am",
            warning = FALSE) -> stats.table
stats.table

nice_table(stats.table)

## -----------------------------------------------------------------------------
nice_mod(data = mtcars,
         response = "mpg",
         predictor = "gear",
         moderator = "wt") -> stats.table
stats.table

nice_table(stats.table)

## -----------------------------------------------------------------------------
nice_table(test[8:11], col.format.p = 1:4)

## -----------------------------------------------------------------------------
nice_table(test[8:11], col.format.r = 1:4)

## -----------------------------------------------------------------------------
fun <- function(x) {x+11.1}

nice_table(test[8:11], col.format.custom = 2:4, format.custom = "fun")

fun <- function(x) {paste("×", x)}

nice_table(test[8:11], col.format.custom = 2:4, format.custom = "fun")

## -----------------------------------------------------------------------------
library(dplyr)
library(flextable)
my_table %>%
  italic(j = 1, part = "body") %>%
  bg(bg = "gray", part = "header") %>%
  color(color = "blue", part = "header") %>%
  color(~ t > -3.5, ~ t + SE, color = "red") %>%
  bold(~ t > -3.5, ~ t + p, bold = TRUE) %>%
  set_header_labels(Term = "Model Term",
                    B	= "Standardized Beta",
                    p = "p-value")

## -----------------------------------------------------------------------------
# Setup example dataset
data <- cbind(iris[c(5, 1:3)], iris[1:3]+1)
names(data)[-1] <- c(paste0("T1.", names(data[2:4])),
                     paste0("T2.", names(data[2:4])))

# Get descriptive statistics
library(dplyr)
data %>%
  group_by(Species) %>% 
  summarize(across(T1.Sepal.Length:T2.Petal.Length, 
                   list(m = mean, sd = sd),
                   .names = "{.col}.{.fn}")) -> descriptive.data

# Rename the columns so we can merge them later
names(descriptive.data) <- c("Species", rep(c("T1.M", "T1.SD"), 3),
                             rep(c("T2.M", "T2.SD"), 3))

# Extract the data by variable and measurement time
T1.disp <- cbind(descriptive.data[1, 2:3], 
                 descriptive.data[2, 2:3], 
                 descriptive.data[3, 2:3])
T1.hp <- cbind(descriptive.data[1, 4:5], 
               descriptive.data[2, 4:5], 
               descriptive.data[3, 4:5])
T1.drat <- cbind(descriptive.data[1, 6:7], 
                 descriptive.data[2, 6:7], 
                 descriptive.data[3, 6:7])
T2.disp <- cbind(descriptive.data[1, 8:9],
                 descriptive.data[2, 8:9], 
                 descriptive.data[3, 8:9])
T2.hp <- cbind(descriptive.data[1, 10:11], 
               descriptive.data[2, 10:11], 
               descriptive.data[3, 10:11])
T2.drat <- cbind(descriptive.data[1, 12:13], 
                 descriptive.data[2, 12:13], 
                 descriptive.data[3, 12:13])

# Combine Time 1 with Time 2
T1 <- rbind(T1.disp, T1.hp, T1.drat)
T2 <- rbind(T2.disp, T2.hp, T2.drat)
wide.data <- cbind(Variable = names(iris[1:3]), T1, T2)

# Rename variables to avoid duplicate names not allowed
names(wide.data)[-1] <- paste0(
  rep(c("T1.", "T2."), each = 6), 
  rep(descriptive.data$Species, times = 2, each = 2),
  paste0(c(".M", ".SD")))

# Make preliminary nice_table
nice_table(wide.data)


## -----------------------------------------------------------------------------
nice_table(wide.data, separate.header = TRUE, italics = seq(wide.data))

