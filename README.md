setup
=====

A personalized setup for `R`.  I've found it useful to add
`library(setup)` to my `.Rprofile`, maybe others will too.  Always
changing, never any goals for stabilization.

```{r}
library("setup", quietly = TRUE, warn.conflicts = FALSE)
```

The *guiding principle* of the `setup` package is to include
functionality that is intended *exclusively for interative sessions*
and *not in scripts or packages that are intended for other users*.
The recommended way to use `setup` is to
[fork](https://help.github.com/articles/fork-a-repo/) it and modify as
desired for your needs in interactive sessions.

### Current features

1. [utilities](https://github.com/stevencarlislewalker/setup/blob/master/R/knitrTools.R)
   for processing parts of `knitr` chunks
2. [tools](https://github.com/stevencarlislewalker/setup/blob/master/R/gitTools.R)
   for checking your progress on [git](http://git-scm.com/) projects
3. extract
   [package info](https://github.com/stevencarlislewalker/setup/blob/master/R/descriptionTools.R)
   for makefiles
4. [alternative interface](https://github.com/stevencarlislewalker/setup/blob/master/R/derivatives.R)
   to `R`'s symbolic differentiation tools
5. [sugar](https://github.com/stevencarlislewalker/setup/blob/master/R/rmat.R)
   for random matrices
6. [sugar](https://github.com/stevencarlislewalker/setup/blob/master/R/unifInt.R)
   for using uniform distributions over subsets of the integers
7. [sugar](https://github.com/stevencarlislewalker/setup/blob/master/R/term.R)
   for interfacing with `bash`
8. yes i really want to
   [quit](https://github.com/stevencarlislewalker/setup/blob/master/R/q.R)!

### Examples

Quick [random matrices](https://github.com/stevencarlislewalker/setup/blob/master/R/rmat.R)!
```{r}
rmat(5, 3)
##             [,1]       [,2]       [,3]
## [1,] -0.66632144  1.3042986  0.1259268
## [2,] -0.75127404 -1.2725709 -0.1596205
## [3,] -0.46391447 -1.1113941 -1.3869535
## [4,]  0.07424689  0.8562972  1.4712344
## [5,] -0.47383856 -2.0638588  0.4354084
```

[Symbolic differentiation](https://github.com/stevencarlislewalker/setup/blob/master/R/derivatives.R)
without expressions!
```{r}
gradient("(x^2)/y", c("x", "y"))
##       gradient
## x      2 * x/y
## y -((x^2)/y^2)
hessian("(x^2)/y", c("x", "y"))
##              x                       y
## x          2/y            -(2 * x/y^2)
## y -(2 * x/y^2) (x^2) * (2 * y)/(y^2)^2
```

Using
[`tarName`](https://github.com/stevencarlislewalker/setup/blob/master/R/descriptionTools.R)
in a makefile.
```{make}
PKG = lme4
TAR = $(shell Rscript -e "tarName(\"$(PKG)\")")
BUILD = R CMD build --no-build-vignettes
INSTALL = R CMD install
CHECK = R CMD check

all: $(TAR) install

$(TAR): 
	$(BUILD) $(PKG)

install: $(TAR)
	$(INSTALL) $(TAR)

check: $(TAR)
	$(CHECK) $(TAR)
```
