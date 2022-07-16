---
layout: default
title: "people"
navtab: "people"
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


<div class="smalltitle text-left">Research Group Members </div>
<div class="bigspacer"></div>

I'm extremely fortunate to work with several amazing students to whom I serve as primary or co-advisor. <br>

<div class="bigspacer"></div>
<div class="row">
    {% for member in site.categories.team %}
    {% if member.alum == false and member.collaborator == false %}
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
<div class="smalltitle text-left">Alumni </div>
<div class="bigspacer"></div>

<div class="row">
    {% for member in site.categories.team %}
    {% if member.alum == true and member.collaborator == false %}
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

- **Chen Chen**, MS, Biostatistics, 2022, U of Michigan, Ann Arbor. Graduate Student Research Assistant (November 2021 to August 2022; co-advise with Mike Elliott). (*Variance as a predictor for survival outcomes*). First position after graduation: PhD Student in Biostatistics, University of Toronto.

<div class="bigspacer"></div>
<div class="smalltitle text-left">Summer Students: </div>
<div class="bigspacer"></div>

- **Zhongyuan Lyu**, MS, Applied Statistics, 2019, U of Michigan, Ann Arbor. Summer Intern. (Latent Class Model and Sparse Additive Regression Models)
- **Jiayuan Dong**, MS, Accelerated Master Degree Program (ADMP), 2021, U of Michigan, Ann Arbor; Summer Intern. (Readings on Probablistic Graphical Models)



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

