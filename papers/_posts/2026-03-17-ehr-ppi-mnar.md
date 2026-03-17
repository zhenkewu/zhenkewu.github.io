---
layout: paper
title: "Prediction-based Inference in Electronic Health Record (EHR)-linked Biobanks"
image: /assets/images/papers/ehr-ppi.png
authors: Xingran Chen, Cheng-Han Yang, Zhenke Wu, Bhramar Mukherjee
year: submitted
shortref: Chen et al.
journal: arXiv
pdf: 
slides:
supplement: 
poster: 
github: 
doi: 
external_link: https://arxiv.org/abs/2603.14356
video_link: 
type: statistical
tags:
    - electronic health records
    - AI/ML and Statistics
    - missing data
---

# Abstract

Electronic health record (EHR)-linked biobank data facilitate large-scale scientific discoveries such as genome-wide association study (GWAS) on a multitude of phenotypic traits and biomarkers routinely captured in EHR. However, heterogeneous missingness in biomarkers may bias analyses when used as phenotypes. Recently proposed prediction-based (PB) inference methods incorporate external machine ML models to impute missing biomarkers and thereby improve the statistical power and estimation precision in association analyses. Yet, it remains unclear that if these methods are still preferable when the outcome $Y$ is generated under a clinically informative observation process. A comprehensive comparative evaluations and theoretical understanding of the existing PB methods under such realistic EHR missingness mechanisms are lacking. In this paper, we conduct a structured review of 8 recently developed PB methods and categorize them based on their frameworks. We systematically evaluate 9 methods, including 4 PB methods and 5 baseline methods from the traditional missing-data approaches, under 10 different outcome observation process models across different missing assumptions for continuous and binary outcomes. Our results show that PB methods can substantially improve statistical power and estimation efficiency when their missingness assumptions hold, but they may require stronger assumptions than CCA to control type I error. We provide theoretical results to characterize the scenarios under which CCA or PB methods may remain valid. Finally, we apply CCA, weighted CCA, and two PB methods to perform GWAS of six laboratory biomarkers in the All of Us data. The results demonstrate that PB methods can replicate known genetic associations while improving efficiency relative to (weighted) CCA. Furthermore, they extend inferential results to a more representative study population.