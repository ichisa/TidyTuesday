
standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/standings.csv')

library(ggplot2)
library(viridis)
library(rayshader)

team_ranking = ggplot(standings, aes(x=offensive_ranking, y=defensive_ranking)) + 
  stat_density_2d( aes(fill = stat(level)),geom = "polygon", n = 100, bins = 10, contour = TRUE) +
  scale_fill_viridis_c(option = "A") + 
  xlab("Offensive Ranking") +
  ylab("Defensive Ranking") +
  labs(fill = "Density") +
  ggtitle("NFL Team Characteristics")#+
  #guides(fill = guide_legend(title = "Density", title.position = "bottom"))
team_ranking

plot_gg(team_ranking, width = 5, height = 5, raytrace = FALSE, preview = TRUE)
plot_gg(team_ranking, width = 5, height = 5, multicore = TRUE, scale = 250, 
        zoom = 0.7, theta = 10, phi = 30, windowsize = c(800, 800))

render_depth(focus = 0.68, focallength = 200)

Sys.sleep(0.2)

render_snapshot(clear = TRUE)

