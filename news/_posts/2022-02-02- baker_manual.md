---
layout: news
title: "baker on CRAN!"
description: ""
author: "Zhenke Wu"
author_handle: "Zhenke Wu"
category: news
tags: 
  - software
---

`baker` has a first public release (v1.0.0) at [CRAN](https://cran.r-project.org/web/packages/baker/index.html)! Discussion related to version `1.0.0` can be submitted to [here](https://github.com/zhenkewu/baker/issues).

Our group recently updated the `baker` package [[vignette]](/assets/html/baker_vignette.html) [[source code]](https://github.com/zhenkewu/baker). 

This vignette describes and illustrates the functionality of the `baker` `R` package. The package provides a suite of nested partially-latent class models (NPLCM) for multivariate binary responses that are observed under a case-control design. The `baker` package allows researchers to flexibly estimate population- and individual-level class distributions that may also depend on additional explanatory covariates. 

Functions in `baker` implement recent methodological developments in our group ([here](https://zhenkewu.com/papers/wu-2015-plcm), [here](https://zhenkewu.com/papers/wu-2016-nested-plcm), and [here](https://zhenkewu.com/papers/nplcm_reg)). Estimation is accomplished by calling a cross-platform automatic Bayesian inference software `JAGS` through a wrapper `R` function that parses model specifications and data inputs. The `baker` package provides many useful features, including data ingestion, exploratory data analyses, model diagnostics, extensive plotting and visualization options, catalyzing vital communications between practitioners and domain scientists. Package features and workflows are illustrated using simulated and real data sets. 

The focus of this document is on guiding a new user to utilize some useful functions in `baker` for simulation studies and data analyses, aided by other powerful `R` packages. We refer readers of this document to the accompanying main software paper for more details about the software design considerations and review of model formulations. Since  `baker`’s first appearance on Github, the authors have not been able to track other recent substantive publications that have used this package; we hope the main software paper and this vignette serve as the definitive reference for future scientific studies that find the `baker` package useful.