---
layout: default
title: Zhenke Wu, PhD
categories:
 - home
---
{% include JB/setup %}
{% for page in site.categories.misc %}
{% if page.homepage %}
	{% assign homepage = page %}
{% endif %}
{% endfor %}

<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css">

<div class="row">
	<div class="col-md-12">
		<!-- <object class="pull-left biglogo" data="assets/themes/lab/images/logo/logo-none.svg" type="image/svg+xml"></object> -->
		<div class="bigtitle logobox">
			Zhenke Wu Research
		</div>
	</div>	
	
</div> 
**Name in Chinese:**[ 吴振科 <i class="fa fa-soundcloud"></i>](https://soundcloud.com/zhenke-wu/zhenke-wu-name). Pronounced: "Jen-Kuh Wu".


[[Publications]](/papers/) [[CV-overleaf]](https://www.overleaf.com/read/dbktqfjxccbv) [[CV-pdf]](assets/pdfs/team/zhenkewu_cv.pdf) [[Contact]](/team/zhenke-wu) [[Bio]](/team/zhenke-wu)

[[Google Scholar<i class="ai ai-google-scholar"></i>]](https://scholar.google.com/citations?user=3ffCNrEAAAAJ&hl=en) [[GitHub<i class="fa fa-github"></i>]](https://github.com/zhenkewu?tab=activity) [[X<i class="fa fa-twitter"></i>]](https://twitter.com/ZhenkeWu).

The best way to contact me is email (zhenkewu [arroba] umich [punto] edu). Direction to my office is [here](assets/pdfs/team/zhenkewu-office.pdf).


<hr/>
I am an [Associate Professor](https://sph.umich.edu/faculty-profiles/wu-zhenke.html) (with tenure) in the [Department of Biostatistics](https://sph.umich.edu/biostat/) at [University of Michigan](https://www.umich.edu) and a faculty affiliate at [Michigan Institute for Data Science (MIDAS)](http://midas.umich.edu). 

<hr/>

**Research Theme**:

My research is motivated by biomedical and public health problems and is centered on the design and application of statistical methods that inform health decisions made by individuals, or precision medicine. Towards this goal, I focus on two lines of methodological research: a) structured Bayesian latent variable models for clustering and disease subtyping, and b) study design, causal and reinforcement learning methods for evaluating sequential interventions that tailor to individuals' changing circumstances such as in interventional mobile health studies. I am committed to developing robust, scalable, and interpretable statistical methods to harness real-world, high-dimensional, dynamic data for individualized health. The methods and software developed so far have supported studies in diverse scientiﬁc ﬁelds including infectious disease epidemiology, autoimmune diseases, mental health, behavioral health, and cancer. 

**Keywords**:

- *Statistical*: Hierarchical Bayesian models; Latent variable models; Nonparametric Bayes; Bayesian scalable computation; Causal inference; Reinforcement learning.

- *Substantive*: Precision medicine; Wearable device data; Mobile health; Infectious diseases; Mental health; Electronic health records/claims data; Healthcare policy; Clinical trials; Just-in-time adaptive interventions for behaviorial and psychiatric research; Computational Social Science.


<!-- Currently a major focus of my work is on the analysis of multiple mixed-type longitudinal measurements with feedbacks in treatment assignments. I am working on hierarchical Bayesian methods to infer latent trajectories that represent individual disease progressions that have direct applications to childhood pneumonia etiology studies, analyses of electronic health records and claims data, and just-in-time adaptive interventions (JITAI) in mobile health (mHealth) studies. -->


<hr/>

<!-- **Postdoc Openning**

- **[Rolling Reviews: Postdoc Position on Statistical Methods to Individualize Care for Mental Health](https://docs.google.com/document/d/1Eq8VmqvYrF2Fqo5UxzjZbKQpJPnbZWxJTRYbL-6J19I/edit)** -->


**Advising**: We are recruiting motivated and hard-working people interested in Bayesian methods and computation, graphical models, causal inference, sequential decision making, reinforcement learning and large-scale health data analytics. If you want to get involved, please [say hi](/sayhi/). 


*Check this out and send me an email if interested in collaborating!*

[**AI in Science Postdoctoral Fellowship Program**](https://midas.umich.edu/ai-in-science/); The program will pay a competitive salary ($74,000 annually for 2022-23) plus benefits. Travel to funder’s AI in Science events will also be covered.


**Working Group**:

- [__Michigan Statistics for Individualized-healthcare Lab (MiSIL)__ weekly meeting schedules](https://docs.google.com/spreadsheets/d/1CfHqh74SrGH5zuo8W_L_hAGdLJdt_9jLgaeBtoxYp88/edit?usp=sharing)

<!-- Past:

- [__Statistical Learning and Computing Reading Group, Winter 2019__](/teaching/statistical_learning_reading_group) -->



<!-- * Bayesian hierarchical models: biomarkers, data integration, scalable computation, model-averaging;
* Latent variable models: dynamics, measurement errors, local dependence, partial-identifiability; 
* Robust inference: bias reduction, efficiency enhancement by covariate-calibration, semiparametric locally efficient estimation, deductive inference;
* Causal analysis of modern study designs;
* Collaborations: mental health, infectious disease, autoimmune disease, medical diagnosis, epidemiology, health policy, cancer, mobile health, Just-in-time adaptive interventions for behaviorial and psychiatric research.
 -->
<hr/>

I collaborate closely with 

- [Intern Health Study](https://www.srijan-sen-lab.com/intern-health-study)
- [openVA](https://openva.net/)
- [Data Science in Africa] - the [UZIMA-DS project](https://uzimadatascience.org/).
- [D3 Lab: Data Science for Dynamic Intervention Decision-Making Lab](http://d3lab-isr.com/team/)

- [The Michigan Genomics Initiative](https://www.michigangenomics.org)
- [Precision Health Use Case: PROviding Mental Health Precision Treatment (PROMPT)](https://precisionhealth.umich.edu/workgroups/prompt/)
- [Cancer Control and Population Sciences, Rogel Cancer Center](http://www.mcancer.org/research/programs/cancer-control-and-population-sciences)

- [Rheumatology at Johns Hopkins](https://www.hopkinsrheumatology.org/research/rosen-casciola-lab/)
- [Hopkins inHealth](http://hopkinsinhealth.jhu.edu/) methodology group
- [International Vaccine Access Center (IVAC)](http://www.jhsph.edu/research/centers-and-institutes/ivac/)

<br />

<hr/>

<div class="row">
	<div class="col-md-12">
		<div class="head">
			{{ homepage.content }}
		</div>
	</div>				
</div>

<div class="row">
	

	
	<div class="col-md-4">
		<div class="head">
			<a class="off" href="/papers/">Recent Papers
			</a>
		</div>
		<div class="bigspacer"></div>
		<div class="feedbox pad-left">		
			{% for paper in site.categories.papers limit:10 %}
				<div class="note-title">
					<i class="fa fa-file-text-o fa-fw"></i>
					<a class="off" href="{{ paper.url }}">
					{{ paper.title }}
					</a>
					<br/>
					<div class='shortref note'>
					{{ paper.shortref }}
					</div>
				</div>
				<div class="smallspacer"></div>
				<div class="smallnote">
					Published
					{{ paper.date | date_to_string }}
				</div>
				<div class="spacer"></div>	
				<div class="spacer"></div>				
			{% endfor %}
		</div>
		<div class="bigspacer"></div>		
	</div>
	
    	<div class="col-md-4">
		<div class="head">
			<a class="off" href="/news/">News</a>
		</div>
		<div class="bigspacer"></div>
		<div class="feedbox pad-left">
			{% for news in site.categories.news limit:5 %}
			
				{% for member in site.categories.team %}
					{% if member.handle == news.author_handle %}
						{% assign author = member %}
					{% endif %}
				{% endfor %}		
				
				<div class="note-title">
					<i class="fa fa-bullhorn"></i>
					<a class="off" href="{{ news.url }}">
					{{ news.title }}
					</a>
				</div>
				<div class="note">
					{{ news.content }}
				</div>
				<div class="smallspacer"></div>
				<div class="smallnote">
					Posted
					{{ news.date | date_to_string }}
					{% if author %}
					by <a class="off" href="{{ author.url }}">{{ author.handle }}</a>
					{% endif %}						
				</div>
				<div class="spacer"></div>	
				<div class="spacer"></div>				
			{% endfor %}
		</div>
		<div class="bigspacer"></div>		
	</div>

	<div class="col-md-4">
		<div class="head">
			<a class="off" href="/blog/">Blogs</a>
		</div>
		<div class="bigspacer"></div>
		<div class="feedbox pad-left">
			{% for blog in site.categories.blog limit:5 %}
				<div class="note-title">
					<i class="fa fa-comment-o fa-fw"></i>
					<a class="off" href="{{ blog.url }}">
					{{ blog.title }}
					</a>
					<br/>
					<div class='shortref note'>
					{{ blog.description }}
					</div>
				</div>
				
				<div class="smallspacer"></div>
				<div class="smallnote">
					Posted
					{{ blog.date | date_to_string }}
					{% if author %}
					by <a class="off" href="{{ author.url }}">{{ author.handle }}</a>
					{% endif %}						
				</div>
				<div class="spacer"></div>	
				<div class="spacer"></div>
				
				<div class="smallspacer"></div>
				<div class="spacer"></div>
				<div class="spacer"></div>
			{% endfor %}
		</div>
		<div class="bigspacer"></div>
	</div>
	
	<!-- <div class="col-md-4">
		<div class="head">
			<a class="off" href="/projects/">Projects</a>
		</div>
		<div class="bigspacer"></div>
		<div class="feedbox pad-left">
			{% for project in site.categories.project limit:4 %}
				<div class="note-title">
					<i class="fa fa-terminal"></i>
					<a class="off" href="{{ project.url }}">
					{{ project.title }}
					</a>
					<br/>
					<div class='shortref note'>
					{{ project.tags }}
					</div>
				</div>
				<div class="smallspacer"></div>
				<div class="spacer"></div>
				<div class="spacer"></div>
			{% endfor %}
		</div>
		<div class="bigspacer"></div>
	</div> -->


</div>

<div class="bigspacer"></div>

