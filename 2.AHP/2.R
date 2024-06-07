install.packages("devtools")
devtools::install_github("gluc/ahp", build_vignettes = TRUE, force = TRUE)
install.packages("data.tree","formattable","DiagrammeR")
library("devtools")
library(data.tree)
library(formattable)
library(DiagrammeR)
library(ahp)

setwd("./AHP")

ahp_file <-  "smartphone_ahp.ahp"

ahp_tree <- Load(ahp_file)

Calculate(ahp_tree)

Visualize(ahp_tree)

warnings()

Analyze(ahp_tree)

AnalyzeTable(ahp_tree)

print(ahp_tree)