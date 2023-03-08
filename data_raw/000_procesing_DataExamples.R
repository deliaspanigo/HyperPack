# data-raw/mydataset.R
# Data import and processing pipeline

library(readr)
library(readxl)

Hyp_Base01 <- read_excel("data_raw/Hyp_Base01.xlsx")
Hyp_Base01 <- as.data.frame(Hyp_Base01)

# demographics <- read_excel("data-raw/Demographics.xlsx")

# Data cleaning code here...
# (Do NOT put data analysis code here!)

# This should be the last line.
# Note that names are unquoted.
# I like using overwrite = T so everytime I run the script the
# updated objects are saved, but the default is overwrite = F
# usethis::use_data(mydataset, demographics, overwrite = T)
usethis::use_data(Hyp_Base01, overwrite = T)
