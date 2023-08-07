# ---------------------------
#
# Script name: DataGraphics (1) Heatmap
#
# Purpose of script: This script generates a heatmap for schools using Google API and ggmaps
#
# Authors: Kalahan Hughes
#
# Date Created: April 25, 2023
#
# Noteable Variables: 
# ---------------------------
library(ggplot2)
library(ggmap)
library(here)

merged_df = read.csv(here('data','merged_df'))
sierraleone = merged_df %>% filter(country == 'Sierra Leone')
coords.data = data.frame('Latitude' = sierraleone$school_lat.x, 'Longitude' = sierraleone$school_lon.x)


#ggplot() +
  #geom_point(data = coords.data, aes(x = Longitude, y = Latitude), alpha = .05,show.legend = FALSE)


ggmap::register_google(key = "",write = TRUE) #insert a Google API key here!
heatmap = get_googlemap(center = c(-11.854449,8.892542), zoom = 8,maptype = "hybrid") %>% ggmap(extent = 'device')

heatmap = heatmap + stat_density2d(data=coords.data,  aes(x=Longitude, y=Latitude, fill=..level.., alpha=..level..), geom="polygon") + theme(axis.line = element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x=element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        plot.margin = unit(c(0.1,0.1,0.1,0.1), "cm"),
        legend.position = "none")
plot(heatmap)
ggsave(filename="./coords.png")
