# =============================================================================
# Extract datasets for ims-infer-reg tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week7", "infer_reg", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

cat("Extracting datasets from openintro package...\n\n")

# Extract mariokart from openintro
ds <- openintro::mariokart
file_path <- file.path(data_dir, "mariokart.rds")
saveRDS(ds, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "mariokart.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(ds),
            ncol(ds)))

# Extract babies from openintro
ds <- openintro::babies
file_path <- file.path(data_dir, "babies.rds")
saveRDS(ds, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "babies.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(ds),
            ncol(ds)))

cat("\n===========================================\n")
cat("All datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Note: This tutorial also requires the following CSV files which should\n")
cat("already exist in your data folder (not from R packages):\n")
cat("  - LAhomes.csv\n")
cat("  - restNYC.csv\n")
cat("  - coins.csv\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week7/
    └── infer_reg/
        ├── ims-infer-reg.Rmd
        └── data/
            ├── LAhomes.csv    (existing)
            ├── restNYC.csv    (existing)
            ├── coins.csv      (existing)
            ├── mariokart.rds  (extracted)
            └── babies.rds     (extracted)
")
