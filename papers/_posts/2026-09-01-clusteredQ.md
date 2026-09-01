---
layout: paper
title: "Generalized Fitted Q-Iteration With Clustered Data"
image: /assets/images/papers/DIRL.png
authors: Liyuan Hu, Jitao Wang, Zhenke Wu, Chengchun Shi
year: 2025
shortref: Hu et al.
journal: Stat
pdf: 
slides: 
supplement:
poster: 
github: https://github.com/zaza0209/GEERL
doi: 
external_link: 
video_link: 
type: statistical
projects:
    - pcori-rl
tags:
    - reinforcement learning
    - clustering
 
---

# Abstract

This paper focuses on reinforcement learning (RL) with clustered data, which is commonly encountered in healthcare applications. We propose a generalized fitted Q-iteration (FQI) algorithm that incorporates generalized estimating equations into policy learning to handle the intra-cluster correlations. Theoretically, we demonstrate (i) the optimalities of our Q-function and policy estimators when the correlation structure is correctly specified and (ii) their consistencies when the structure is mis-specified. Empirically, through simulations and analyses of a mobile health dataset, we find the proposed generalized FQI achieves, on average, a half reduction in regret compared to the standard FQI.
