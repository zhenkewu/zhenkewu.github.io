---
layout: post
title: "2016 Fall: BIOSTAT830 Graphical Models"
description: ""
author: Zhenke Wu
author_handle: Zhenke Wu
master: false
published: true
theme: lab
tags: 
  - graphical model
---
{% include JB/setup %}
![graphical-title-image](http://d29qn7q9z0j1p6.cloudfront.net/content/roypta/371/1984/20120222/F4.large.jpg){:class="img-responsive"}

# Statistical and Computational Methods for Learning through Graphical Models
------

* **Instructor**: [Zhenke Wu](http://zhenkewu.com) PhD, Assistant Professor of Biostatistics
* **Email**: zhenkewu@umich.edu
* **Time**: Tuesday and Thursday 12:30-2pm (15 weeks; September 6th to December 13th, 2016)
* **Location**: 4332 SPH II
* **Office Hours**: {{ site.department.office }}; Tuesdays 2-3pm or by appointment

------

## Announcements

* [12/08/2016] Please fill out the [[end-of-term survey]](https://goo.gl/forms/OhsoYT4TNmP9bCVy2) by December 21, 2016.
* [12/08/2016] [[Homework 4]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps4.pdf) posted; Due to Instructor by 11:59pm on **December 21, 2016**.
* [11/27/2016]  Deadline for extra credit problems: **midnight, December 15, 2016**.
* [11/08/2016] [[Homework 3]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps3.pdf) posted; Due to Instructor by 11:59pm on **December 15, 2016**.
* [11/01/2016] [[Homework 2]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps2.pdf) posted; Due to Instructor by 11:59pm on **November 21, 2016**.
* [10/15/2016] Please fill out the midterm survey [here](https://goo.gl/forms/AMfJ1t1d0gQbgQXI3).
* [09/26/2016] Homework 1 due date extended to 11:59pm on October 10th. I have also redistributed the credits to the theory problems and added extra comments. Please refer to the [[revised Problem Set 1]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps1_revised.pdf).
* [09/26/2016] The instructor has moved to a new office 4623 SPH-I within Suite 4605. 
* <span style="color:red;"> [09/19/2016] [Problem Set 1 (obsolete; use the revised one)](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps1.pdf) posted. **Due 11:59PM, October 3rd, 2016 to Instructor's email in electronic copy.** </span>
* [09/17/2016] Now you can comment to improve the course at the bottom of this page. Or if you like it, please tweet to share for others who are interested in learning, programming and applying graphical models!
* [09/08/2016] Please fill out the [class survey for the first week](https://goo.gl/forms/q4mwWHG8RkNeJMH83).

------

## Syllabus

The pdf file linked below introduces the course objectives, organizational structures, lectures, references, evaluations and other course policies.

* Syllabus [[pdf]](/assets/pdfs/slides/teaching/2016/biostat830/BIOSTAT830-syllabus.pdf)

------

## Lecture Notes (required readings at the end of lecture notes):

<details>
  <summary>Calendar of Upcoming Lectures [click to expand]</summary>
  <div class="span3">
<div id="upcoming"></div><!--/span-->
</div>
<div class="span9">
	<iframe src="https://calendar.google.com/calendar/embed?src=m1v75gnveubh3skivkbqhsbdvk%40group.calendar.google.com&ctz=America/New_York" style=" border-width:0 " width="100%" height="600" frameborder="0" scrolling="no"></iframe>
</div><!--/span-->
</details>

#### Module 1 (Representations)
+ Lecture 1 - Introduction [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture1.pdf)
+ Lecture 2 - D-separation in DAG and Probabilistic Conditional Independence [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture2.pdf)
+ Lecture 3 - D-separation continued (blackboard)
+ Lecture 4 - Representation for Undirected Graphical Models [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture4.pdf)
+ Lecture 5 - DAG and UG: Connections and Differences [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture5.pdf)
+ Lecture 6 - Examples of DAG and UG and Conclusion of the Representation Module [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture6_nodemo.pdf)[[RMarkdown file with Shiny Demo]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture6.zip). Please use `RStudio` to run the `.Rmd` file to generate Shiny `R` Presentation.


#### Module 2 (Inference and Computation for Graphical Models)
+ Lecture 7 - Exact inference: factor graphs and variable elimination [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture7.html)
+ Lecture 8 - Exact inference: Belief Propagation [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture8.html)
+ Lecture 9 - Exact inference Examples [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture9.html)
+ Lecture 10 - Junction Tree Algorithm [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture10.html)
+ Lecture 12 - Examples of Junction Tree Algorithm [[marked slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/lecture12_inclass_marked.pdf)
+ Lecture 13 - Approximate Inference by Stochastic Simulation/Sampling Methods [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture13.pdf)
+ Lecture 14 - Survey of Automatic Bayesian Software and Why You Should Care [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture14.pdf)[[code]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture14code.zip)
+ Lecture 15 - Variational Inference Basics [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture15.html)[[whiteboard-notes]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture15-extra-notes.pdf)
+ Lecture 16 - Variational Inference: Examples 
    - [[hand-written notes]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/lecture16_extra_notes.pdf) 
    - [[*Required Reading*: Blei DM et al. (2016). Variational Inference: A Review for Statisticians. Preprint]](https://arxiv.org/pdf/1601.00670v3.pdf)
    - [[*Optional Reading*: Blei DM et al. (2003). Latent Dirichlet Allocation. Journal of Machine Learning Research.]](https://www.cs.princeton.edu/~blei/papers/BleiNgJordan2003.pdf)

#### Module 3 (Graphical Models for Causality)
+ Lecture 18 - Causal Inference in Medicine and Public Health: An Introduction [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture18.html)
+ Lecture 19/20 - Causal Diagram [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/lecture19_continued.pdf)
+ Lecture 21 - Marginal Structural Models [[Note on IPW]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/lecture21_ipw.html)


#### Module 4 (Case Studies)

+ Nov 29: Professor [Jian Kang](http://www-personal.umich.edu/~jiankang/) on Graphical Models for Neuroscience.
    - *Title*: **Identifying Functional Co-Activation Patterns in Neuroimaging Studies Via Poisson Graphical Models**
    - *Abstract*: Studying the interactions between different brain regions is essential to achieve a more complete understanding of brain function. In this talk, we focus on identifying functional co-activation patterns and undirected functional networks in neuroimaging studies. We build a functional brain network, using a sparse covariance matrix, with elements representing associations between region-level peak activations. We adopt a penalized likelihood approach to impose sparsity on the covariance matrix based on an extended multivariate Poisson model. We obtain penalized maximum likelihood estimates via the expectation-maximization (EM) algorithm and optimize an associated tuning parameter by maximizing the predictive loglikelihood. Permutation tests on the brain co-activation patterns provide region pair and network-level inference. Simulations suggest that the proposed approach has minimal biases and provides a coverage rate close to 95% of covariance estimations. Conducting a meta-analysis of 162 functional neuroimaging studies on emotions, our model identifies a functional network that consists of connected regions within the basal ganglia, limbic system, and other emotion-related brain regions. We characterize this network through statistical inference on region-pair connections as well as by graph measures.

+ Dec 1: Cancelled [Junhyuk Oh](https://sites.google.com/a/umich.edu/junhyuk-oh/) on Deep Learning and Reinforcement Learning:
    - *Title*: **Improving Generalization via Deep Reinforcement Learning**
    - *Abstract*: The ability to generalize from past experience to solve previously unseen tasks or environments is a key research challenge in reinforcement learning (RL). In this talk, I will briefly introduce the basic idea of deep reinforcement learning (Deep RL) and present my recent work that aims to improve generalization ability of RL agents through deep learning. The first work focuses on how to generalize over unseen and larger topologies in 3D world given navigational tasks. The second work discusses how to generalize over new tasks that are described by natural language.

+ Dec 1: [Nested partially latent class models for dependent binary data; estimating disease etiology](http://biostatistics.oxfordjournals.org/content/early/2016/08/19/biostatistics.kxw037.short?rss=1)

+ Dec 6 and 8: Integrated nested Laplace Approximation by Rue et al. 2009 [[slides]](/assets/pdfs/slides/teaching/2016/biostat830/lecture_notes/Lecture26.pdf)

------

## Homework Assignment

* Problem Set 1[[pdf]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps1_revised.pdf)[[solution]](/assets/pdfs/slides/teaching/2016/biostat830/homework/hw1_sol.html)
* Problem Set 2[[pdf]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps2.pdf)
[[ps2_data.zip]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps2_data.zip)
* Problem Set 3[[pdf]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps3.pdf)
* Problem Set 4[[pdf]](/assets/pdfs/slides/teaching/2016/biostat830/homework/ps4.pdf)


------




