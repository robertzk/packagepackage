#' Iterative operations on a collection of packages.
#'  Useful for R developers with many packages to maintain.
#'
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
#' @name packagepackage
#' @import stringr
#' @docType package
NULL
