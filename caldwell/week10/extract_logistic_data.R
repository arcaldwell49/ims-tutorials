# =============================================================================
# Extract datasets for ims-logistic tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

library(openintro)
library(Stat2Data)

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week10", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

cat("Extracting datasets...\n\n")

# Extract heart_transplant from openintro
ds <- openintro::heart_transplant
file_path <- file.path(data_dir, "heart_transplant.rds")
saveRDS(ds, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "heart_transplant.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(ds),
            ncol(ds)))

# Extract MedGPA from Stat2Data
data(MedGPA, package = "Stat2Data")
file_path <- file.path(data_dir, "MedGPA.rds")
saveRDS(MedGPA, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n",
            "MedGPA.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(MedGPA),
            ncol(MedGPA)))

cat("\n===========================================\n")
cat("All datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week10/
    ├── ims-logistic.Rmd
    └── data/
        ├── heart_transplant.rds
        └── MedGPA.rds
")
