---
layout: paper
title: "Censored Flow Matching for Synthetic Time-to-Event Generation"
image: /assets/images/papers/censored-fm.png
authors: Jianbin Tan, Xingran Chen, Kevin He, Zhenke Wu, Bhramar Mukherjee, Anru R. Zhang
year: submitted
shortref: Tan et al.
journal: 
pdf: 
slides: 
supplement:  
poster: 
github: 
doi: 
external_link: https://arxiv.org/abs/2610.24233
video_link: 
type: statistical
tags:
    - synthetic data
    - AI/ML and Statistics
    - time-to-event outcomes
    - machine learning
---

# Abstract

Generating time-to-event data is increasingly important in survival analysis, but it remains statistically challenging because event times are often censored and thus prevent flexible generative modeling. To fill this gap, we propose a novel method called censored flow matching (CFM), aiming at providing a flexible flow-based generative mechanism for synthesizing time-to-event data as well as learning their corresponding probabilistic densities. Unlike existing methods, CFM does not rely on survival likelihoods to handle censoring, but instead exploits the monotonicity property of differential flows to address censoring via pullback sampling. Under this framework, we implement an alternating procedure between pullback sampling and CFM steps, leading to a flow-based expectation--maximization (EM) algorithm tailored for time-to-event inference. Under mild distributional conditions, we establish the convergence of CFM to the true event-time distribution as the EM iterations proceed. We then apply CFM to generate time-to-event data and estimate their probabilistic densities, where the observed censoring time can be incorporated to provide truncated sampling or truncated density estimation for survival inference. Through extensive simulation studies, we demonstrate the benefits of CFM for complex and large-scale data generation. Finally, we apply CFM to analyze data from the Organ Procurement and Transplantation Network (OPTN) and the Medical Information Mart for Intensive Care IV (MIMIC-IV), showcasing its benefits for synthetic and predictive survival analyses in terms of data fidelity, predictive performance, and empirical privacy characteristics.


## Schematic

![scheme](/assets/images/papers/censored-fm-scheme.png)