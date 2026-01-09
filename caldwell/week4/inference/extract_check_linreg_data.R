# =============================================================================
# Extract datasets for ims-check-simple-linreg tutorial
# Run this script ONCE locally to create the data files
# =============================================================================

# Create data directory if it doesn't exist
data_dir <- file.path("caldwell", "week4", "inference", "data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# -------------------------------------------------------------------------
# Dataset 1: movies03 (from Rossman/Chance ISCAM)
# Source: http://www.rossmanchance.com/iscam2/data/movies03.txt
# -------------------------------------------------------------------------
cat("Downloading movies03 dataset...\n")
movies03 <- read.delim("http://www.rossmanchance.com/iscam2/data/movies03.txt")
file_path <- file.path("caldwell", "week4", "inference", "data", "movies03.rds")
saveRDS(movies03, file_path)
cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n", 
            "movies03.rds",
            format(file.size(file_path), big.mark = ","),
            nrow(movies03),
            ncol(movies03)))

# -------------------------------------------------------------------------
# Dataset 2: starbucks
# This dataset should be in your original data folder
# If you have it as a .txt file, load it first
# -------------------------------------------------------------------------
cat("\nNote: You need to provide the starbucks dataset.\n")
cat("If you have starbucks.txt, run the following:\n")
cat('
starbucks <- read.delim("path/to/starbucks.txt")
file_path <- file.path("caldwell", "week4", "inference", "data", "starbucks.rds")
saveRDS(starbucks, file_path)
')

# If starbucks is available in openintro package:
if (requireNamespace("openintro", quietly = TRUE)) {
  library(openintro)
  if (exists("starbucks", where = "package:openintro")) {
    starbucks <- openintro::starbucks
    file_path <- file.path("caldwell", "week4", "inference", "data", "starbucks.rds")
    saveRDS(starbucks, file_path)
    cat(sprintf("%-20s: %s bytes (%d rows x %d cols)\n", 
                "starbucks.rds",
                format(file.size(file_path), big.mark = ","),
                nrow(starbucks),
                ncol(starbucks)))
  }
}

cat("\n===========================================\n")
cat("Datasets saved to", data_dir, "\n")
cat("===========================================\n\n")

cat("Your tutorial directory should look like:\n")
cat("
caldwell/
└── week4/
    └── inference/
        ├── ims-check-simple-linreg.Rmd
        └── data/
            ├── movies03.rds
            └── starbucks.rds
")

cat("\n")
cat("NOTE: This tutorial generates most of its data programmatically\n")
cat("using set.seed() for reproducibility. Only the movies03 and\n
starbucks datasets need to be provided as external files.\n")
