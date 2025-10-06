# ============================================
# Advanced Macroeconomics Winter 2024/2025
# Example 4.3
# Load and Clean PWT Data
# This version: 2023-10-13
# ============================================

# Load packages -----
library(tidyverse)
library(readxl)
library(this.path)

# Set working directory to this script's directory -----
MyDir <- this.dir()
setwd(MyDir)

# Load PWT Excel File -----
PWT1001_Untidy <- read_excel(path = "../../data/PWT1001.xlsx",
                             sheet="Data",
                             range="A1:AZ12811",
                             col_types = c(rep("text",3),
                                           rep("numeric",29),
                                           rep("text",5),
                                           rep("numeric",15))
)

# Clean PWT Data and Save to CSV -----
PWT1001 <- PWT1001_Untidy %>% 
  mutate(country = str_remove(country, ","),
         currency_unit = str_remove(currency_unit, ",")) %>% 
  select(-i_cig, -i_xm, -i_xr, -i_outlier, -i_irr)

write.csv(PWT1001, file = "../../data/PWT1001clean.csv", row.names = FALSE, fileEncoding = "UTF-8")

# Clean PWT Data and Save Small Data Set to CSV
MyCountries <- c("DEU", "USA", "GBR", "JPN", "FRA", "ITA", "CAN")
PWT1001 <- PWT1001_Untidy %>% 
  filter(countrycode %in% MyCountries) %>% 
  mutate(country = str_remove(country, ","),
         currency_unit = str_remove(currency_unit, ",")) %>% 
  select(countrycode, country, currency_unit, year,
         emp, rkna, rnna, rgdpna, rconna, labsh, csh_i, delta)

write.csv(PWT1001, file = "../../data/PWT1001small.csv", row.names = FALSE, fileEncoding = "UTF-8")

