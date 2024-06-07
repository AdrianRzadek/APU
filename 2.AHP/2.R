# Install and load the necessary packages
install.packages("devtools")
library("devtools")
devtools::install_github("gluc/ahp")
install.packages("data.tree","formattable","DiagrammeR")
library(data.tree)
library(formattable)
library(DiagrammeR)
library(ahp)

# Define the AHP model
ahp_model <- ahp(
  hierarchy = list(
    goal = "Wybór najlepszego iPhone'a",
    criteria = c("Wydajność", "Jakość", "Styl", "Cena"),
    alternatives = c("iPhone_15_Pro_256GB", "iPhone_15_Pro_1TB", "iPhone_14_Pro_128GB", 
                     "iPhone_13_128GB", "iPhone_15_Plus_256GB", "iPhone_15_Plus_512GB", 
                     "iPhone_14_Plus_128GB", "iPhone_11_128GB")
  ),
  comparisons = list(
    # Comparisons for criteria
    criteria = matrix(c(1, 3, 5, 7,
                        1/3, 1, 3, 5,
                        1/5, 1/3, 1, 3,
                        1/7, 1/5, 1/3, 1), nrow = 4, byrow = TRUE),
    # Comparisons for alternatives under each criterion
    Wydajność = matrix(c(...), nrow = 8, byrow = TRUE),
    Jakość = matrix(c(...), nrow = 8, byrow = TRUE),
    Styl = matrix(c(...), nrow = 8, byrow = TRUE),
    Cena = matrix(c(...), nrow = 8, byrow = TRUE)
  )
)

# Calculate the priority vectors
results <- ahp(ahp_model)

# View the results
print(results)
