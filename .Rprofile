.CHECK_ALL <- function(rcpp = FALSE){
  files <- list.files("man", full.names = T)
  file.remove(files)
  file.remove("NAMESPACE")

  if(rcpp) {
    pkg_name <- as.package(".")$package
    devtools::document()
    
    con <- file("NAMESPACE", "r")
    line <- readLines(con)
    close(con)
    
    line <- c(line, paste0("useDynLib(", pkg_name, ")"), 
              "importFrom(Rcpp, evalCpp)")
    
    con <- file("NAMESPACE")
    writeLines(line, con)
    close(con)

    Rcpp::compileAttributes()
    .MODIFY_SRC_CODE()

    # code from devtools::check()
    withr::with_envvar(pkgbuild::compiler_flags(FALSE), action = "prefix", {
      built_path <- pkgbuild::build(
        as.package(".")$path, tempdir(),
        args = NULL, quiet = F, manual = F)
      on.exit(unlink(built_path), add = TRUE)
    })
    
    devtools::check_built(built_path,
      cran = T, remote = F, incoming = F, force_suggests = F,
      run_dont_test = F, manual = F, args = "--timings",
      env_vars = NULL, quiet = F, check_dir = tempdir(),
      error_on = "warning"
    )

  } else {
    devtools::document()
    devtools::check(document = F)
  }

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
