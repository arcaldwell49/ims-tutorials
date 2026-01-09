# =============================================================================
# Extract openintro datasets for ims-correlation tutorial
# Run this script ONCE locally to create the data files
# Place the resulting .rds files in a 'data/' subdirectory of your tutorial
# =============================================================================

library(openintro)

# Create data directory if it doesn't exist
if (!dir.exists("data")) {
  dir.create("data")
}

# Extract and save datasets used in the tutorials
# (covers both ims-correlation and ims-two-variables)
datasets_to_extract <- c(
  "run09",
  "possum",
  "mammals",
  "ncbirths",
  "bdims",
  "mlbbat10",
  "county_complete",
  "smoking"
)

cat("Extracting datasets from openintro package...\n\n")

for (ds_name in datasets_to_extract) {
  ds <- get(ds_name)
  file_path <- file.path("caldwell",
                         "week2",
                         "two_variables", "data", paste0(ds_name, ".rds"))
  saveRDS(ds, file_path)
  file_size <- file.size(file_path)
  cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
              paste0(ds_name, ".rds"),
              format(file_size, big.mark = ","),
              nrow(ds),
              ncol(ds)))
}

cat("\n===========================================\n")
cat("All datasets saved to data/ directory!\n")
cat("===========================================\n\n")

cat("Your tutorial directory should look like:\n")
cat("
your-tutorial/
├── ims-correlation.Rmd (or ims-two-variables.Rmd)
├── data/
│   ├── run09.rds
│   ├── possum.rds
│   ├── mammals.rds
│   ├── ncbirths.rds
│   ├── bdims.rds
│   ├── mlbbat10.rds
│   ├── county_complete.rds
│   └── smoking.rds
└── images/
    └── (any images referenced in your tutorial)
")
