.CHECK_ALL <- function(rcpp = FALSE){
  files <- list.files("man", full.names = T)
  file.remove(files)
  
  if(rcpp) Rcpp::compileAttributes()  
  devtools::check(cran = T)

  invisible()
}

.LOAD_ALL <- function(nuke = FALSE){
  if(nuke) rm(list = ls(globalenv()), envir = globalenv())
  library(devtools)
  library(testthat)
  devtools::load_all()
  x <- list.files("data-raw", pattern = "*source*.R$", full.names = T)
  if(length(x) > 0){
     for(i in x){source(i)}
  }

  invisible()
}

.TEST_ALL <- function(){
  devtools::test()

  invisible()
}

options(stringsAsFactors=FALSE)

q <- function (save = "no", status = 0, runLast = TRUE)
.Internal(quit(save, status, runLast))
