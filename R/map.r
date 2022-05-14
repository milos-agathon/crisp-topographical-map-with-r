# 3. MAP
#---------

get_elevation_map <- function(country_map) {

	country_map <- ggplot() +
  		geom_tile(data = country_elevation_df, 
  			aes(x = x, y = y, fill = elevation)) +
  		scale_fill_etopo() +
  		coord_sf(crs = crsLONGLAT)+
  		theme_minimal() +
  		theme(text = element_text(family = "georg", color = "#22211d"),
    		axis.line = element_blank(),
    		axis.text.x = element_blank(),
    		axis.text.y = element_blank(),
    		axis.ticks = element_blank(),
    		axis.title.x = element_blank(),
    		axis.title.y = element_blank(),
    		legend.position = "none",
   		  	panel.grid.major = element_line(color = "white", size = 0.2),
    		panel.grid.minor = element_blank(),
    		plot.title = element_text(size=18, color="grey20", hjust=1, vjust=-5),
    		plot.caption = element_text(size=8, color="grey70", hjust=.15, vjust=20),
    		plot.margin = unit(c(t=0, r=0, b=0, l=0),"lines"), #added these narrower margins to enlarge maps
    		plot.background = element_rect(fill = "white", color = NA), 
    		panel.background = element_rect(fill = "white", color = NA),
    		panel.border = element_blank()) +
		labs(x = "", 
    		y = NULL, 
    		title = "Topographic map of ITALY", 
    		subtitle = "", 
    		caption = "©2022 Milos Popovic (https://milospopovic.net)")

	return(country_map)
}
