# =============================================================================
# Data extraction script for ims-twoway-anova tutorial
# =============================================================================
#
# This script extracts datasets from R packages and saves them as RDS files
# for use in the learnr tutorial. Run this script once to set up your data.
#
# Required packages: openintro
# =============================================================================

# Create data directory
data_dir <- file.path("caldwell", "week13", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
  cat("Created directory:", data_dir, "\n")
}

# -----------------------------------------------------------------------------
# Dataset 1: ToothGrowth (built-in to R)
# -----------------------------------------------------------------------------
cat("Extracting ToothGrowth dataset...\n")

# ToothGrowth is built into R, just need to prepare it
data("ToothGrowth")
tooth <- ToothGrowth
tooth$dose <- factor(tooth$dose)

saveRDS(tooth, file.path(data_dir, "tooth.rds"))
cat("  Saved tooth.rds (", nrow(tooth), " observations)\n", sep = "")

# -----------------------------------------------------------------------------
# Dataset 2: evals from openintro package
# -----------------------------------------------------------------------------
cat("Extracting evals dataset from openintro...\n")

if (!requireNamespace("openintro", quietly = TRUE)) {
  install.packages("openintro")
}
library(openintro)

# Load and subset the evals data
data("evals", package = "openintro")
evals_subset <- evals[, c("score", "rank", "gender", "age", "bty_avg")]
evals_subset <- evals_subset[complete.cases(evals_subset), ]

saveRDS(evals_subset, file.path(data_dir, "evals_subset.rds"))
cat("  Saved evals_subset.rds (", nrow(evals_subset), " observations)\n", sep = "")

# -----------------------------------------------------------------------------
# Dataset 3: Simulated learning data
# -----------------------------------------------------------------------------
cat("Creating simulated learning_data...\n")

set.seed(2024)
learning_data <- data.frame(
  teaching_method = rep(c("Lecture", "Active Learning"), each = 60),
  class_size = rep(rep(c("Small", "Large"), each = 30), 2),
  test_score = c(
    # Lecture + Small: mean = 75
    rnorm(30, 75, 8),
    # Lecture + Large: mean = 70
    rnorm(30, 70, 8),
    # Active Learning + Small: mean = 85
    rnorm(30, 85, 8),
    # Active Learning + Large: mean = 82
    rnorm(30, 82, 8)
  )
)
learning_data$teaching_method <- factor(learning_data$teaching_method)
learning_data$class_size <- factor(learning_data$class_size)

saveRDS(learning_data, file.path(data_dir, "learning_data.rds"))
cat("  Saved learning_data.rds (", nrow(learning_data), " observations)\n", sep = "")

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
cat("\n===========================================\n")
cat("Data extraction complete!\n")
cat("===========================================\n\n")

cat("Files created in", data_dir, ":\n")
cat("  - tooth.rds (ToothGrowth data with dose as factor)\n")
cat("  - evals_subset.rds (Course evaluations subset)\n")
cat("  - learning_data.rds (Simulated teaching method data)\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week13/
    ├── ims-twoway-anova.Rmd
    └── data/
        ├── tooth.rds
        ├── evals_subset.rds
        └── learning_data.rds
\n")
