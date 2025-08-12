---
layout: default
title: "team"
navtab: "team"
description: "People in the lab"
group: navigation
navorder: 4
---
{% include JB/setup %}

<style>
    img.photo{
          object-fit: cover;
          border-radius: 50%;
          object-position: 10% 10%; 
          width:150px;
          height:150px;
    }
</style>


<div>
{% include search-form-global.html %}
</div> 

<div class="smalltitle text-left">Research Group Members </div>
<div class="bigspacer"></div>

I'm extremely fortunate to work with several amazing students to whom I serve as primary or co-advisor. <br>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Current </div>
<div class="bigspacer"></div>

<div class="row">
    {% for member in site.categories.team %}
    {% if member.alum == false and member.collaborator == false and member.support == false %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {%endif%}
    {% endfor %}   
</div>

<div class="bigspacer"></div>

Undergraduate Students (those writing paper with lab is marked with $^*$):

- $^*$[**Peter Yang**](https://peteryang.xyz/), Undergrad, Math/Computer Science/Stat, U of Michigan. "Apple SensorKit Data Analysis"
- $^*$[**Jianhan Zhang**](https://www.linkedin.com/in/jianhan-zhang-175536231/), co-mentored by [Jitao Wang](/team/jitao-wang) Undergrad, Pure Math, Data Science, U of Michigan. "Counterfactual Fairness in Reinforcement Learning"

<div class="bigspacer"></div>

<div class="smalltitle text-left">Research Staff </div>

- Zihan Wang. MS, Biostatistics, U of Michigan (2025). 


<!-- <div class="bigspacer"></div>

<hr/>
<div class="bigspacer"></div>
<div class="smalltitle text-left">Support Staff </div>
<div class="bigspacer"></div> -->

<div class="row">
    {% for member in site.categories.team %}
    {% if member.support == true and member.alum == false %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {%endif%}
    {% endfor %}    
</div>

<div class="bigspacer"></div>


<hr/>
<div class="bigspacer"></div>
<div class="smalltitle text-left">Past Members </div>
<div class="bigspacer"></div>

Please send an email to zhenkewu@gmail[punto]com for updates.
<br>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Former PhD Students: </div>
<div class="bigspacer"></div>

<div class="row">
    {% for member in site.categories.team %}
    {% if member.showicon == true and member.alum == true and member.collaborator == false %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {%endif%}
    {% endfor %}    
</div>

<div class="bigspacer"></div>




<div class="bigspacer"></div>
<div class="smalltitle text-left">Former MS Students: </div>
<div class="bigspacer"></div>
- [**Abigail Loe**](/team/abigail-loe). Next position: PhD Student in UMich Biostat
- [**Xingran Chen**](/team/xingran-chen). Next position: PhD Student in UMich Biostat
- [**Jieru Shi**](/team/jieru-shi). Next position: PhD Student in UMich Biostat
- [**Jitao Wang**](/team/jitao-wang). Next position: PhD Student in UMich Biostat
- [**Mengbing Li**](/team/mengbing-li). Next position: PhD Student in UMich Biostat
- **Chen Chen**, MS, Biostatistics, 2022, U of Michigan, Ann Arbor. Graduate Student Research Assistant (November 2021 to August 2022; co-advise with Mike Elliott). (*Variance as a predictor for survival outcomes*). First position after graduation: PhD Student in Biostatistics, University of Toronto.
- [**Jing Chu**](/team/jing-chu), MS in Applied Statistics, Department of Statistics, U of Michigan, Ann Arbor, 2018. Topic: Regression Extension to Bayesian Analytic Kit for Etiology Research (baker).
- [**Zhongyuan Lyu**](https://zhongyuanlyu.github.io/), MS, Applied Statistics, U of Michigan, Ann Arbor. 2019 Summer. Topic: Latent Class Model and Sparse Additive Regression Models" First position after graduation: Hong Kong University of Technology and Science, Math PhD Student. Now: Lecturer (Assistant Professor) in the Discipline of Business Analytics, University of Sydney Business School,


<div class="bigspacer"></div>
<div class="smalltitle text-left">Former Undergraduate Students (those who wrote paper in the lab is marked with $^*$): </div>
<div class="bigspacer"></div>
- 2024 Fall: [**Owen Yoo**](https://owen-hy.github.io/personal-web/), Undergrad,  Statistics and Data Science, Minor in Music, U of Michigan. "Prior elicitation algorithms for inferring causes of death from computer-coded verbal autopsy data"
- $^*$2023 Summer: **Bolin Wu** (co-mentored by [Mengbing Li](/team/mengbing-li)), Undergrad, Computer Science, U Of Michigan, Ann Arbor. "Shinyapp for Enhancing Latent Class Analysis using Dirichlet Diffusion Tree". First position after graduation: Carnegie Mellon University, Master of Computational Data Science Program. 
- 2021 Summer: **Jiayuan Dong**, MS, Accelerated Master Degree Program (ADMP), U of Michigan, Ann Arbor; Summer Intern. (Readings on Probablistic Graphical Models). First position after graduation: UMich, Mechanical Engineering PhD Student


<!--
<div class="container">
<div class="smalltitle text-left">Research Group Members </div>
<div class="bigspacer"></div>
{% for member in site.categories.team %}
	{% if member.alum == false and member.collaborator == false %}
	    {% cycle 'add rows': '<div class="row">', '', '' %}
			<div class="col-md-9 memberbox">
				<div class="media">
	  				<a class="pull-left" href="{{ member.url }}">
	    				<img class="media-object member-photo" src="{{ member.image }}">
	  				</a>
	 			 	<div class="media-body">
	    				<div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>
	    				<p class="note">{{ member.position }}</p>
						{% if member.cv %}		
						<div class="smallhead">
							CV
						</div>	
						<div class="pad-left note">
							<div class="smallspacer"></div>
							<i class="fa fa-file-text-o fa-fw"></i>			
							<a class="off" href="{{ member.cv }}">{{ member.cv | split: '/' | last }}</a>
						</div>		
						<div class="bigspacer"></div>		
						{% endif %}
	  				</div>
				</div>
	        </div>	  
	    {% cycle 'close rows': '', '', '</div><div class="bigspacer"></div>' %}
	{% endif %}
{% endfor %}
{% cycle 'close rows': '', '</div><div class="bigspacer"></div>', '</div><div class="bigspacer"></div>' %}
</div>

-->
<!--
<hr/>
<div class="title text-center">Collaborators </div>

<div class="container">
<div class="smalltitle text-left">Statisticians </div>
{% for member in site.categories.team %}
	{% if member.field == "stat" and member.collaborator == true %}
	    {% cycle 'add collaborator rows': '<div class="row">', '', '' %}
			<div class="col-md-4 memberbox">
				<div class="media">
	  				<a class="pull-left" href="{{ member.url }}">
	    				<img class="media-object member-photo" src="{{ member.image }}">
	  				</a>
	 			 	<div class="media-body">
	    				<div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>
	    				<p class="note">{{ member.position }}</p>
	  				</div>
				</div>
	        </div>	  
	    {% cycle 'close collaborator rows': '', '', '</div><div class="bigspacer"></div>' %}
	{% endif %}
{% endfor %}
{% cycle 'close collaborator rows': '', '</div><div class="bigspacer"></div>', '</div><div class="bigspacer"></div>' %}
</div>

<div class="bigspacer"></div>
<hr/>
<div class="container">
<div class="smalltitle text-left">Scientists </div>
<div class="bigspacer"></div>

<div class="smalltitle text-left">Childhood Pneumonia </div>
{% for member in site.categories.team %}
	{% if member.field == "pneumonia" and member.collaborator == true%}
	    {% cycle 'add scientist rows': '<div class="row">', '', '' %}
			<div class="col-md-4 memberbox">
				<div class="media">
	  				<a class="pull-left" href="{{ member.url }}">
	    				<img class="media-object member-photo" src="{{ member.image }}">
	  				</a>
	 			 	<div class="media-body">
	    				<div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>
	    				<p class="note">{{ member.position }}</p>
	  				</div>
				</div>
	        </div>	  
	    {% cycle 'close scientist rows': '', '', '</div><div class="bigspacer"></div>' %}
	{% endif %}
{% endfor %}
{% cycle 'close scientist rows': '', '</div><div class="bigspacer"></div>', '</div><div class="bigspacer"></div>' %}

<div class="smalltitle text-left">Autoimmune Diseases and Cancer </div>
{% for member in site.categories.team %}
	{% if member.field == "Autoimmune Diseases and Cancer" and member.collaborator == true%}
	    {% cycle 'add scientist rows': '<div class="row">', '', '' %}
			<div class="col-md-4 memberbox">
				<div class="media">
	  				<a class="pull-left" href="{{ member.url }}">
	    				<img class="media-object member-photo" src="{{ member.image }}">
	  				</a>
	 			 	<div class="media-body">
	    				<div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>
	    				<p class="note">{{ member.position }}</p>
	  				</div>
				</div>
	        </div>	  
	    {% cycle 'close scientist rows': '', '', '</div><div class="bigspacer"></div>' %}
	{% endif %}
{% endfor %}
{% cycle 'close scientist rows': '', '</div><div class="bigspacer"></div>', '</div><div class="bigspacer"></div>' %}

</div>
-->
<!-- comment out the line with /div if there are multiples of three alumni -->

<div class="bigspacer"></div>

