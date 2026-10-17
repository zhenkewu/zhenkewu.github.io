---
layout: paper
title: "Multimodal Artificial Intelligence for Cause-of-Death Assignment From Verbal Autopsy Records: A National Benchmark Study in South Africa"
image: /assets/images/papers/multimodalVA.png
authors: Yue Chu, Zhenke Wu, Tyler H. McCormick, Zehang Richard Li, Samuel J. Clark
year: submitted
shortref: Chu et al.
journal: 
pdf: 
slides: 
supplement:  
poster: 
github: https://github.com/y-chu/MultimodalVA
doi: 
external_link: https://www.medrxiv.org/content/10.64898/2026.10.15.26364476v1
video_link: 
type: statistical
tags:
    - verbal autopsy
    - machine learning
    - large language model
    - benchmark
    - evaluation
    - global health
---

# Abstract

**BACKGROUND** Timely cause-of-death (COD) information guides health policy, yet many deaths in low- and middle-income countries are not medically certified. In Africa, fewer than 10% of deaths are. Verbal autopsy (VA) yields a structured symptom questionnaire and a free-text narrative. Mortality surveillance increasingly records the narrative alongside the questionnaire, but the algorithms used to produce VA-based statistics were designed for structured responses only, so narratives inform physician COD assignment but do not contribute to algorithmic COD assignment. We evaluated whether supervised models could use both modalities to improve COD assignment. 

**METHODS** We analyzed 4,999 VA records for deaths at ages 12 years or older from a national sample of registered deaths in South Africa (RSA), using physician-assigned CODs as the reference standard. We trained unimodal and multimodal pipelines on the labelled records: pretrained language models (PLMs) fine-tuned on narratives alone, machine learning (ML) models on structured responses alone, and the two combined at the data, feature, and decision levels. We also prompted a locally deployed generative large language model (LLM) on the same unimodal and multimodal inputs, without parameter updates. All were compared with InSilicoVA, the operational comparator representing current automated practice. We evaluated individual-level assignment, population-level agreement, calibration, and generalization across provinces in RSA, reporting these metrics rather than ranking pipelines on any one of them. 

**RESULTS** Every supervised pipeline improved on InSilicoVA by 8.5-15.9 percentage points in top-1 accuracy and 3.5-7.1 points in cause-specific mortality fraction (CSMF) accuracy. The narrative and structured pipelines performed similarly in aggregate but differed by cause: 63.9% of deaths received identical predictions, 11.6% were correct only from the narrative pipeline, and 13.6% only from the questionnaire pipeline, with the narrative pipeline more accurate for noncommunicable causes and the questionnaire pipeline for communicable causes. Against the unimodal approaches, the decision-fusion pipelines added 4.2-5.4 percentage points in top-1 accuracy, concentrated in the most common causes, whereas feature fusion with cross-modal attention improved the less common causes, adding 6.6 points (95% CI, 1.7-11.5) in balanced accuracy and 5.5 points (95% CI, 0.6-10.3) in macro F1. Feature fusion reached the highest CSMF accuracy (95.7%). Paired differences from the better unimodal representative ranged from -0.2 to +3.4 points, with all intervals including zero. The LLM exceeded InSilicoVA on individual-level metrics and reached the highest balanced accuracy of any pipeline (60.6%), while the supervised pipelines retained higher CSMF accuracy. Supervised pipelines had lower expected calibration error than InSilicoVA. Supervised gains held across all nine held-out provinces, including every top-1 comparison and nearly every macro F1 and CSMF comparison. 


**CONCLUSIONS** PLMs using narratives alone substantially improved on current best practice and matched ML pipelines using structured responses, while multiple multimodal strategies produced further gains in individual COD assignment. The zero-shot LLM showed particular strength on rare causes, whereas supervised pipelines better recovered the population cause distribution. These findings support incorporating narratives as a core input to automated VA systems and evaluating representative fusion strategies for the intended output. External validation across settings and age groups will support broader implementation.