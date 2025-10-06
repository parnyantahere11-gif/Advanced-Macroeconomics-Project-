# 📦 Load necessary libraries
library(readr)
library(dplyr)
library(tidyr)

# Step 1: Load the filtered Eurostat CSV
file_path <- "/Users/taherehehsan/Desktop/new/estat_namq_10_fcs_filtered_en.csv"
data <- read_csv(file_path, show_col_types = FALSE)

# Step 2: Keep only Czech Republic
data_cz <- data %>% filter(geo == "CZ")

# Step 3: Select relevant columns
data_cz <- data_cz %>%
  select(
    time = TIME_PERIOD,
    na_item = `National accounts indicator (ESA 2010)`,
    values = OBS_VALUE
  )

# Step 4: Pivot to wide format
data_wide <- data_cz %>%
  pivot_wider(names_from = na_item, values_from = values)

# Step 5: Rename long labels to short codes
data_wide <- data_wide %>%
  rename(
    P311_S14_food_bev = `Final consumption expenditure of households, durable goods`,
    P312N_S14_non_durable_excl_food = `Final consumption expenditure of households, semi-durable goods, non-durable goods and services`
  )

# Step 6: Remove rows with missing values
data_wide <- data_wide %>%
  filter(!is.na(P311_S14_food_bev), !is.na(P312N_S14_non_durable_excl_food))

# Step 7: Save cleaned data
output_path <- "/Users/taherehehsan/Desktop/new/cz_clean_consumption.csv"
write.csv(data_wide, output_path, row.names = FALSE)

# Done
cat("Cleaned dataset saved as:", output_path)
