---
layout: paper
title: "Reinforcement Learning in Possibly Nonstationary Environment"
image: /assets/images/papers/nonstationaryRL.png
authors: Mengbing Li, Chengchun Shi, Zhenke Wu, Piotr Fryzlewicz
year: 2022+
shortref: Li et al. (2022+). Submitted.
journal: Submitted.
pdf: /assets/pdfs/papers/nonstationaryRL_main.pdf
slides: 
supplement: /assets/pdfs/papers/nonstationaryRL_supp.pdf
poster: 
github: https://github.com/limengbinggz/CUSUM-RL
doi: 
external_link: https://arxiv.org/abs/2203.01707
video_link: 
type: statistical
---

# Abstract

We consider reinforcement learning (RL) methods in offline nonstationary environments. Many existing RL algorithms in the literature rely on the stationarity assumption that requires the system transition and the reward function to be constant over time. However, the stationarity assumption is restrictive in practice and is likely to be violated in a number of applications, including trafﬁc signal control, robotics and mobile health. In this paper, we develop a consistent procedure to test the nonstationarity of the optimal policy based on pre-collected historical data, without additional online data collection. Based on the proposed test, we further develop a sequential change point detection method that can be naturally coupled with existing state-of-the-art RL methods for policy optimisation in nonstationary environments. The usefulness of our method is illustrated by theoretical results, simulation studies, and a real data example from the [2018 Intern Health Study](https://www.srijan-sen-lab.com/intern-health-study). A `Python` implementation of the proposed procedure is available at [https://github.com/limengbinggz/CUSUM-RL](https://github.com/limengbinggz/CUSUM-RL).

**Keywords** Reinforcement learning; Nonstationarity; Hypothesis testing; Change point detection; Policy optimisation.