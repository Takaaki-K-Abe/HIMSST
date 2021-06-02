# NOAAからのSSTデータのダウンロード
# 参考url https://hansenjohnson.org/post/sst-in-r/

return_himsst_fname <- function(date){
  # 年月日
  ymd = format(date, '%Y%m%d')
  nc_fname <- paste0("him_ssts/him_sst_pac_D", ymd, ".txt")
  return(nc_fname)
}