---
layout: paper
title: A Robust Test for the Stationarity Assumption in Sequential Decision Making
image: /assets/images/papers/double_cusum_RL.png
authors: Jitao Wang, Chengchun Shi, Zhenke Wu
year: 2023
shortref: Wang et al. (2023). ICML
journal: "ICML"
pdf: /assets/images/pdfs/double_cusum_RL.pdf
slides: 
supplement: 
github: https://github.com/jtwang95/Double_CUSUM_RL
doi: 
external_link: https://openreview.net/forum?id=KoIqF3Dztr
video_link: 
type: statistical
tags:
    - change-point analysis
    - reinforcement learning
    - mobile health
    - intern health study
---

# Abstract: 

Reinforcement learning (RL) is a powerful technique that allows an autonomous agent to learn an optimal policy to maximize the expected return. The optimality of various RL algorithms relies on the stationarity assumption, which requires time-invariant state transition and reward functions. However, deviations from stationarity over extended periods often occur in real-world applications like robotics control, health care and digital marketing, resulting in suboptimal policies learned under stationary assumptions. In this paper, we propose a model-based doubly robust procedure for testing the stationarity assumption and detecting change points in offline RL settings with certain degree of homogeneity. Our proposed testing procedure is robust to model misspecifications and can effectively control type-I error while achieving high statistical power, especially in high-dimensional settings. Extensive comparative simulations and a real-world interventional mobile health example illustrate the advantages of our method in detecting change points and optimizing long-term rewards in high-dimensional, non-stationary environments.