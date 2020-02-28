---
layout: paper
title: Weakly-supervised Multi-output Regression via Correlated Gaussian Processes
image: /assets/images/papers/wsmgp.png
authors: Seokhyun Chung, Raed Al Kontar, Zhenke Wu
year: 2020+
shortref: Chung, Kontar, Wu (2020+). Submitted.
journal: "arXiv"
pdf: 
slides: 
supplement: 
github: 
doi: 
external_link: https://arxiv.org/abs/2002.08412
video_link: 
type: statistical
---

# Abstract

Multi-output regression seeks to infer multiple latent functions using data from multiple groups/sources while accounting for potential between-group similarities. In this paper, we consider multi-output regression under a weakly-supervised setting where a subset of data points from multiple groups are unlabeled. We use dependent Gaussian processes for multiple outputs constructed by convolutions with shared latent processes. We introduce hyperpriors for the multinomial probabilities of the unobserved labels and optimize the hyperparameters which we show improves estimation. We derive two variational bounds: (i) a modified variational bound for fast and stable convergence in model inference, (ii) a scalable variational bound that is amenable to stochastic optimization. We use experiments on synthetic and real-world data to show that the proposed model outperforms state-of-the-art models with more accurate estimation of multiple latent functions and unobserved labels.

# Bibtex

```
@misc{chung2020weaklysupervised,
    title={Weakly-supervised Multi-output Regression via Correlated Gaussian Processes},
    author={Seokhyun Chung and Raed Al Kontar and Zhenke Wu},
    year={2020},
    eprint={2002.08412},
    archivePrefix={arXiv},
    primaryClass={stat.ML}
}
```