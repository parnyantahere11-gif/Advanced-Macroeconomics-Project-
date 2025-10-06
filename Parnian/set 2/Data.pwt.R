# Load necessary libraries
library(tidyverse)
library(readxl)

# Load full PWT Excel file
PWT1001 <- read_excel("/Users/taherehehsan/Desktop/new/pwt1001.xlsx", sheet = "Data")

# Filter only India (IND)
PWT_IND <- PWT1001 %>%
  filter(countrycode == "IND") %>%
  select(year, rgdpe, csh_i)

# Save as CSV
write.csv(PWT_IND, file = "pwt1001_IND.csv", row.names = FALSE)

