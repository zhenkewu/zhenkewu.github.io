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

    .member-db-cta {
          margin: 10px 0 20px 0;
          padding: 12px 14px;
          border: 1px solid #dfe7f3;
          border-radius: 10px;
          background: linear-gradient(180deg, #f8fbff 0%, #f2f7ff 100%);
          display: inline-flex;
          align-items: center;
          gap: 10px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    }

    .member-db-cta .member-db-btn {
          background: #1d5fa7;
          color: #fff;
          border: 1px solid #174d87;
          border-radius: 8px;
          padding: 7px 12px;
          font-weight: 600;
          text-decoration: none;
    }

    .member-db-cta .member-db-btn:hover {
          background: #174d87;
          color: #fff;
          text-decoration: none;
    }

    .member-db-cta .member-db-text {
          color: #35557a;
          font-size: 13px;
    }
</style>


<div>
{% include search-form-global.html %}
</div> 


<div class="label label-default">Research Group Members </div>
<div class="bigspacer"></div>

I'm extremely fortunate to work with several amazing students to whom I serve as primary or co-advisor. <br>

<div>
  <strong>Interested in joining the lab?</strong>
  For advising expectations and how to reach out (undergraduates, graduate students, postdocs, visiting scholars, and others), see
  <a href="{{ '/sayhi/' | relative_url }}">Say hi / advising</a>.
</div>

<div class="smallspacer"></div>
<div class="member-db-cta">
  <a href="/team/database" class="member-db-btn">Open Member Database</a>
  <span class="member-db-text">Search, filter, and sort all members</span>
</div>

<div class="bigspacer"></div>
<div class="label label-primary">Current </div>
<div class="bigspacer"></div>


<div class="row">
    <!-- iterate over members; new members last. Undergrads are listed under Undergraduate Students. -->
    {% for member in site.categories.team reversed %}
    {% if member.alum == false and member.collaborator == false and member.support == false %}
    {% unless member.role == "Undergrad" %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {% endunless %}
    {%endif%}
    {% endfor %}   
</div>

<div class="bigspacer"></div>

<div class="label label-info"> Undergraduate Students </div> 
(those writing paper with lab is marked with $^*$):

<!-- - $^*$[**Jianhan Zhang**](/team/jianhan-zhang), co-mentored by [Jitao Wang](/team/jitao-wang). Undergrad, Pure Math, Data Science, U of Michigan. **Undergraduate Honor Thesis**: "Counterfactual Fairness in Reinforcement Learning via Marginal Distributional Matching". Thesis work awarded `Highest Honors` in Statistics. -->


<!-- <div class="bigspacer"></div>

<hr/>
<div class="bigspacer"></div>
<div class="smalltitle text-left">Support Staff </div>
<div class="bigspacer"></div> -->

<div class="row">
    {% for member in site.categories.team reversed %}
    {% if member.alum == false and member.collaborator == false and member.support == false and member.role == "Undergrad" %}
    {% if member.url %}
    <div class="col-sm-3" style="text-align: center">
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {% endif %}
    {% endif %}
    {% endfor %}
</div>

<div class="bigspacer"></div>


<hr/>
<div class="bigspacer"></div>
<div class="label label-success">Past Members </div>
<div class="bigspacer"></div>

<p >Alumni have gone on to faculty roles, industry, and strong graduate programs. Placements and timelines are easiest to explore in the
<a href="{{ '/team/database' | relative_url }}">Member Database</a> (filter by alumni year, role, and more).</p>

<p>Please send an email to zhenkewu@gmail[punto]com for updates to your entry.</p>

<div class="bigspacer"></div>
<div class="label label-info">Former PhD Students: </div>
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
<div class="label label-info">Former MS Students: </div>
<div class="bigspacer"></div>
<div class="smalltitle text-left">Terminal MS degree</div>
<div class="smallspacer"></div>
{% assign former_ms_terminal = site.categories.team | where: "alum", true | where: "role", "MS" | sort: "endyear" | reverse %}
<ul>
{% for m in former_ms_terminal %}
  <li>
    {% assign ms_grad_year = m.ms_year | default: m.endyear %}
    {% assign first_pos_out = m.first_position | default: "" | strip %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if ms_grad_year %} | (MS {{ ms_grad_year }}){% endif %}
    | MS
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if m.field %} | {{ m.field }}{% endif %}
    {% if m.thesis_title %} | "{{ m.thesis_title }}"{% endif %}
    {% if first_pos_out != "" %} | First position after graduation: {{ first_pos_out }}{% endif %}
  </li>
{% endfor %}
</ul>

<div class="smallspacer"></div>
<div class="smalltitle text-left">continued to PhD in lab</div>
<div class="smallspacer"></div>
{% assign former_ms_continued = site.categories.team | where: "ms_placement", "PhD Student at UMich Biostatistics" | sort: "ms_year" | reverse %}
<ul>
{% for m in former_ms_continued %}
  <li>
    {% assign ms_grad_year = m.ms_year | default: m.endyear %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if ms_grad_year %} | (MS {{ ms_grad_year }}){% endif %}
    | MS
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if m.field %} | {{ m.field }}{% endif %}
    | MS Placement: {{ m.ms_placement }}
  </li>
{% endfor %}
</ul>


<div class="bigspacer"></div>
<div class="label label-info">Former Undergraduate Students </div>  (those who wrote paper in the lab is marked with $^*$):
{% assign former_undergrads = site.categories.team | where: "alum", true | where: "role", "Undergrad" | sort: "endyear" | reverse %}
<ul>
{% for m in former_undergrads %}
  <li>
    {% assign first_pos_out = m.first_position | default: "" | strip %}
    {% if m.paper == true %}* {% endif %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if m.endyear %} | ({{ m.endyear }}){% endif %}
    {% if m.role %} | {{ m.role }}{% endif %}
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if m.field %} | {{ m.field }}{% endif %}
    {% if m.thesis_title %} | "{{ m.thesis_title }}"{% endif %}
    {% if first_pos_out != "" %} | First position after graduation: {{ first_pos_out }}{% endif %}
  </li>
{% endfor %}
</ul>

<div class="bigspacer"></div>

<div class="label label-info">Former Research Staff </div> 

- [**Zihan Wang**](/team/zihan-wang). MS, Biostatistics, U of Michigan (2025). Next position: PhD Student in Health Data Science (Biostatistics concentration). Geroge Washington University. 


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

