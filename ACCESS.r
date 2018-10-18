library(raster)
f <- "/perm_storage/data/ocean_bgc.nc-20910630"
nc <- ncdf4::nc_open(f)
xt_ocean <- ncdf4::ncvar_get(nc, "xt_ocean")
xoffset <- which(xt_ocean>0)[1]
xshift <- c(seq(xoffset, length(xt_ocean)), seq(1, xoffset-1))
x360 <- seq(xt_ocean[xoffset], by = mean(diff(xt_ocean)), length.out = length(xt_ocean))
yt_ocean <- ncdf4::ncvar_get(nc, "yt_ocean")
time <- ncdf4::ncvar_get(nc, "time")

## visit by time
itime <- 1
set_index <- function(x) {
  setExtent(x, raster::extent(0, ncol(x), 0, nrow(x)))
}
b <- set_index(brick(f, level = itime, lvar = 4, varname = "zoo", ncdf = TRUE, stopIfNotEqualSpaced = FALSE))
image(x360, yt_ocean, t(as.matrix(flip(zoo, "y")))[xshift, ])
maps::map("world2", add = TRUE)
