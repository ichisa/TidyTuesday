# Get the Data

african_names <- readr::read_csv(
  'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-16/african_names.csv')

# Libraries

library(ggplot2)
library(tidyverse)
library(RColorBrewer)
library(wordcloud2)
#library(tm)

unique(african_names$ship_name)

african_names$b <- sapply(strsplit(african_names$name, " "), 
                          function(x) x[which.max(nchar(x))])

df <- african_names %>% group_by(b) %>% 
  summarise(freq= n()) %>% 
  filter(freq>2 & !b =="Unknown")

df <- df[order(-df$freq),][c(1:80),]

wordcloud2(df)

