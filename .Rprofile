.CHECK_ALL <- function(rcpp = FALSE){
  files <- list.files("man", full.names = T)
  file.remove(files)
  file.remove("NAMESPACE")
  
  devtools::document()

  if(rcpp) {
    pkg_name <- devtools::as.package(".")$package
    
    # modify the NAMESPACE
    con <- file("NAMESPACE", "r")
    line <- readLines(con)
    close(con)
    
    line <- c(line, paste0("useDynLib(", pkg_name, ")"), 
              "importFrom(Rcpp, evalCpp)")
    
    con <- file("NAMESPACE")
    writeLines(line, con)
    close(con)

    # reformat the Rcpp code
    Rcpp::compileAttributes()
    .MODIFY_SRC_CODE()
  } 
  
  devtools::check(document = F)

  invisible()
}

.MODIFY_SRC_CODE <- function(){
  if(!file.exists("R/RcppExports.R")) return()

  con <- file("R/RcppExports.R", "r")
  line <- readLines(con)
  close(con)

  idx <- grep("^c_.*<- function", line)
  if(length(idx) > 0){
    for(i in idx){
      line[i] <- paste0(".", line[i])
    }

    con <- file("R/RcppExports.R")
    writeLines(line, con)
    close(con)
  }

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
