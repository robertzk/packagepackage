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
#' @importFrom devtools as.package
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
  if (is.function(packages) && missing(f)) { f <- packages }
  if (is.function(dir)) { f <- dir; dir <- getwd() }

}