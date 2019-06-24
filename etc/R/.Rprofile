options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  menu.graphics = FALSE,

  warn = 1,
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE,
  showWarnCalls = TRUE,
  showErrorCalls = TRUE,

  datatable.print.class = TRUE,
  datatable.print.colnames = "top",
  pillar.subtle = FALSE,
  pillar.neg = FALSE,
  readr.num_columns = 0L,
  readr.show_progress = FALSE,

  ggplot2.continuous.colour = "viridis",
  ggplot2.continuous.fill = "viridis",

  testthat.default_check_reporter = "progress",
  menu.graphics = FALSE
)

.First = function() {
  if (interactive()) {
    stopifnot(dir.exists(Sys.getenv("R_LIBS_USER")))
    cran = c("tidyverse", "devtools")
    options(defaultPackages = c(getOption("defaultPackages"), cran))
    utils::loadhistory(file = Sys.getenv("R_HISTFILE"))
    print(utils::sessionInfo(), locale = FALSE)
    cat("Loading:", cran, "\n")
    setHook(packageEvent("grDevices", "onLoad"), function(...) {
      grDevices::pdfFonts(
        serif = grDevices::pdfFonts()$Palatino,
        mincho = grDevices::pdfFonts()$Japan1,
        gothic = grDevices::pdfFonts()$Japan1GothicBBB
      )
    })
    setHook(packageEvent("tibble", "attach"), function(...) {
      registerS3method("print", "tbl_df", wtl::printdf)
      registerS3method("print", "tbl", wtl::printdf)
    })
    setHook(packageEvent("wtl", "attach"), function(...) {
      ggplot2::theme_set(wtl::theme_wtl())
      wtl::adjust_print_options()
      mc.cores = parallel::detectCores(logical = FALSE)
      options(mc.cores = mc.cores)
      Sys.setenv(MAKEFLAGS = paste0("-j", min(mc.cores, 4L)))
    })
  }
}

.Last = function() {
  try({
    if (interactive()) {
      utils::savehistory(file = Sys.getenv("R_HISTFILE"))
      print(ls(envir = .GlobalEnv, all.names = TRUE))
      print(utils::sessionInfo(), locale = FALSE)
    }
  })
}
