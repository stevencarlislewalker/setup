##' Count number of insertions
##'
##' @param dir git repo
##' @param args additional arguments for \code{git log}
##' @return total number of additions
##' @export
gitLines <- function(dir = ".", args = NULL) {
    ## http://stackoverflow.com/questions/1265040/how-to-count-total-lines-changed-by-a-specific-author-in-a-git-repository?answertab=active#tab-top

    lns <- system2("git",
                   args = c("log", "--shortstat", "--oneline", args),
                   stdout=TRUE)
    lns <- grep("insertions", lns, value = TRUE)
    lns <- simplify2array(strsplit(lns, "changed, "))[2,]
    sum(as.numeric(sapply(strsplit(lns, " "), "[[", 1)))
}
