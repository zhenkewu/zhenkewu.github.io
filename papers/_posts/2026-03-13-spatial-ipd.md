---
layout: paper
title: "Spatially Robust Inference with Predicted and Missing at Random Labels"
image: /assets/images/papers/spatial_ipd.png
authors: Stephen Salerno, Zhenke Wu, Tyler McCormick
year: submitted
shortref: Salerno et al.
journal: 
pdf: 
slides:
supplement: 
poster: 
github: 
doi: 
external_link: https://arxiv.org/abs/2603.11368
video_link: 
type: statistical
tags:
    - spatial analysis
    - AI/ML and Statistics
    - missing data
---

# Abstract

When outcome data are expensive or onerous to collect, scientists increasingly substitute predictions from machine learning and AI models for unlabeled cases, a process which has consequences for downstream statistical inference. While recent methods provide valid uncertainty quantification under independent sampling, real-world applications involve missing at random (MAR) labeling and spatial dependence. For inference in this setting, we propose a doubly robust estimator with cross-fit nuisances. We show that cross-fitting induces fold-level correlation that distorts spatial variance estimators, producing unstable or overly conservative confidence intervals. To address this, we propose a jackknife spatial heteroscedasticity and autocorrelation consistent (HAC) variance correction that separates spatial dependence from fold-induced noise. Under standard identification and dependence conditions, the resulting intervals are asymptotically valid. Simulations and benchmark datasets show substantial improvement in finite-sample calibration, particularly under MAR labeling and clustered sampling.