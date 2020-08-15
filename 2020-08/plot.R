# Tidy Tuesday August, 2020#
# Elisa Schneider #

# Libraries
library(tidyverse)
library(ggplot2)
library(gridExtra)

# Data
penguins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins.csv')

# Restructure data

penguins_long <- gather(penguins, 'variable','value', 3:5)

penguins_long$names <- case_when(
  penguins_long$variable == "flipper_length_mm" ~ "Flipper Length (mm)",
  penguins_long$variable == "bill_depth_mm" ~ "Bill Depth (mm)",
  penguins_long$variable == "bill_length_mm" ~ "Bill Length (mm)")

# Theme ggplot

my_theme <- theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(fill = 'lightgray', 
                                                  colour = 'lightgray'),
                  plot.background = element_rect(fill = 'lightgray', 
                                                 colour = 'lightgray'))

p1 <- penguins_long %>% ggplot(aes(fill = species)) +
  geom_density(aes(value), alpha = 0.5) +
  geom_rug(aes(value))+
  facet_grid(species~names, scales = "free") +
  theme_minimal() +
  ylab ("Density") +
  xlab("Value") +
  scale_fill_manual(values = c("darkorange","darkorchid","cyan4")) +
  my_theme +
  theme(legend.position = "none")

p1

# Image

l1 <- grid::rasterGrob(png::readPNG("fig/penguins.png"), 
                      interpolate = TRUE)

p2 <- ggplot(mapping = aes(x = 0:1, y = 0:1)) +
  theme_void() +
  annotation_custom(l1, xmin = .02, xmax = 1, ymin = 0, ymax = 1) +
  my_theme
p2


# Plot + image

gridExtra::grid.arrange(p1, p2, widths = c(.7, .3), ncol = 2) 

