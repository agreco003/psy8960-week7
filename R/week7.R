# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv(file ="../data/week3.csv") %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>% 
  filter(q6 == 1) %>%
  select(!q6) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeSpent = as.numeric(difftime(timeEnd, timeStart, units = c("mins"))))




# Visualization
ggpairs(week7_tbl[5:13]) #Scatterplots lower left, cor top right, density along diag = default


(ggplot(week7_tbl, aes(x = timeStart, y = q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score")) %>%
  ggsave(filename = "../figs/fig1.png", dpi = 600, width = 7, height = 5, units = "in") 


(ggplot(week7_tbl, aes(x = q1, y = q2, color = gender)) +
  geom_point(position = "jitter") +
  labs(color = "Participant Gender")) %>%
  ggsave(filename = "../figs/fig2.png", dpi = 600, width = 7, height = 5, units = "in")

(ggplot(week7_tbl, aes(x = q1, y = q2)) +
  geom_point(position = "jitter") +
  labs(x = "Score on Q1", y = "Score on Q2") +
  facet_grid(cols = vars(gender))) %>%
  ggsave(filename = "../figs/fig3.png", dpi = 600, width = 7, height = 5, units = "in")


ggplot(week7_tbl, aes(x = gender, y = timeSpent)) +
  geom_boxplot() + 
  labs(x = "Gender", y = "Time Elapsed (mins)")