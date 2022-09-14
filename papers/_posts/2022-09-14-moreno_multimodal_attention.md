---
layout: paper
title: Kernel Deformed Exponential Families for Sparse Continuous Attention
image: /assets/images/papers/kernel_attention.png
authors: Alexander Moreno, Zhenke Wu, Supriya Nagesh, Walter Dempsey, James Rehg
year: 2022
shortref: Moreno et al. (2022). NeurIPS. 
journal: "NeurIPS"
pdf: /assets/images/pdfs/kernel_multimodal_continuous_attention.pdf
slides: 
supplement: /assets/images/pdfs/kernel_multimodal_continuous_attention_supp.pdf
github: 
doi: 
external_link: 
video_link: 
type: statistical
---

# Keywords: 

continuous attention, kernel methods, theory

# TL;DR: 

We extend continuous attention from unimodal (deformed) exponential families and Gaussian mixture models to kernel exponential families and a new kernel deformed sparse counterpart.

# Abstract: 

Attention mechanisms take an expectation of a data representation with respect to probability weights. Recently, (Martins et al. 2020, 2021) proposed continuous attention mechanisms, focusing on unimodal attention densities from the exponential and deformed exponential families: the latter has sparse support. (Farinhas et al 2021) extended this to to multimodality via Gaussian mixture attention densities. In this paper, we extend this to kernel exponential families (Canu and Smola 2006) and our new sparse counterpart, kernel deformed exponential families. Theoretically, we show new existence results for both kernel exponential and deformed exponential families, and that the deformed case has similar approximation capabilities to kernel exponential families. Lacking closed form expressions for the context vector, we use numerical integration: we show exponential convergence for both kernel exponential and deformed exponential families. Experiments show that kernel continuous attention often outperforms unimodal continuous attention, and the sparse variant tends to highlight peaks of time series.