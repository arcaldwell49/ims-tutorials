# Run this script once locally to extract the datasets
# Place the resulting .rds files in the same directory as your tutorial

library(openintro)

# Save datasets as RDS files
saveRDS(hsb2, here::here("caldwell","week1","hsb2.rds"))
saveRDS(email50, here::here("caldwell","week1","email50.rds"))

cat("Datasets saved successfully!\n")
cat("hsb2.rds:", format(file.size("hsb2.rds"), big.mark = ","), "bytes\n
email50.rds:", format(file.size("email50.rds"), big.mark = ","), "bytes\n")
