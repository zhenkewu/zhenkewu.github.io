---
layout: paper
title: A Bayesian Approach to Restricted Latent Class Models for Scientifically-Structured Clustering of Multivariate Binary Outcomes
image: /assets/images/papers/binary_factorization.png
authors: Zhenke Wu, Livia Casciola-Rosen, Antony Rosen, Scott Zeger
year: 2019+
shortref: Wu et al. (2019+). Submitted
journal: Submitted
pdf: /assets/pdfs/papers/wu-2018-bayesian_rlcm.pdf
slides: /assets/pdfs/slides/bayesian_rlcm_web.pdf
supplement:  /assets/pdfs/papers/wu-2018-bayesian_rlcm_supp.pdf
poster: /assets/pdfs/posters/SAMSI_poster_2018Aug14.pdf
github: https://github.com/zhenkewu/rewind
doi: 
external_link: https://goo.gl/vYvQx7
video_link: 
type: statistical
---

# Abstract

In this paper, we propose a general framework for combining evidence of varying quality to estimate underlying binary latent variables in the presence of restrictions imposed to respect the scientific context. The resulting algorithms cluster the multivariate binary data in a manner partly guided by prior knowledge. The primary model assumptions are that 1) subjects belong to classes defined by unobserved binary states, such as the true presence or absence of pathogens in epidemiology, or of antibodies in medicine, or the "ability" to correctly answer test questions in psychology, 2) a binary design matrix $\Gamma$ specifies relevant features in each class, and 3) measurements are independent given the latent class but can have different error rates. Conditions ensuring parameter identifiability from the likelihood function are discussed and inform the design of a novel posterior inference algorithm that simultaneously estimates the number of clusters, design matrix $\Gamma$, and model parameters. In finite samples and dimensions, we propose prior assumptions so that the posterior distribution of the number of clusters and the patterns of latent states tend to concentrate on smaller values and sparser patterns, respectively. The model readily extends to studies where some subjects' latent classes are known or important prior knowledge about differential measurement accuracy is available from external sources. The methods are illustrated with an analysis of protein data to detect clusters representing auto-antibody classes among scleroderma patients.


# Keywords

Clustering; Dependent Binary Data; Markov Chain Monte Carlo; Measurement Error; Mixture of Finite Mixture Models; Latent Class Models.

# Notable Features

### Special Case: Binary Matrix Factorization

This paper introduces a Bayesian framework that includes **binary matrix factorization (BMF)** as a special case (with unknown number of active latent dimensions and unknown number of distinct binary individual latent states). See the following illustration for an orthogonal decomposition:

![alt text](/assets/images/papers/binary_factorization.png){:class="img-responsive"}
**Figure 1**: Binary matrix factorization generates composite autoantibody signatures that are further subject to misclassification. The signature $\Gamma_{i\star}= \mathbf{\eta}_i^\top\mathbf{Q}$ assembles three *orthogonal* machines with 3, 4 and 3 landmark proteins, respectively. The highlighted individual is expected to mount immune responses against antigens in Machines 1 and 3. See texts after model (6).


### Superior Clustering Performance Compared to Hierarchical Clustering, All-feature Latent Class Analysis and Subset Clustering
![alt text](/assets/images/papers/bmf_motivating_example.jpg){:class="img-responsive"}
**Figure 2**: In the 100-dimension multivariate binary data example, the eight classes differ with respect to subsets of measured features. Bayesian restricted latent class analysis accounts for measurement errors, selects the relevant feature subsets and filters the subsets by a low-dimensional model (like the one in the figure above) and therefore yields superior clustering results. 
