# =============================================================================
# Data setup for ims-anova tutorial
# =============================================================================

# This tutorial uses a CSV file that should already exist in your data folder.
# No package-based data extraction is needed.

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week12", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

cat("===========================================\n")
cat("Data setup for ims-anova tutorial\n")
cat("===========================================\n\n")

cat("This tutorial requires the following CSV file:\n")
cat("  - gss_wordsum_class.csv\n\n")

cat("This file should already exist in your data folder.\n")
cat("If not, you'll need to obtain it from your course materials.\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week12/
    ├── ims-anova.Rmd
    └── data/
        └── gss_wordsum_class.csv
")
