---
layout: paper
title: Prediction of overall survival for patients with metastatic castration-resistant prostate cancer; development of a prognostic model through a crowdsourced challenge with open clinical data
image: /assets/images/papers/iterative_imputation.png
authors: Guinney J et al., Zhenke Wu, as part of Bmore Dream Team in Prostate Cancer Challenge DREAM Community
year: 2017
shortref: Guinney et al. (2017). The Lancet Oncology
journal: "The Lancet Oncology"
doi: doi:10.1016/S1470-2045(16)30560-5
type: substantive
 
---

# Summary

## Background

Improvements to prognostic models in metastatic castration-resistant prostate cancer have the potential to augment clinical trial design and guide treatment strategies. In partnership with Project Data Sphere, a not-for-profit initiative allowing data from cancer clinical trials to be shared broadly with researchers, we designed an open-data, crowdsourced, DREAM (Dialogue for Reverse Engineering Assessments and Methods) challenge to not only identify a better prognostic model for prediction of survival in patients with metastatic castration-resistant prostate cancer but also engage a community of international data scientists to study this disease.

## Methods

Data from the comparator arms of four phase 3 clinical trials in first-line metastatic castration-resistant prostate cancer were obtained from Project Data Sphere, comprising 476 patients treated with docetaxel and prednisone from the ASCENT2 trial, 526 patients treated with docetaxel, prednisone, and placebo in the MAINSAIL trial, 598 patients treated with docetaxel, prednisone or prednisolone, and placebo in the VENICE trial, and 470 patients treated with docetaxel and placebo in the ENTHUSE 33 trial. Datasets consisting of more than 150 clinical variables were curated centrally, including demographics, laboratory values, medical history, lesion sites, and previous treatments. Data from ASCENT2, MAINSAIL, and VENICE were released publicly to be used as training data to predict the outcome of interest—namely, overall survival. Clinical data were also released for ENTHUSE 33, but data for outcome variables (overall survival and event status) were hidden from the challenge participants so that ENTHUSE 33 could be used for independent validation. Methods were evaluated using the integrated time-dependent area under the curve (iAUC). The reference model, based on eight clinical variables and a penalised Cox proportional-hazards model, was used to compare method performance. Further validation was done using data from a fifth trial—ENTHUSE M1—in which 266 patients with metastatic castration-resistant prostate cancer were treated with placebo alone.

## Findings

50 independent methods were developed to predict overall survival and were evaluated through the DREAM challenge. The top performer was based on an ensemble of penalised Cox regression models (ePCR), which uniquely identified predictive interaction effects with immune biomarkers and markers of hepatic and renal function. Overall, ePCR outperformed all other methods (iAUC 0·791; Bayes factor >5) and surpassed the reference model (iAUC 0·743; Bayes factor >20). Both the ePCR model and reference models stratified patients in the ENTHUSE 33 trial into high-risk and low-risk groups with significantly different overall survival (ePCR: hazard ratio 3·32, 95% CI 2·39–4·62, p<0·0001; reference model: 2·56, 1·85–3·53, p<0·0001). The new model was validated further on the ENTHUSE M1 cohort with similarly high performance (iAUC 0·768). Meta-analysis across all methods confirmed previously identified predictive clinical variables and revealed aspartate aminotransferase as an important, albeit previously under-reported, prognostic biomarker.

## Interpretation

Novel prognostic factors were delineated, and the assessment of 50 methods developed by independent international teams establishes a benchmark for development of methods in the future. The results of this effort show that data-sharing, when combined with a crowdsourced challenge, is a robust and powerful framework to develop new prognostic models in advanced prostate cancer.