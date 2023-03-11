# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)



# Data Import and Cleaning
week7_tbl <- read_csv(file ="../data/week3.csv") %>%
  mutate(condition = case_match(condition, "A" ~ "Block A", "B" ~ "Block B", "C" ~ "Control")) %>%
  mutate(gender = case_match(gender, "M" ~ "Male", "F" ~ "Female")) %>% 
  #rename(Condition = condition) %>%
  #rename(Gender = gender) %>%
  filter(q6 == 1) %>%
  select(!q6) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = c("mins")))





