setup
=====

A personalized setup for `R`.  I've found it useful to add
`library(setup)` to my `.Rprofile`, maybe others will too.  Always
changing, never any goals for stabilization.

The *guiding principle* of the `setup` package is to include
functionality that is intended *exclusively for interative sessions*
and *not in scripts or packages that are intended for other users*.
The recommended way to use `setup` is to
[fork](https://help.github.com/articles/fork-a-repo/) it and modify as
desired for your needs in interactive sessions.

Current features:

1. [utilities](https://github.com/stevencarlislewalker/setup/blob/master/R/knitrTools.R)
   for processing parts of `knitr` chunks
2. [alternative interface](https://github.com/stevencarlislewalker/setup/blob/master/R/derivatives.R)
   to `R`'s symbolic differentiation tools
3. [sugar](https://github.com/stevencarlislewalker/setup/blob/master/R/term.R)
   for interfacing with `bash`
4. [sugar](https://github.com/stevencarlislewalker/setup/blob/master/R/unifInt.R)
   for using uniform distributions over subsets of the integers
5. yes i really want to
   [quit](https://github.com/stevencarlislewalker/setup/blob/master/R/q.R)!
6. [tools](https://github.com/stevencarlislewalker/setup/blob/master/R/gitTools.R)
   for checking your progress on a [git](http://git-scm.com/) projects
