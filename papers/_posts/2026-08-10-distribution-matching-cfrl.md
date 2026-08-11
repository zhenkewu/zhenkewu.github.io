---
layout: paper
title: "A Distribution Mapping Approach to Counterfactually Fair Reinforcement Learning"
image: /assets/images/papers/cfrl.png
authors: Jianhan Zhang, Jitao Wang, John Piette, Donglin Zeng, Chengchun Shi, Zhenke Wu
year: submitted
shortref: Zhang et al.
journal: 
pdf: 
slides:
supplement: 
poster: 
github: 
doi:
external_link: https://arxiv.org/abs/2608.08743
video_link: 
type: statistical
tags:
    - reinforcement learning
    - ethical AI
    - fairness
    - software
 
---

# Abstract

Reinforcement learning (RL) seeks to optimize sequential decisions to maximize population-level benefits over time. However, when deployed in high-stakes settings such as healthcare, RL decisions might systematically restrict some subpopulation's access to valuable services in a manner contrary to the values and goals of stakeholders. Counterfactual fairness (CF) offers a promising framework to address this problem based on causal reasoning. This paper develops a data preprocessing algorithm that, when used in tandem with policy learning, enables CF in RL. Our algorithm relies on a novel quantile distribution mapping method for sequentially estimating the counterfactual states and rewards in the data preprocessing step, subsuming common additivity assumptions used for counterfactual prediction as a special case. We theoretically prove that the per-step level of counterfactual unfairness and infinite-horizon suboptimality gap can be bounded under mild regularity conditions. We also empirically test our algorithm in numerical experiments as well as in application to a real-world interventional digital health dataset.