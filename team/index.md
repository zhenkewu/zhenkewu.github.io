---
layout: default
title: "team"
navtab: "team"
description: "People in the lab"
group: navigation
navorder: 4
---
{% include JB/setup %}

{% assign team_active = site.categories.team | where_exp: "m", "m.endyear == nil" %}
{% assign current_undergrads = site.categories.team | where_exp: "m", "m.endyear == nil and m.role == 'Undergrad'" %}
{% assign current_members = site.categories.team | where_exp: "m", "m.endyear == nil and m.role != 'Undergrad'" %}
{% assign former_phd_icons = site.categories.team | where_exp: "m", "m.endyear and m.role contains 'PhD'" %}
{% assign former_ms_terminal = site.categories.team | where_exp: "m", "m.endyear and m.role == 'MS'" | sort: "endyear" | reverse %}
{% assign former_ms_continued = site.categories.team | where_exp: "m", "m.ms_year and m.role contains 'PhD'" | sort: "ms_year" | reverse %}
{% assign former_ms_count = former_ms_terminal.size | plus: former_ms_continued.size %}
{% comment %}
Member fields: role, field, position, endyear (omit if current). Optional prior lab stages: ms_year; ug_year, ug_field (only if different from field), paper. After leaving: placement, and current_placement only if it later changed. Links only if present. handle only if it differs from title.
{% endcomment %}
{% assign former_undergrads_terminal = site.categories.team | where_exp: "m", "m.ug_year and m.role == 'Undergrad'" | sort: "ug_year" | reverse %}
{% assign former_undergrads_continued = site.categories.team | where_exp: "m", "m.ug_year and m.role != 'Undergrad'" | sort: "ug_year" | reverse %}
{% assign former_undergrads_count = former_undergrads_terminal.size | plus: former_undergrads_continued.size %}
{% assign former_staff = site.categories.team | where_exp: "m", "m.endyear and m.role == 'Research Staff'" %}
{% assign alumni = site.categories.team | where_exp: "m", "m.endyear" %}

<nav class="project-hub-nav project-hub-nav-featured" data-hub-accent="team" aria-label="Jump to team sections">
	<div class="project-hub-nav-label">Jump to</div>
	<a class="project-hub-chip" href="#current"><i class="fa-solid fa-users"></i> Current <span class="project-hub-chip-count">{{ team_active.size }}</span></a>
	<a class="project-hub-chip" href="#past"><i class="fa-solid fa-clock-rotate-left"></i> Past <span class="project-hub-chip-count">{{ alumni.size }}</span></a>
	<a class="project-hub-chip" href="#former-phd"><i class="fa-solid fa-user-graduate"></i> Former PhD <span class="project-hub-chip-count">{{ former_phd_icons.size }}</span></a>
	<a class="project-hub-chip" href="#former-ms"><i class="fa-solid fa-book"></i> Former MS <span class="project-hub-chip-count">{{ former_ms_count }}</span></a>
	<a class="project-hub-chip" href="#former-undergrad"><i class="fa-solid fa-user"></i> Former undergrad <span class="project-hub-chip-count">{{ former_undergrads_count }}</span></a>
	<a class="project-hub-chip" href="#former-staff"><i class="fa-solid fa-briefcase"></i> Former staff <span class="project-hub-chip-count">{{ former_staff.size }}</span></a>
</nav>

<style>
    img.photo{
          object-fit: cover;
          border-radius: 50%;
          object-position: 10% 10%; 
          width:150px;
          height:150px;
    }

    .project-section-marker-team {
          border-left-color: #1d5fa7;
          background: linear-gradient(180deg, #f8fbff 0%, #f2f7ff 100%);
    }

    .project-section-marker-team .project-section-marker-left i {
          color: #1d5fa7;
    }

    .project-section-marker-team .project-section-marker-count {
          background: #1d5fa7;
    }

    .project-section-marker-team .project-section-marker-jump {
          color: #174d87;
    }

    .project-hub-section:target .project-section-marker-team,
    .project-hub-section.is-current .project-section-marker-team {
          box-shadow: 0 0 0 3px rgba(29,95,167,0.22);
    }

    .member-db-cta {
          margin: 10px auto 20px auto;
          padding: 12px 14px;
          border: 1px solid #dfe7f3;
          border-radius: 10px;
          background: linear-gradient(180deg, #f8fbff 0%, #f2f7ff 100%);
          display: flex;
          width: fit-content;
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

    .label-team-pill {
          background: #1d5fa7;
          border-radius: 999px;
          padding: 4px 10px;
          font-size: 0.85em;
          font-weight: 600;
          letter-spacing: 0.01em;
    }
</style>


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

<section id="current" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-users"></i>
		<span class="project-section-marker-title">Current</span>
		<span class="project-section-marker-count">{{ team_active.size }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div>


<div class="row">
    <!-- iterate over members; new members last. Undergrads are listed under Undergraduate Students. -->
    {% for member in site.categories.team reversed %}
    {% unless member.endyear %}
    {% unless member.role == "Undergrad" %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {% endunless %}
    {% endunless %}
    {% endfor %}   
</div>

{% if current_undergrads.size > 0 %}
<section id="undergrad">
<div class="label label-team-pill">Undergraduate students</div>
<div class="smallnote">$^*$: writing a paper with the lab.</div>
<div class="smallspacer"></div>

<div class="row">
    {% for member in current_undergrads reversed %}
    {% if member.url %}
    <div class="col-sm-3" style="text-align: center">
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {% endif %}
    {% endfor %}
</div>
</section>
{% endif %}
</section>

<section id="past" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-clock-rotate-left"></i>
		<span class="project-section-marker-title">Past Members</span>
		<span class="project-section-marker-count">{{ alumni.size }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div>

<p >Alumni have gone on to faculty roles, industry, and strong graduate programs. Placements and timelines are easiest to explore in the
<a href="{{ '/team/database' | relative_url }}">Member Database</a> (filter by alumni year, role, and more).</p>

<p>Please send an email to zhenkewu@gmail[punto]com for updates to your entry.</p>

<section id="former-phd" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-user-graduate"></i>
		<span class="project-section-marker-title">Former PhD Students</span>
		<span class="project-section-marker-count">{{ former_phd_icons.size }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div>

<div class="row">
    {% for member in site.categories.team %}
    {% if member.endyear %}
    {% if member.role contains "PhD" %}
    <div class="col-sm-3" style="text-align: center">
    {%if member.url%}
    <a href="{{ member.url }}"> <img class="photo" src="{{member.image}}"> </a> <br>
    <div class="head media-heading member-name"><a href="{{ member.url }}" class="off">{{ member.title }}</a></div>  
    <p class="note">{{ member.position }}</p>
    </div>
    {%endif%}
    {%endif%}
    {%endif%}
    {% endfor %}    
</div>
</section>

<section id="former-ms" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-book"></i>
		<span class="project-section-marker-title">Former MS Students</span>
		<span class="project-section-marker-count">{{ former_ms_count }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div>
<div class="smalltitle text-left">Terminal MS degree</div>
<div class="smallspacer"></div>
<ul>
{% for m in former_ms_terminal %}
  <li>
    {% assign ms_grad_year = m.ms_year | default: m.endyear %}
    {% assign first_pos_out = m.placement | default: "" | strip %}
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
<ul>
{% for m in former_ms_continued %}
  <li>
    {% assign ms_grad_year = m.ms_year | default: m.endyear %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if ms_grad_year %} | (MS {{ ms_grad_year }}){% endif %}
    | MS
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if m.field %} | {{ m.field }}{% endif %}
    {% if m.thesis_title %} | "{{ m.thesis_title }}"{% endif %}
    {% if m.position %} | Placement: {{ m.position }}{% endif %}
  </li>
{% endfor %}
</ul>
</section>

<section id="former-undergrad" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-user"></i>
		<span class="project-section-marker-title">Former Undergraduate Students</span>
		<span class="project-section-marker-count">{{ former_undergrads_count }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div>
<div class="smallnote">(those who wrote paper(s) in the lab is marked with $^*$)</div>
<div class="smallspacer"></div>
<div class="smalltitle text-left">After undergraduate research</div>
<div class="smallspacer"></div>
<ul>
{% for m in former_undergrads_terminal %}
  <li>
    {% assign ug_grad_year = m.ug_year | default: m.endyear %}
    {% assign ug_place_out = m.placement | default: "" | strip %}
    {% assign ug_field_out = m.ug_field | default: m.field | default: "" | strip %}
    {% if m.paper == true %}* {% endif %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if ug_grad_year %} | (UG {{ ug_grad_year }}){% endif %}
    | Undergrad
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if ug_field_out != "" %} | {{ ug_field_out }}{% endif %}
    {% if m.thesis_title %} | "{{ m.thesis_title }}"{% endif %}
    {% if ug_place_out != "" %} | Placement: {{ ug_place_out }}{% endif %}
  </li>
{% endfor %}
</ul>

<div class="smallspacer"></div>
<div class="smalltitle text-left">continued in lab</div>
<div class="smallspacer"></div>
<ul>
{% for m in former_undergrads_continued %}
  <li>
    {% assign ug_grad_year = m.ug_year | default: m.endyear %}
    {% assign ug_place_out = m.position | default: "" | strip %}
    {% assign ug_field_out = m.ug_field | default: m.field | default: "" | strip %}
    {% if m.paper == true %}* {% endif %}
    {% if m.url %}<a href="{{ m.url }}"><strong>{{ m.title }}</strong></a>{% else %}<strong>{{ m.title }}</strong>{% endif %}
    {% if ug_grad_year %} | (UG {{ ug_grad_year }}){% endif %}
    | Undergrad
    {% if m.institution %} | {{ m.institution }}{% endif %}
    {% if ug_field_out != "" %} | {{ ug_field_out }}{% endif %}
    {% if m.thesis_title %} | "{{ m.thesis_title }}"{% endif %}
    {% if ug_place_out != "" %} | Placement: {{ ug_place_out }}{% endif %}
  </li>
{% endfor %}
</ul>
</section>

<section id="former-staff" class="project-hub-section">
<div class="project-section-marker project-section-marker-team">
	<div class="project-section-marker-left">
		<i class="fa-solid fa-briefcase"></i>
		<span class="project-section-marker-title">Former Research Staff</span>
		<span class="project-section-marker-count">{{ former_staff.size }}</span>
	</div>
	<a class="project-section-marker-jump" href="#">Jump to top</a>
</div> 

<ul>
{% for m in former_staff %}
  <li>
    {% assign first_pos_out = m.placement | default: "" | strip %}
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
</section>
</section> 


<!--
<div class="container">
<div class="smalltitle text-left">Research Group Members </div>
<div class="bigspacer"></div>
{% for member in site.categories.team %}
	{% unless member.endyear %}
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
	{% endunless %}
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

