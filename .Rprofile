.CHECK_ALL <- function(rcpp = FALSE){
  files <- list.files("man", full.names = T)
  file.remove(files)
  file.remove("NAMESPACE")

  if(rcpp) {
    pkg_name <- .GRAB_PKG_NAME()
    line <- paste0("useDynLib(", pkg_name, ", .registration=TRUE)",
                   "\nexportPattern(\"^[[:alpha:]]+\")", "\nimport(Rcpp)")
    write(line, file = "NAMESPACE")
    unlink("data")

    Rcpp::compileAttributes()
    .MODIFY_SRC_CODE()

    if(file.exists(".extension")){
      con <- file(".extension", "r")
      line <- readLines(con)
      close(con)
      write(line, file = "NAMESPACE", append = T)
    }

    devtools::document()

    .MODIFY_SRC_CODE()
    withr::with_envvar(devtools:::compiler_flags(FALSE), action = "prefix",
                       {path <- .CUSTOM_BUILD()})
    path <- tools::file_path_as_absolute(path)
    devtools::check_built(path, cran = TRUE, check_version = TRUE,
                force_suggests = FALSE, run_dont_test = FALSE,
                manual = FALSE, args = NULL,
                env_vars = c("_R_CHECK_CRAN_INCOMING_" = FALSE),
                quiet = FALSE,
                check_dir = tempdir())

  } else {
    devtools::document()
    devtools::check(document = F)
  }

  invisible()
}

# based on the devtools::build() function
.CUSTOM_BUILD <- function (pkg = ".", path = "..", vignettes = TRUE,
                           manual = FALSE, args = NULL, quiet = FALSE) {
  pkg <- devtools::as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }
  devtools:::check_build_tools(pkg)

  args <- c(args, "--no-resave-data")
  if (manual && !has_latex(verbose = TRUE)) {
    manual <- FALSE
  }
  if (!manual) {
    args <- c(args, "--no-manual")
  }
  if (!vignettes) {
    args <- c(args, "--no-build-vignettes")
  }
  cmd <- paste0("CMD build ", shQuote(pkg$path), " ", paste0(args,
                                                             collapse = " "))
  ext <- ".tar.gz"

  withr::with_temp_libpaths(devtools:::R(cmd, path, quiet = quiet))
  targz <- paste0(pkg$package, "_", pkg$version, ext)
  file.path(path, targz)
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

.GRAB_PKG_NAME <- function(){
  con <- file("DESCRIPTION", open="r")
  line <- readLines(con)
  close(con)

  line <- line[1]
  line <- strsplit(line, split = ": ")[[1]]
  line[2]
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
