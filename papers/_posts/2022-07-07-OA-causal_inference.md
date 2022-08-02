---
layout: paper
title: "Outcome Adaptive Propensity Score Methods for Handling Censoring and High-Dimensionality: Application to Insurance Claims"
image: /assets/images/papers/OA_causal.png
authors: Youfei Yu, Jiacong Du, Min Zhang, Zhenke Wu, Andrew Ryan, Bhramar Mukherjee
year: 2022+
shortref: Yu et al. (2022+). Submitted.
journal: Submitted.
pdf: 
slides: 
supplement: 
poster: 
github: 
doi: 
external_link: https://arxiv.org/abs/2208.00114
video_link: 
type: statistical
---

# Abstract

Propensity scores are commonly used to reduce the confounding bias in non-randomized observational studies for estimating the average treatment effect (ATE). An important assumption underlying this approach is that all confounders that are associated with both the treatment and the outcome of interest are measured and included in the propensity score model. In the absence of strong prior knowledge about potential confounders, researchers may agnostically want to adjust for a high-dimensional set of pre-treatment variables. As such, variable selection procedure is needed for propensity score estimation. In addition, recent studies show that including variables related to treatment only in the propensity score model may inflate the variance of the treatment effect estimates, while including variables that are predictive of only the outcome can improve efficiency. In this paper, we propose a flexible approach to incorporate outcome-covariate relationship in the propensity score model by including the predicted outcome probability (OP) as a covairate. Our approach can be easily adapted to an ensemble of variable selection methods, including regularization methods and modern machine learning tools based on classification and regression trees (CART). Simulation studies indicate that incorporating OP for estimating the propensity scores can improve statistical efficiency and protect against model misspecification. The methods considered are applied to a cohort of advanced stage prostate cancer patients identified from a private insurance claims database for comparing the adverse effects of four commonly used drugs for treating castration resistant prostate cancer.

**Keywords** causal inference, confounder selection, claims data, high-dimensional, outcome-adaptive, propensity scores, tree-based methods.