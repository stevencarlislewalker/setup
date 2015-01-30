##' Open bash terminal in current directory
##'
##' @export
term <- function() system("bash")

##' Relative directory name
##'
##' @param dir directory, character string
##' @export
reldir <- function(dir) {
    if(missing(dir)) dir <- getwd()
    dirSplit <- strsplit(getwd(), "/")[[1]]
    dirSplit[length(dirSplit)]
}
