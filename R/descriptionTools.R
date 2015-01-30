##' Version of package in local source code
##'
##' Meant for use with makefiles.  Must be in the directory
##' with the package source.
##'
##' @param pkg package name as character string
##' @export
sourceVersion <- function(pkg) {
    ## do not use packageVersion because it doesn't return the dashes
    ## (e.g. 1.1.8 instead of 1.1-8)
    setNames(packageDescription(pkg, lib.loc = ".")$Version, "")
}

##' Make tarball name from source package
##'
##' Meant for use with makefiles.
##'
##' @param pkg package name as character string
##' @export
tarName <- function(pkg) {
    setNames(paste(pkg, "_", sourceVersion(pkg), ".tar.gz", sep = ""), "")
}
