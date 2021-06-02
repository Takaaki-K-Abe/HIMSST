# libraries
library(mapdata)
library(tidyverse)
library(knitr)
library(spatstat)
library(maptools)
library(raster)

# 関数のロード
source("functions/himsst_dl.R")
source("functions/return_himsst_fname.R")
source("functions/loadHIMSST.R")
source("functions/extractSST.R")

# 日付
stdate = as.Date("2020-01-01")
enddate = as.Date("2020-02-01")
dats <- seq(stdate, enddate, by = "day")

sapply(dats, himsst_dl)

## 水温の図の作成

fname = return_himsst_fname(dats[10])

SST <- loadHIMSST(fname)

Latrange = c(30, 40)
Lonrange = c(130, 145)

mapdat <- map_data("world") 

ggplot() + geom_raster(data = SST, aes(x=lon, y=lat, fill=sst)) +
  coord_fixed( xlim=Lonrange, ylim=Latrange )

