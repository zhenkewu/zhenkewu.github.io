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

<div class="row">
	<div class="col-md-12">
		<!-- <object class="pull-left biglogo" data="assets/themes/lab/images/logo/logo-none.svg" type="image/svg+xml"></object> -->
		<div class="bigtitle logobox">
			Zhenke Wu Research
		</div>
	</div>	
<!-- 	    <i class="fa fa-soundcloud"></i> 
		<a href="https://soundcloud.com/zhenke-wu/zhenke-wu-name"> Name in Chinese: 吴振科 </a>  -->		
</div> 
**Name in Chinese:**[ 吴振科 <i class="fa fa-soundcloud"></i>](https://soundcloud.com/zhenke-wu/zhenke-wu-name). Pronounced: "Jen-Kuh Wu".

[Here](/papers/) are my publication samples. My CV is [here](/assets/pdfs/team/zhenkewu-cv.pdf), contact info is [here](/team/zhenke-wu). My GitHub is [here](https://github.com/zhenkewu?tab=activity) and Bio is [here](/team/zhenke-wu). A recent faculty profile is [here](http://midas.umich.edu/faculty-member/zhenke-wu/).

The best way to contact me is email. Direction to my office is [here](assets/pdfs/team/zhenkewu-office.pdf).


<hr/>
I am an [Assistant Professor](https://sph.umich.edu/faculty-profiles/wu-zhenke.html) in the [Department of Biostatistics](https://sph.umich.edu/biostat/) at [University of Michigan](https://www.umich.edu), with joint appointment as [Research Assistant Professor](http://midas.umich.edu/faculty-member/zhenke-wu/) in [Michigan Institute for Data Science (MIDAS)](http://midas.umich.edu). I am also Faculty Associate in [Quantitative Methodology Program](http://www.qmp.isr.umich.edu/), [Survey Research Center](http://home.isr.umich.edu/centers/src/) of Institute for Social Research ([ISR](http://home.isr.umich.edu/)), University of Michigan.

<hr/>

I am interested in the design and application of statistical methods that inform health decisions made by individuals, or precision medicine. My current focus is on latent variable and causal inference methods that can support disease etiology studies, medical diagnosis, and health policy evaluation. Broadly, the statistical goal is to discover simple latent structures that improve inferences and population parameters and individual latent states. I have also worked on causal inference methods 1) to evaluate novel treatment rules under special designs like matched-pair cluster randomized design, as these designs are useful for interventions that can only be applied at cluster level; and 2) to facilitate the inference for novel estimands in semiparametric models by automating and unifying the derivation of efficient influence functions (EIF) and ensuing estimation.

Currently a major focus of my work is on the analysis of multiple mixed-type longitudinal measurements with feedbacks in treatment assignments. I am working on hierarchical Bayesian methods to infer latent trajectories that represent individual disease progressions that have direct applications to childhood pneumonia etiology studies, analyses of electronic health records and claims data, and just-in-time adaptive interventions (JITAI) in mobile health (mHealth) studies.


<hr/>

**Postdoc Openning**

- ** [Rolling Reviews] Postdoc Position on Statistical Methods to Individualize Care for Mental Health](https://docs.google.com/document/d/1Eq8VmqvYrF2Fqo5UxzjZbKQpJPnbZWxJTRYbL-6J19I/edit)**


**Advising**: We are recruiting motivated and hard-working students interested in Bayesian methods and computation, graphical models and large-scale health data analytics. If you are interested in joining the group, please apply to Biostatistics at the University of Michigan, Ann Arbor. If you are an undergrad or grad student at the University of Michigan, and you are interested in any of the papers or projects listed on this website, send me an email with your interests and CV.

**Working Groups**

- [__Michigan Statistics for Individualized-healthcare Lab (MiSIL)__ weekly meeting schedules](https://docs.google.com/spreadsheets/d/1CfHqh74SrGH5zuo8W_L_hAGdLJdt_9jLgaeBtoxYp88/edit?usp=sharing)

- [__Statistical Learning and Computing Reading Group, Winter 2019__](/teaching/statistical_learning_reading_group)

<hr/>

Research interests:

* Bayesian hierarchical models: biomarkers, data integration, scalable computation, model-averaging;
* Latent variable models: dynamics, measurement errors, local dependence, partial-identifiability; 
* Robust inference: bias reduction, efficiency enhancement by covariate-calibration, semiparametric locally efficient estimation, deductive inference;
* Causal analysis of modern study designs;
* Collaborations: mental health, infectious disease, autoimmune disease, medical diagnosis, epidemiology, health policy, cancer, mobile health, Just-in-time adaptive interventions for behaviorial and psychiatric research.

<hr/>

I collaborate closely with 

- [The Michigan Genomics Initiative](https://www.michigangenomics.org)
- [D3 Lab: Data Science for Dynamic Intervention Decision-Making Lab](http://d3lab-isr.com/team/)
- [Cancer Control and Population Sciences, Rogel Cancer Center](http://www.mcancer.org/research/programs/cancer-control-and-population-sciences)
- [Intern Health Study](https://www.srijan-sen-lab.com/intern-health-study)
- [Precision Health Use Case: PROviding Mental Health Precision Treatment (PROMPT)](https://precisionhealth.umich.edu/workgroups/prompt/)

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

