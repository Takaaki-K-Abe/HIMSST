library(stringr)

loadHIMSST <- function(fname){

  # load txt file
  raw <- read_csv(fname, col_types="c")

  # 3文ずつデータを区切るので、開始位置と終了位置を指定する
  starray <- seq(1, 2398, by=3)
  endarray <- seq(3, 2400, by=3)

  # リストに文字配列を格納する
  data <- list()
  for(row in 1:600){
    # 文字列を抽出する
    sst <- str_sub(raw[row,], starray, endarray)
    # 文字列を数値に変える（3文字のうち最後の文字は小数点1位を示すので10で割っている）
    sst <- sapply(sst, as.numeric)/10
    data[[row]] <- sst
  }

  # sstを 配列に変える
  sst <- unlist(data)

  lat <- unlist(lapply(seq(59.95, 0.05, by=-0.1), rep, times=800))
  lon <- rep(seq(100.05, 179.95, by=0.1), times=600)

  SST <- tibble(sst, lat, lon)　%>%
    # 余計なデータをNAに置換する
    mutate(
      sst = na_if(sst, 88.8),
      sst = na_if(sst, 99.9)
    ) %>% as.data.frame(.)

    return(SST)
}
