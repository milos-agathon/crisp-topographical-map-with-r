################################################################################
#                 How to create a crisp topographic map in R
#                 Milos Popovic
#                 2022/05/14
################################################################################

windowsFonts(georg = windowsFont('Georgia'))

# libraries we need
libs <- c("elevatr", "terra", "tidyverse", 
	"sf", "giscoR", "marmap")

# install missing libraries
installed_libs <- libs %in% rownames(installed.packages())
if (any(installed_libs == F)) {
  install.packages(libs[!installed_libs])
}

# load libraries
invisible(lapply(libs, library, character.only = T))

# 1. GET COUNTRY MAP
#---------

crsLONGLAT <- "+proj=longlat +datum=WGS84 +no_defs"

get_sf <- function(country_sf, country_transformed) {
	
	country_sf <- giscoR::gisco_get_countries(
    	year = "2016",
    	epsg = "4326",
    	resolution = "10",
    	country = "Italy")
	
	country_transformed <- st_transform(country_sf, crs = crsLONGLAT)

	return(country_transformed)
}

country_transformed <- get_sf() 

# 2. GET ELEVATION DATA
#---------

get_elevation_data <- function(country_elevation, country_elevation_df) {

	country_elevation <- get_elev_raster(
		locations = country_transformed, 
		z = 9, # Please decrease the z value if you experience R crashing
		clip = "locations") 

	country_elevation_df <- as.data.frame(country_elevation, xy = T) %>%
		na.omit()
	
	colnames(country_elevation_df)[3] <- "elevation"

	return(country_elevation_df)
}

country_elevation_df <- get_elevation_data()

# 3. MAP
#---------

map_url <- "https://github.com/milos-agathon/crisp-topographical-map-with-r/blob/main/R/map.r"
source(map_url) # load script

country_map <- get_elevation_map()

ggsave(filename="italy_topo_map.png", width=7, height=8.5, dpi = 600, device='png', country_map)
