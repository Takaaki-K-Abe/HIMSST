# NOAAからのSSTデータのダウンロード
# 参考url https://hansenjohnson.org/post/sst-in-r/

# 最初に自己定義関数を作成する
# --------------------------------------
# function: download sst data (nc) from NOAA
# arguments:
# dat: datetime
# --------------------------------------
himsst_dl <- function(dat){

  # 年月日の文字列取得
  ymd = format(dat, '%Y%m%d')
  # 年月の文字列取得
  year = format(dat, '%Y')
  
  # assemble url to query NOAA database
  url_base = paste0(
    "http://www.data.jma.go.jp/gmd/goos/data/pub/JMA-product/him_sst_pac_D/",
    year
  )
  # fileの名前
  data_file = paste0("him_sst_pac_D", ymd, ".txt")
  
  # define data url
  data_url = paste0(url_base, "/", data_file)
  
  # directory
  dir = "him_ssts"
  if(!file.exists(dir)){
    dir.create(dir)
  }

  # データを格納するpath
  data_dir = paste0(dir, "/", data_file)
  
  # download netcdf
  # if文でデータがあるかどうかをチェック。ない場合のみダウンロードする
  if(!file.exists(data_dir)){
    download.file(url = data_url, destfile = data_dir)
  } else {
    message('SST data already downloaded! Located at:\n', data_file)
  }
}
# --------------------------------------