# AUTHOR:       Kirstin Lyon
# DATE:         2025-06-17
# VERSION:      1.0
# PURPOSE:      Fetch and clean data for Enhanced Geographical Analysis (Mozambique)
# LICENSE:      MIT License
# DEPENDENCIES: tidyverse, janitor
# INPUT:        Raw PEPFAR EGA data file (CSV or Excel)
# OUTPUT:       Cleaned and filtered CSV file for Mozambique
# NOTES:        Filters only Mozambique data; assumes standard PEPFAR EGA schema
# USAGE:        Run script in R environment with dependencies installed
# CONTACT:      kirstin.lyon@example.com
# CHANGES:      2025-06-17 - Initial version




library(tidyverse)
library(janitor)

 DATA <- "Data/Enhanced_Geographical_Analysis.txt"
 INDICATORS <- c("TX_NEW","HTS_TST","HTS_TST_POS", "TB_STAT", "TB_STAT_POS")
 EXCLUDE_FISCAL_YEAR <- c("2016", "2017", "2018")



SADC_COUNTRY <- c("Angola", 
                                       "Botswana",
                                      "Comoros", # not in dataset
                                       "Democratic Republic of the Congo",
                                       "Eswatini", 
                                       "Lesotho", 
                                       "Madagascar", #not in dataset
                                       "Malawi", 
                                       "Mauritius", #not in dataset
                                       "Mozambique", 
                                       "Namibia", 
                                       "Seychelles", #not in dataset
                                       "South Africa",
                                       "Tanzania", 
                                       "Zambia", 
                                       "Zimbabwe")











EXCLUDE_FISCAL_YEAR <- c("2016", "2017", "2018", "2019")


 prep_data <- function(data){
         temp <- data |> 
                 select(-matches(EXCLUDE_FISCAL_YEAR)) |> 
             pivot_longer(cols = matches("results$"), names_to = "period", values_to = "value") |> 
                 separate(period, into = c("fiscal_year", "period_type", "quarter", "misc"), sep = "_", fill = "right") |> 
                 select(-c(period_type, misc)) |> 
         
         
                 mutate(fiscal_year = str_remove(fiscal_year, "^x"),
                                         period = paste0(fiscal_year, " Q", quarter)
                                         ) |> 
                 select(-c(fiscal_year, quarter))
     
             
             return(temp)
     }



# LOAD AND CLEAN DATA ---------------------------------------------------------
 my_data <- read_tsv(DATA) |> 
         clean_names() |> 
         filter(indicator %in% INDICATORS,
                             country %in% SADC_COUNTRY
                             ) |> 
         select (-c(operating_unit, iso3,
                                     sub_national_unit_3_uid,
                                     sub_national_unit_2_uid,
                                     sub_national_unit_1_uid,
                                     sub_national_unit_3,
                                     sub_national_unit_2,
                                     sub_national_unit_1,
                                     modality
                                     )) |> 
        mutate(indicator = case_when(indicator == "TB_STAT" ~ paste(indicator, numerator_denominator, sep = "_"),
                                                                             .default = indicator)
                             ) |> 
         select(-numerator_denominator) |> 
         group_by(country, indicator, description) |>
         summarise(across(matches("Results$"), ~sum(.x, na.rm = TRUE)), .groups = "drop") |> 
         prep_data() 



 write_csv(my_data, "Dataout/clean_pepfar_test_data.csv")