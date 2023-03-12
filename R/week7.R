# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)



# Data Import and Cleaning
week7_tbl <- read_csv(file ="../data/week3.csv") %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>% 
  filter(q6 == 1) %>%
  select(!q6) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeSpent = as.numeric(difftime(timeEnd, timeStart, units = c("mins")))) 





# Visualization
GGally::ggpairs(week7_tbl[5:13]) 
#Scatterplots lower left, cor top right, density along diag = default

(ggplot(week7_tbl, aes(x = timeStart, y = q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score")) %>%
  ggsave(filename = "../figs/fig1.png", dpi = 600, width = 7, height = 5, units = "in") 


(ggplot(week7_tbl, aes(x = q1, y = q2, color = gender)) +
  geom_point(position = "jitter") +
  labs(color = "Participant Gender") + 
  coord_fixed()) %>%
  ggsave(filename = "../figs/fig2.png", dpi = 600, width = 7, height = 5, units = "in")
(ggplot(week7_tbl, aes(x = q1, y = q2)) +
  geom_point(position = "jitter") +
  facet_grid(cols = vars(gender))  + 
  coord_fixed() +
  labs(x = "Score on Q1", y = "Score on Q2")) %>%
  ggsave(filename = "../figs/fig3.png", dpi = 600, width = 7, height = 5, units = "in")


(ggplot(week7_tbl, aes(x = gender, y = timeSpent)) +
  geom_boxplot() + 
  labs(x = "Gender", y = "Time Elapsed (mins)")) %>%
  ggsave(filename = "../figs/fig4.png", dpi = 600, width = 7, height = 5, units = "in")


(ggplot(week7_tbl, aes(x = q5, y = q7, color = condition)) + 
  geom_point(position = "jitter") +
  geom_smooth(method = lm, se = FALSE) + 
  coord_fixed(ratio = 0.5) +
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition") +
  theme(legend.background = element_rect(fill = "#E0E0E0"), legend.position = "bottom")) %>% 
  ggsave(filename = "../figs/fig5.png", dpi = 600, width = 7, height = 5, units = "in")


#Waiting for Richard's Responses: Image Size, an difftime object
# Image size -> all figs with width and height would need to change.
# Cartesian coordinates not needed for the images here, but included for practice
# Line 15 -> mutate(timeSpent = difftime(timeEnd, timeStart, units = c("mins"))) 
# Line 43 -> y = as.numeric(timeSpent)