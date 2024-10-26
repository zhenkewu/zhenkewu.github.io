---
layout: paper
title: A Robust Functional EM Algorithm for Incomplete Panel Count Data
image: /assets/images/papers/functional_EM.png
authors: Alexander Moreno, Zhenke Wu, David Wetter, Cho Lam, Inbal Nahum-Shani, Walter Dempsey, James Rehg
year: 2020
shortref: Moreno et al. (2020). NeurIPS. 
journal: "NeurIPS2020"
pdf: 
slides: 
supplement: https://bit.ly/3l973EP
github: 
doi: 
external_link: https://bit.ly/3mVLW9u
video_link: 
type: statistical
tags:
    - machine learning
 
---

# Abstract

Panel count data describes aggregated counts of recurrent events observed at discrete time points. To understand dynamics of health behaviors, the field of quantitative behavioral research has evolved to increasingly rely upon panel count data collected via multiple self reports, for example, about frequencies of smoking using in-the-moment surveys on mobile devices. However, missing reports are common and present a major barrier to downstream statistical learning. As a first step, under a missing completely at random assumption (MCAR), we propose a simple yet widely applicable functional EM algorithm to estimate the counting process mean function, which is of central interest to behavioral scientists. The proposed approach wraps several popular panel count inference methods, seamlessly deals with incomplete counts and is robust to misspecification of the Poisson process assumption. Theoretical analysis of the proposed algorithm provides finite-sample guarantees by expanding parametric EM theory to our general non-parametric setting. We illustrate the utility of the proposed algorithm through numerical experiments and an analysis of smoking cessation data. We also discuss useful extensions to address deviations from the MCAR assumption and covariate effects.

```
@misc{alex2020functional,
    title={A Robust Functional EM Algorithm for Incomplete Panel Count Data},
    author={Alexander Moreno and Zhenke Wu and Jamie Yap and David Wetter and Cho Lam and Inbal Nahum-Shani and Walter Dempsey and James M. Rehg},
    year={2020},
    eprint={2003.01169},
    archivePrefix={arXiv},
    primaryClass={stat.ME}
}
```