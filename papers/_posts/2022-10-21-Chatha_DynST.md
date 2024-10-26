---
layout: paper
title: Dynamic Survival Transformers for Causal Inference with Electronic Health Records
image: /assets/images/papers/DynST.png
authors: Prayag Chatha, Yixin Wang, Zhenke Wu, Jeffrey Regier
year: 2022
shortref: Chatha et al. (2022). NeurIPS Workshop on Learning from Time Series for Health. 
journal: "NeurIPS 2022 Workshop on Learning from Time Series for Health"
pdf: 
slides: 
supplement: 
github: 
doi: 
external_link: https://arxiv.org/abs/2210.15417
video_link: 
type: statistical
tags:
    - causal inference
    - machine learning
 
---

# Keywords: 

survival analysis, deep learning, EHR, causal inference

# Abstract: 

In medicine, researchers often seek to infer the effects of a given treatment on patients' outcomes, such as the expected time until infection. However, the standard methods for causal survival analysis make simplistic assumptions about the data-generating process and cannot capture complex interactions among patient covariates. We introduce the Dynamic Survival Transformer (DynST), a deep survival model that trains on electronic health records (EHRs). Unlike previous transformers used in survival analysis, DynST can make use of time-varying information to predict evolving survival probabilities. We derive a semi-synthetic EHR dataset from MIMIC-III to show that DynST can accurately estimate the causal effect of a treatment intervention on restricted mean survival time (RMST). We demonstrate that DynST achieves better predictive and causal estimation than two alternative models.