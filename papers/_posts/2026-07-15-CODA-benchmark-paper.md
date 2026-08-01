---
layout: paper
title: "A Multimodal Benchmark for Evaluating Cause-of-Death Inference Using Child Health and Mortality Data"
image: /assets/images/papers/coda_benchmark.png
authors: Junhe Yang, Soumyakanti Pan, Hyun Seung Lim, Yue Chu, Yuting Guo, Nishtha Agarwal, Varun Babbar, Gaurav Rajesh Parikh, Yiqun T. Chen, Chris A. Rees, Ziyaad Dangor, Sanjay G. Lala, Zehang Richard Li, Samuel J. Clark, Zhenke Wu, Abhirup Datta, Li Liu, Cynthia Rudin, Samuel V. Scarpino, Benjamin M. Gyori, Tyler H. McCormick
year: submitted
shortref: Yang et al.
journal: 
pdf: 
slides: 
supplement:  
poster: 
github: 
doi: 
external_link: https://shorturl.at/Au7X1
video_link: 
type: statistical
tags:
    - verbal autopsy
    - machine learning
    - large language model
    - benchmark
    - evaluation
---

# Abstract

Accurately attributing causes of death is vital for global health, yet fewer than 5% of deaths in resource-constrained regions are medically certified. To assign causes to these unlabeled deaths at scale, practitioners traditionally rely on verbal autopsy, using supervised statistical models to classify based on structured survey data. However, modern mortality surveillance increasingly collects rich, unstructured multimodal data, such as free-text caregiver narratives and postmortem diagnostics, which traditional supervised statistical models struggle to seamlessly integrate. In this paper, we present a comprehensive, multimodal benchmark for cause-of-death classification using data from the Child Health and Mortality Prevention Surveillance (CHAMPS) network, a unique surveillance platform spanning nine countries across South Asia and Sub-Saharan Africa. Using this dataset, we introduce an evaluation framework designed to rigorously assess diagnostic reasoning, moving beyond traditional metrics that fail to capture complex clinical realities. We demonstrate the utility of this benchmark by evaluating zero-shot large language models against supervised baselines across various data modalities. Our results reveal distinct differences in how these modeling approaches synthesize unstructured medical evidence. This benchmark provide a rigorously defined resource for assessing clinical reasoning in next-generation mortality surveillance.