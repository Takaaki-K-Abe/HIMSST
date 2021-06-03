# libraries
library(mapdata)
library(readr)
library(knitr)
library(ggplot2)
library(dplyr)
library(maptools)
library(raster)

# 関数のロード
source("functions/himsst_dl.R")
source("functions/return_himsst_fname.R")
source("functions/loadHIMSST.R")
source("functions/extractSST.R")
source("functions/sstdf2raster.R")

# 日付
stdate = as.Date("2020-01-01")
enddate = as.Date("2020-02-01")
dats <- seq(stdate, enddate, by = "day")

sapply(dats, himsst_dl)

## 水温の図の作成

fname = return_himsst_fname(dats[10])

SST <- loadHIMSST(fname)
rasterDF <- sstdf2raster(SST)

spg <- tibble(SST)
spg <- spg %>%
  dplyr::select(lon, lat, sst) %>%
  rename( x=lon, y=lat ) %>% as.data.frame(.)

coordinates(spg) <- ~ x + y
proj4string(spg)=CRS("+init=epsg:4326")
spg <- spTransform(spg, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
gridded(spg) = TRUE
rasterDF <- raster(spg)

lon=rep(142, 10)
lat=seq(30, 31, length=10)
coordxy <- data.frame(lon, lat)
raster::extract(rasterDF, coordxy, sp =T)

Latrange = c(30, 40)
Lonrange = c(130, 145)

mapdat <- map_data("world") 
ggplot() + geom_raster(data = SST, aes(x=lon, y=lat, fill=sst)) +
  coord_fixed( xlim=Lonrange, ylim=Latrange )

