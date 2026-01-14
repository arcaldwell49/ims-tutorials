# =============================================================================
# Extract datasets for ims-exd-para-slopes tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)
library(mosaicData)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week7", "exd-para-slopes", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

cat("Extracting datasets...\n\n")

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

# Extract SAT from mosaicData
ds <- mosaicData::SAT
file_path <- file.path(data_dir, "SAT.rds")
saveRDS(ds, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "SAT.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(ds),
            ncol(ds)))

cat("\n===========================================\n")
cat("All datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Note: The 'mpg' dataset comes from ggplot2 and is loaded automatically.\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week7/
    └── exd-para-slopes/
        ├── ims-exd-para-slopes.Rmd
        ├── css/
        │   └── style.css
        └── data/
            ├── mariokart.rds
            ├── babies.rds
            └── SAT.rds
")
