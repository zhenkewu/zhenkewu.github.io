---
layout: paper
title: "Sparse Longitudinal Functional Principal Component Analysis for Episodic Ambulatory Behavioral Assessments"
image: /assets/images/papers/slfpca-sensorkit.png
authors: Nidhi Pai, Yu Fang, Srijan Sen, Zhenke Wu, Erjia Cui
year: submitted
shortref: Pai et al.
journal:
pdf: 
slides: 
supplement: 
poster: 
github: 
doi: 
external_link: https://arxiv.org/abs/2606.08261
video_link: 
type: statistical
tags:
    - Apple SensorKit
    - ambulatory assessment
    - wearable
    - functional data
    - longitudinal data
---

# Abstract

Accurately monitoring mental fatigue is critical for improving workplace safety and productivity. A recent study examined unobtrusively collected smartphone typing speed as a potential ambulatory proxy assessment of mental fatigue using data from the Intern Health Study (IHS). While population-level average typing speed patterns were found to be consistent with validated measures of mental fatigue, how these trajectories vary across participants and days may inform opportune moments for just-in-time interventions and remains an open question. Treating typing speed trajectories as sparsely observed functional data, we propose a novel sparse longitudinal functional principal component analysis (sparse LFPCA) method for decomposing variability and predicting individual curves. Specifically, sparse data are accommodated by casting covariance estimation as a structured penalized spline regression problem, enabling simultaneous estimation and smoothing of multiple covariance components while borrowing information across locations in the functional domain. Simulations show that sparse LFPCA (1) accurately estimates eigenfunctions and generates reasonable predictions for underlying curves, and (2) achieves similar or superior performance compared to existing alternatives. Our analysis of typing speed data collected from IHS reveals new and interpretable participant- and day-level patterns not captured by previous analyses and can be used to tailor behavioral interventions.

**Keywords** Ambulatory assessment, Covariance models, Functional data analysis, Mobile health, Sparse longitudinal data


**`Data Illustration`**: Recorded sleep episodes (red blocks) and typing sessions (blue bars) for a randomly chosen subject between the start of internship on July 1st to September 1st, 2023. Recall that each typing session was rounded to the nearest 30-min mark for privacy considerations and may contain multiple typing events.
![](/assets/images/papers/sensorkit.png)