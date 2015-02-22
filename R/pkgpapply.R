#' Apply an operation over several packages.
#'
#' This function is meant to be used by R developers that have to make
#' simultaneous updates to many packages.
#'
#' @note
#' The argument \code{pkg} received by the function call on each iteration is
#' \code{devtools::as.package(pkg_path)}, which has a \code{$path} available
#' and whose other attributes originate directly from the package's DESCRIPTION
#' file.
#' @usage
#' pkgapply(c('package1', 'package2'), dir = '/root/dir', function(pkg) { ... })
#' # Using current directory.
#' pkgapply(c('package1', 'package2'), function(pkg) { ... })
#' # Auto-detect each directory which has a DESCRIPTION file in /root/dir.
#' pkgapply(dir = '/root/dir', function(pkg) { ... })
#' # Iterate over every auto-detected package in the current directory.
#' pkgapply(function(pkg) { ... })
#' @param packages character. A character vector of package names.
#'   These must be directories relative to \code{dir}.
#' @param dir character. The root directory on which to iterate over
#'   all the packages. By default, the current working directory.
#' @param f function. The function to apply to each package. 
#'   The argument the function receives is
#'   \code{devtools::as.package(pkg_path)}, where \code{pkg_path} is
#'   the absolute path of the package. The output of this will be a list
#'   with a \code{path} key, as well as keys corresponding to each
#'   element in the DESCRIPTION file (\code{title}, \code{version}, etc.).
#' @return A list where each element is the result of \code{f} applied
#'   to the respective package.
#' @importFrom devtools as.package
#' @seealso \code{\link[devtools]{as.package}}
#' @examples
#' \dontrun{
#'   # You can use pkgapply to iterate over each package and apply some
#'   # operation.
#'   pkgapply(c('package1', 'package2'), dir = '/root/dir', function(pkg) { ... })
#'   
#'   # If you leave the package names blank, it will loop over all directories
#'   # relative to `dir` that contain a DESCRIPTION file and are thus recognized
#'   # as being R packages.
#'   pkgapply(dir = '/root/dir', function(pkg) { ... })
#'
#'   # If you do not provide a directory, the current directory will be used.
#'   pkgapply(function(pkg) { ... })
#' }
pkgapply <- function(packages, dir = getwd(), f) {
  if (is.function(packages) && missing(f)) { f <- packages; packages <- NULL }
  if (is.function(dir)) { f <- dir; dir <- getwd() }

  if (missing(packages) || is.null(packages)) {
    packages <- Filter(is_package, list.files(dir, full.names = TRUE))
  } else { 
    packages <- vapply(packages, prefix_package, character(1), dir)
  }

  packages <- lapply(packages, sanitize_package)

  lapply(packages, f)
}

sanitize_package <- function(pkg) {
  stopifnot(is.character(pkg) || devtools::is.package(pkg))
  if (devtools::is.package(pkg)) { pkg }
  else { devtools::as.package(pkg) }
}

prefix_package <- function(pkg, dir) {
  if (!file.exists(pkg)) {
    pkg <- file.path(dir, pkg)
  }
  if (!file.exists(pkg)) {
    stop("No such package: ", sQuote(pkg), call. = FALSE)
  }
  pkg
}

is_package <- function(pkg) {
  file.exists(file.path(pkg, 'DESCRIPTION'))
}

