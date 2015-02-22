Iterating over R packages [![Build Status](https://travis-ci.org/robertzk/packagepackage.svg?branch=master)](https://travis-ci.org/robertzk/packagepackage.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/robertzk/packagepackage/badge.svg?branch=master)](https://coveralls.io/r/robertzk/packagepackage)
===========

Iterative operations on a collection of packages.
Useful for R developers with many packages to maintain.

# Installation

This package is not yet available from CRAN (as of February 21, 2015).
To install the latest development builds directly from GitHub, run this instead:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("robertzk/packagepackage")
```

# Usage

You can use pkgapply to iterate over each package and apply some operation.

```r
pkgapply(c('package1', 'package2'), dir = '/root/dir', function(pkg) { ... })
```

If you leave the package names blank, it will loop over all directories
relative to `dir` that contain a DESCRIPTION file and are thus recognized
as being R packages.

```r
pkgapply(dir = '/root/dir', function(pkg) { ... })
```

If you do not provide a directory, the current directory will be used.

```r
pkgapply(function(pkg) { ... })
```

In each example ,`pkg` will be the result of taking the package directory
and feeding it to `devtools::as.package(pkg)` (this is just a list with
a `path` key and some information from the DESCRIPTION file).
