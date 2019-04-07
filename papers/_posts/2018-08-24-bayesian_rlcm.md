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

This paper presents a model-based method for clustering multivariate binary observations that incorporates constraints consistent with the scientific context. The approach is motivated by the precision medicine problem of identifying autoimmune disease patient subsets who may require different treatments. We start with a family of restricted latent class models or RLCMs (e.g., Xu and Shang, 2018). However, in the motivating example and many others like it, the unknown number of subsets and the definitions of the latent classes are among the targets of inference. We use a Bayesian approach to RCLMs in order to use informative prior assumptions on the number and definitions of latent classes to be consistent with scientific knowledge so that the posterior distribution tends to concentrate on smaller numbers of clusters and sparser binary patterns. The paper presents a novel posterior inference algorithm to handle discrete mixture parameters. Through simulations under the assumed model and realistic deviations from it, we demonstrate greater interpretability of results and superior finite-sample clustering performance for our method compared to common alternatives. The methods are illustrated with an analysis of protein data to detect clusters representing autoantibody classes among scleroderma patients.


# Keywords

Autoimmune disease; Clustering; Dependent Binary Data; Latent Class Models; Markov Chain Monte Carlo; Measurement Error; Mixture of Finite Mixture Models; Scleroderma.

# Notable Features

### Special Case: Binary Matrix Factorization

This paper introduces a Bayesian framework that includes **binary matrix factorization (BMF)** as a special case (with unknown number of active latent dimensions and unknown number of distinct binary individual latent states). See the following illustration for an orthogonal decomposition:

![alt text](/assets/images/papers/binary_factorization.png){:class="img-responsive"}
**Figure 1**: Binary matrix factorization generates composite autoantibody signatures that are further subject to misclassification. The signature $\Gamma_{i\star}= \mathbf{\eta}_i^\top\mathbf{Q}$ assembles three *orthogonal* machines with 3, 4 and 3 landmark proteins, respectively. The highlighted individual is expected to mount immune responses against antigens in Machines 1 and 3. See texts after model (6).


### Superior Clustering Performance Compared to Hierarchical Clustering, All-feature Latent Class Analysis and Subset Clustering
![alt text](/assets/images/papers/bmf_motivating_example.jpg){:class="img-responsive"}
**Figure 2**: In the 100-dimension multivariate binary data example, the eight classes differ with respect to subsets of measured features. Bayesian restricted latent class analysis accounts for measurement errors, selects the relevant feature subsets and filters the subsets by a low-dimensional model (like the one in the figure above) and therefore yields superior clustering results. 
