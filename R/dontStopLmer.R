##' Don't stop lmer
##'
##' @param cntrl either \code{lmerControl} or \code{glmerControl}
##' @return list for \code{control} argument in \code{lmer} or
##' \code{glmer}
##' @export
dontStopLmer <- function(cntrl = lmerControl) {
    ullc <- unlist(unname(cntrl()))
    stopOpts <- names(ullc)[ullc %in% "stop"]
    args <- setNames(rep(list("warning"), length(stopOpts)), stopOpts)
    do.call(cntrl, args)
}
