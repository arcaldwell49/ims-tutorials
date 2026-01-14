# =============================================================================
# Extract datasets for ims-para-slopes tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week6", "parallel-slope", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# Datasets used in ims-para-slopes tutorial
# Note: mpg comes from ggplot2 (loaded automatically), not openintro
datasets_to_extract <- c(
  "mariokart",
  "babies"
)

cat("Extracting datasets from openintro package...\n\n")

for (ds_name in datasets_to_extract) {
  ds <- get(ds_name)
  file_path <- file.path(data_dir, paste0(ds_name, ".rds"))
  saveRDS(ds, file_path)
  file_size <- file.size(file_path)
  cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
              paste0(ds_name, ".rds"),
              format(file_size, big.mark = ","),
              nrow(ds),
              ncol(ds)))
}

cat("\n===========================================\n")
cat("All datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Note: The 'mpg' dataset comes from ggplot2 and is loaded automatically.\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week6/
    └── parallel-slope/
        ├── ims-para-slopes.Rmd
        └── data/
            ├── mariokart.rds
            └── babies.rds
")
