
# dataframeをrasterに変換する
# data.frameには`lon`, `lat`, `sst`の変数を入れておくこと
sstdf2raster <- function(df){
  spg <- tibble(df) %>%
    dplyr::select(lon, lat, sst) %>%
    rename(　x=lon, y=lat ) %>% as.data.frame(.)

  sp::coordinates(spg) <- ~ x + y
  sp::proj4string(spg)=CRS("+init=epsg:4326")
  spg <- sp::spTransform(spg, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
  sp::gridded(spg) = TRUE
  rasterDF <- raster::raster(spg)
  return(rasterDF)
}
