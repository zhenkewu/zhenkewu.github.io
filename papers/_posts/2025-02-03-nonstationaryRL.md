---
layout: paper
title: "Testing Stationarity and Change Point Detection in Reinforcement Learning"
image: /assets/images/papers/nonstationaryRL.png
authors: Mengbing Li, Chengchun Shi, Zhenke Wu, Piotr Fryzlewicz
year: 2025
shortref: Li et al. (2025). Annals of Statistics
journal: Annals of Statistics
pdf: 
slides: 
supplement: 
poster: 
github: https://github.com/limengbinggz/CUSUM-RL
doi: 
external_link: https://arxiv.org/abs/2203.01707
video_link: 
type: statistical
tags:
    - change-point analysis
    - reinforcement learning
    - intern health study
 
---

# Abstract

We consider offline reinforcement learning (RL) methods in possibly nonstationary environments. Many existing RL algorithms in the literature rely on the stationarity assumption that requires the system transition and the reward function to be constant over time. However, the stationarity assumption is restrictive in practice and is likely to be violated in a number of applications, including traffic signal control, robotics and mobile health. In this paper, we develop a consistent procedure to test the nonstationarity of the optimal Q-function based on pre-collected historical data, without additional online data collection. Based on the proposed test, we further develop a sequential change point detection method that can be naturally coupled with existing state-of-the-art RL methods for policy optimization in nonstationary environments. The usefulness of our method is illustrated by theoretical results, simulation studies, and a real data example from the 2018 Intern Health Study. A Python implementation of the proposed procedure is available at [https://github.com/limengbinggz/CUSUM-RL](https://github.com/limengbinggz/CUSUM-RL).

**Keywords** Reinforcement learning; Nonstationarity; Hypothesis testing; Change point detection; Policy optimization.