# =============================================================================
# Extract datasets for ims-mult-reg tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week6", "multi-reg", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# Datasets used in ims-mult-reg tutorial
datasets_to_extract <- c(

  "babies",
  "mariokart"
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

cat("Your tutorial directory should look like:\n")
cat("
week6/
└── multi-reg/
    ├── ims-mult-reg.Rmd
    └── data/
        ├── babies.rds
        └── mariokart.rds
")
