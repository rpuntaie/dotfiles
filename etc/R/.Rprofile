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
  menu.graphics = FALSE,

  useFancyQuotes = FALSE

  max.print = 1000
)

# enable autocompletions for package names in
utils::rc.settings(ipck = TRUE)

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

    options(prompt = "\033[34m> \033[39m")
    options("Ncpus" = 8L)

    if (file.exists("~/.Rprofile.local")) {
      source("~/.Rprofile.local")
    }

    options(warnPartialMatchAttr = TRUE,
            warnPartialMatchDollar = TRUE,
            warn = 1,
            warning.length = 8170) # 8170 is the maximum warning length

    options(max.print = 1000)
        # width = 175)

    # turn on completion of installed package names
    utils::rc.settings(ipck = TRUE)

    options(menu.graphics=FALSE) #graphics dialogs always seem to crash R
    options(vimcom.verbose = 1, vimcom.allnames = TRUE)
    # Start editor in existing neovim buffer
    # pi3 install neovim-remote
    options("editor" = "nvr")

    if(Sys.getenv("VIMRPLUGIN_TMPDIR") != "")
      library(vimcom)
    withOptions <- function(optlist, expr)
    {
      oldopt <- options(optlist)
      on.exit(options(oldopt))
      expr <- substitute(expr)
      eval.parent(expr)
    }

    less = function(x) {
      withOptions(list(pager='less', dplyr.print_min=.Machine$integer.max, width=10000, max.print=1e6), page(x, method='print'))
    }

    # Assign shortcuts to a hidden environment, so they don't show up in ls()
    # Idea from https://csgillespie.github.io/efficientR/set-up.html#creating-hidden-environments-with-.rprofile
    .env <- new.env()
    with(.env, {
        shortcut <- function(f) structure(f, class = "shortcut")
        print.shortcut <- function(f, ...) f(...)

        p <- shortcut(covr::package_coverage)

        rs <- shortcut(function(file = "script.R", echo = TRUE, ...) source(file, echo = echo, ...))

        li <- shortcut(library)
        l <- shortcut(devtools::load_all)

        i <- shortcut(devtools::install)
        gh <- shortcut(devtools::install_github)

        id <- shortcut(function(dependencies = TRUE, ...) {
            devtools::install_deps(dependencies = dependencies, ...)
            })

        ch <- shortcut(function(document = FALSE, ...) {
            devtools::check(document = document, ...)
            })
        d <- shortcut(devtools::document)

        t <- shortcut(
          test <- function(filter = NULL, length = 5, pkg = ".", ..., reporter = "progress") {
            devtools::test(pkg, filter, reporter = reporter, ...)
            })

        re <- shortcut(reprex::reprex)

        qt <- shortcut(function() {
              savehistory()
              base::q(save="no")
              })

        echo <- function(x) {
          cat(readLines(x), sep = "\n")
        }
    })
    library(colorout)
    library(formatR)
    # We need to attach stats before .env to shadow qt
    library(stats)
    suppressMessages(attach(.env))

    # helper function to convert a data frame print output to an actual data frame
    .env$convert_data.frame <- function(x) {
      lines <- strsplit(x, "\n")[[1]]

      locs <- rex::re_matches(lines[1], rex::rex(non_spaces), global = TRUE, locations = TRUE)[[1]]

      rowname_size <- rex::re_matches(lines[length(lines)], rex::rex(non_spaces), locations = TRUE)

      starts <- c(rowname_size$end + 1, locs$end[-length(locs$end)] + 1)
      ends <- locs$end

      remove_whitespace <- function(x) {
        re_substitutes(x, rex::rex(list(start, any_spaces) %or% list(any_spaces, end)), '', global = TRUE)
      }

      fields <- lapply(lapply(lines, substring, starts, ends), remove_whitespace)

      df <- as.data.frame(matrix(unlist(fields[-1]), ncol = length(fields[[1]]), byrow = TRUE), stringsAsFactors = FALSE)
      df[] <- lapply(df, type.convert, as.is=TRUE)
      colnames(df) <- fields[[1]]
      df
    }

    .env$shuf <- function(x, n = 6) {
      if (is.null(dim(x))) {
        x[sample.int(length(x), min(n, length(x)))]
      } else {
        x[sample.int(NROW(x), min(n, NROW(x))), , drop = FALSE]
      }
    }

    .env$`%>%` <- magrittr::`%>%`

    invisible({
      # devtools::install_github("gaborcsard/notifier")
      notify_long_running <- function(second_cutoff = 20) {
        last <- proc.time()[1]
        function(expr, value, ok, visible) {
          duration <- proc.time()[1] - last
          if (duration > second_cutoff) {
            notifier::notify(msg = paste0(collapse = " ", deparse(expr)), title = sprintf("Completed in %.02f (s)", duration))
          }
          last <<- proc.time()[1]
          TRUE
        }
      }

      addTaskCallback(notify_long_running())
    })

    # jimhester/lookup
    suppressPackageStartupMessages(library(lookup))

    # jimhester/autoinst
    options(error = autoinst::autoinst)

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

options(
  devtools.desc.license = "GPL-3",
  covr.gcov = Sys.which("gcov")
  # usrstuff:
  devtools.name = "Roland Puntaier",
  devtools.desc.author = 'person("Roland", "Puntaier", email = "roland.puntaier@gmail.com", role = c("aut", "cre"))',
)

if(interactive()){
}

