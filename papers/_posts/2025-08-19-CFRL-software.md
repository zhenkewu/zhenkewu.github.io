---
layout: paper
title: "PyCFRL: A Python library for counterfactually fair offline reinforcement learning via sequential data preprocessing"
image: /assets/images/papers/cfrl.png
authors: Jianhan Zhang, Jitao Wang, Chengchun Shi, John Piette, Donglin Zeng, Zhenke Wu
year: submitted
shortref: Zhang et al.
journal: 
pdf: /assets/pdfs/papers/CFRL_software.pdf
slides:
supplement: https://pycfrl-documentation.netlify.app/
poster: /assets/pdfs/posters/2025-03-27 poster_CFRL.pdf
github: https://github.com/JianhanZhang/PyCFRL
doi:
external_link: https://arxiv.org/abs/2510.06935
video_link: 
type: statistical
tags:
    - reinforcement learning
    - ethical AI
    - fairness
    - software
 
---

# Abstract

Many existing `Python` libraries implement algorithms that ensure fairness in machine learning. For example, `Fairlearn` (Weerts et al., 2023) and `aif360` (Bellamy et al., 2018) provide tools for mitigating bias in single-stage machine learning predictions under statistical assocoiation based fairness criterion such as demographic parity and equal opportunity. However, they do not focus on counterfactual fairness, which defines an individual-level fairness concept from a causal perspective, and they cannot be easily extended to the reinforcement learning setting in general. Additionally, `ml-fairness-gym` (D’Amour et al., 2020) allows users to simulate unfairness in sequential decision-making, but it neither implements algorithms that reduce unfairness nor addresses CF. To our knowledge, Wang et al. (2025) is the first work to study CF in RL. Correspondingly, `PyCFRL` is also the first code library to address CF in the RL setting.

The contribution of `PyCFRL` is two-fold. First, it implements a data preprocessing algorithm that ensures CF in offline RL. For each individual in the data, the preprocessing algorithm sequentially estimates the counterfactual states under different sensitive attribute values and concatenates all of the individual’s counterfactual states at each time point into a new state vector. The preprocessed data can then be directly used by existing RL algorithms for policy learning, and the learned policy should be counterfactually fair up to finite-sample estimation accuracy. Second, it provides a platform for assessing RL policies based on CF. After passing in any policy and a data trajectory from the environment of interest, users can estimate the value and CF level achieved by the policy in the environment of interest. The library is publicly available on PyPI and Github ([link](https://github.com/JianhanZhang/PyCFRL)), and detailed tutorials can be found in the PyCFRL documentation ([link](https://pycfrl-documentation.netlify.app/)).
