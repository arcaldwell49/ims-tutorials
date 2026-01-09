# =============================================================================
# Extract datasets for ims-model-fit-simple tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)
library(Lahman)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week4", "fit", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# Datasets used in ims-model-fit-simple tutorial
datasets_to_extract <- c(
  "textbooks",
  "possum",
  "bdims",
  "mlbbat10",
  "county_complete"
)

cat("Extracting datasets from openintro package...\n\n")

for (ds_name in datasets_to_extract) {
  ds <- get(ds_name)
  file_path <- file.path("caldwell", "week4", "fit", "data", paste0(ds_name, ".rds"))
  saveRDS(ds, file_path)
  file_size <- file.size(file_path)
  cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
              paste0(ds_name, ".rds"),
              format(file_size, big.mark = ","),
              nrow(ds),
              ncol(ds)))
}

# Extract Batting dataset from Lahman (used for Rickey Henderson example)
cat("\nExtracting Batting dataset from Lahman package...\n\n")
Batting <- Lahman::Batting
file_path <- file.path("caldwell", "week4", "fit", "data", "Batting.rds")
saveRDS(Batting, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "Batting.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(Batting),
            ncol(Batting)))

cat("\n===========================================\n")
cat("All datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week4/
    └── fit/
        ├── ims-model-fit-simple.Rmd
        └── data/
            ├── textbooks.rds
            ├── possum.rds
            ├── bdims.rds
            ├── mlbbat10.rds
            ├── county_complete.rds
            └── Batting.rds
")
