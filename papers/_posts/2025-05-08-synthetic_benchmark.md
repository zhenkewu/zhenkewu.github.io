---
layout: paper
title: "Generating Synthetic Electronic Health Record (EHR) Data: A Methodological Scoping Review with Benchmarking on Phenotype Data and Open-Source Software"
image: /assets/images/papers/synth_benchmark.png
authors: Xingran Chen, Zhenke Wu$^*$, Xu Shi, Hyunghoon Cho, Bhramar Mukherjee$^{**}$
year: 2025
shortref: Chen et al. (2025). Journal of the American Medical Informatics Association.
journal: Journal of the American Medical Informatics Association.
pdf: 
slides: 
supplement: 
poster: 
github: https://github.com/chenxran/synthEHRella
doi: 
external_link: https://arxiv.org/abs/2411.04281
video_link: 
type: statistical
tags:
    - synthetic EHR data
    - generative AI
    - benchmarking
    - review
 
---

$^*$: corresponding author; $^{**}$: senior author

# Abstract

**Objectives**: To conduct a scoping review of existing approaches for synthetic Electronic Health Records (EHR) data generation, to benchmark major methods, and to provide an open-source software and offer recommendations for practitioners. Materials and Methods: We search three academic databases for our scoping review. Methods are benchmarked on open-source EHR datasets, Medical Information Mart for Intensive Care III and IV (MIMIC-III/IV). Seven existing methods covering major categories and two baseline methods are implemented and compared. Evaluation metrics concern data fidelity, downstream utility, privacy protection, and computational cost.

**Results**: 48 studies are identified and classified into five categories. Seven open-source methods covering all categories are selected, trained on MIMIC-III, and evaluated on MIMIC-III or MIMIC-IV for transportability considerations. Among them, Generative Adversarial Network (GAN)-based methods demonstrate competitive performance in fidelity and utility on MIMIC-III; rule-based methods excel in privacy protection. Similar findings are observed on MIMIC-IV, except that GAN-based methods further outperform the baseline methods in preserving fidelity.  
**Discussion**: Method choice is governed by the relative importance of the evaluation metrics in downstream use cases. We provide a decision tree to guide the choice among the benchmarked methods.

**Conclusion**: GAN-based methods excel when distributional shifts exist between the training and testing populations. Otherwise, CorGAN and MedGAN are most suitable for association modeling and predictive modeling, respectively. Future research should prioritize enhancing fidelity of the synthetic data while controlling privacy exposure, and comprehensive benchmarking of longitudinal or conditional generation methods.

**Keywords**: Confidentiality, Diffusion Models, Generative Adversarial Network, Generative AI, Phecode, Privacy, Scoping Review, Synthetic EHR, Transformer, Variational Auto-Encoder.


A Python package, `SynthEHRella`, is provided to integrate various choices of approaches and evaluation metrics, enabling more streamlined exploration and evaluation of multiple methods, which can be accessed at [https://github.com/chenxran/synthEHRella](https://github.com/chenxran/synthEHRella).
