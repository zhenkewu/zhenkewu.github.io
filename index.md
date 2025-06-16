---
layout: default
title: Zhenke Wu, PhD
categories:
 - home
---
{% include JB/setup %}
{% for page in site.categories.about %}
{% if page.homepage %}
	{% assign homepage = page %}
{% endif %}
{% endfor %}

<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css">

<div>
{% include search-form-global.html %}
</div> 

<div class="row">
   <div class="col-sm-12">
        <div class="bigtitle logobox">
            Zhenke Wu Research
        </div> 
    </div>
</div>	

<br>

**Name in Chinese:**[ 吴振科 <i class="fa-brands fa-soundcloud"></i>](https://soundcloud.com/zhenke-wu/zhenke-wu-name). Pronounced: "Jen-Kuh Wu".

[Bio + Contact](/team/zhenke-wu)

[Publications](/papers/) by: [year](papers/archive/year) or [topic](papers/archive/topic) or [word cloud](papers/archive/explore)

CV: [[pdf]](assets/pdfs/team/zhenkewu_cv.pdf) or [[1-pager]](assets/pdfs/team/zhenkewu_cv_one_page.pdf) or [[Overleaf]](https://www.overleaf.com/read/dbktqfjxccbv)

[[<i class="fa-brands fa-google-scholar"></i> Google Scholar]](https://scholar.google.com/citations?user=3ffCNrEAAAAJ&hl=en) [[<i class="fa-brands fa-github"></i> GitHub]](https://github.com/zhenkewu?tab=activity) [[<i class="fa-brands fa-x-twitter"></i>]](https://twitter.com/ZhenkeWu)

The best way to contact me is email (zhenkewu [arroba] umich [punto] edu). 

Direction to my office is [here](assets/pdfs/team/zhenkewu-office.pdf).

<hr/>

## About Me

I am an [Associate Professor](https://sph.umich.edu/faculty-profiles/wu-zhenke.html) (with tenure) in the [Department of Biostatistics](https://sph.umich.edu/biostat/) at [University of Michigan](https://www.umich.edu) and a faculty affiliate at [Michigan Institute for Data and AI in Society (MIDAS)](http://midas.umich.edu).

## Working Group

- [__Michigan Statistics for Individualized-healthcare Lab (MiSIL)__ weekly meeting schedules](https://docs.google.com/spreadsheets/d/1CfHqh74SrGH5zuo8W_L_hAGdLJdt_9jLgaeBtoxYp88/edit?usp=sharing)
  
## Research Vision

**Tagline**: Advancing AI and Personalized Healthcare Through Methodological Innovation

My research bridges the gap between cutting-edge AI and statistical methodology and real-world healthcare challenges. I focus on developing innovative solutions that make healthcare more accessible and personalized, particularly for underserved populations.

### Core Research Areas

1. **Bayesian Methods and AI**
   - Latent variable models for disease subtyping
   - Scalable Bayesian computation methods
   - Nonparametric Bayesian approaches
   - *Impact*: Improving disease classification and enabling personalized treatment strategies

2. **Precision Health and Digital Health**
   - Sequential intervention design
   - Causal inference and reinforcement learning
   - Mobile health and wearable data analytics
   - Adaptive interventions
   - *Impact*: Enhancing healthcare delivery through data-driven personalization

3. **Global Health Research**
   - Infectious disease epidemiology
   - Mental health solutions for low-resource settings
   - Mortality estimation in developing countries
   - Healthcare worker support systems
   - *Impact*: Making healthcare more accessible in underserved communities

### Research Collaborations

We collaborate with leading organizations and initiatives:
- [Intern Health Study](https://www.srijan-sen-lab.com/intern-health-study) - World's largest multi-year microrandomized trial
- [openVA - mortality estimation using verbal autopsy](https://openva.net/) - Pioneering domain-adaptive mortality estimation
- [Center for Clinical Outcomes Development and Application (CODA)](https://medresearch.umich.edu/labs-departments/centers/coda)
- [Data Science in Africa] - [UZIMA-DS project](https://uzimadatascience.org/) - Advancing digital mental health in Kenya
- [Precision Health: PROMPT](https://precisionhealth.umich.edu/workgroups/prompt/) - Mental health precision treatment
- [Cancer Control and Population Sciences, Rogel Cancer Center](http://www.mcancer.org/research/programs/cancer-control-and-population-sciences)
- [The Michigan Genomics Initiative](https://www.michigangenomics.org)

## Join Our Team

### Current Opportunities

- **[AI in Science Postdoctoral Fellowship Program](https://midas.umich.edu/training/postdoctoral-programs/schmidt-ai-in-science-postdoctoral-fellowship/)**
  - Competitive salary and benefits
  - Travel support for AI in Science events
  - Collaborative research environment
  - Opportunity to work on AI applications in science
  - Access to computing resources
  - Network of researchers

### We're Looking For

Join us if you're interested in:
- Bayesian methods and computation
- Graphical models
- Causal inference
- Sequential decision making
- Reinforcement learning
- Large-scale health data analytics

### How to Apply

1. Review our [research themes](#research-vision) and [recent publications](papers/archive/year)
2. [Contact us](/sayhi/) to discuss your interests
3. Complete our [Google Form](https://forms.gle/zNf4aMBiE69prweU7) to apply

### Why Join Us?

- Work on meaningful research that impacts healthcare
- Access to resources and collaborators
- Opportunities for professional development
- Supportive research environment
- Work on AI and healthcare applications
- Opportunities to present at conferences
- Track record of successful career placements



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
					<i class="fa-regular fa-file-lines"></i>
					<a class="off" href="{{ paper.url }}">
					{{ paper.title }}
					</a>
					<br/>
					<div class='shortref note'>
					{{ paper.shortref }} ({{ paper.year }}). {% if paper.journal and paper.journal != "" %}<i>{{ paper.journal }}.</i>
          {% else %}{% endif %}
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
					<i class="fa-solid fa-blog"></i>
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
</div>

<div class="bigspacer"></div>
