---
layout: default
title: "papers"
categories: papers
---
{% include JB/setup %}



<div class="row">
	<div class="col-md-12">
		<div class="centered-pills">
			<ul class="nav nav-pills note-button">
				<li role="presentation">
					<a class="off" href="/papers/">
						<i class="fa fa-binoculars fa-fw"></i> Squares
					</a>
				</li>
				<li role="presentation" >
					<a class="off" href="/papers/archive/">
						<i class="fa fa-calendar fa-fw"></i> Year
					</a>
				</li>
				<li role="presentation"  class="active">
					<a class="off" href="/papers/archive/index_by_topic">
						<i class="fa fa-podcast fa-fw"></i> Topic
					</a>
				</li>
			</ul>
		</div>
		<div class="bigspacer"></div>
	</div>
</div>



See <a href="https://scholar.google.com/citations?user=3ffCNrEAAAAJ&hl=en">Google Scholar</a> for a more complete list. <br>

<div>
{% include search-form.html %}
</div>

<div class="container">
<div class="bigspacer"></div>

{% assign sorted_tags = (site.tags | sort:0) %}
<!-- {% for tag in sorted_tags %}
<li>{{ tag | first }}</li>
{% endfor %} -->

{% assign filtered_tags = "" | split: "" %}
{% for tag in sorted_tags %} 
   <!-- check if there are papers with this tag -->
  {% assign has_paper = 0 %}
  {% for post in tag[1] %}
  {% if post.layout contains "paper" %}
	{% assign has_paper = has_paper | plus: 1 %}
  {% endif %}
  {% endfor %}

  <!-- add to list only if there are papers with the current tag -->
  {%if has_paper != 0 %}
  {% assign filtered_tags = filtered_tags | push: tag %}
  {% endif %} 
{% endfor %}

<ul class="tag_box inline">
  {% assign tags_list = filtered_tags %} 
  {% include JB/tags_list_paper %}
</ul>

{% for tag in sorted_tags %} 
   <!-- check if there are papers with this tag -->
  {% assign has_paper = 0 %}
  {% assign filtered_posts = "" | split: "" %}
  {% for post in tag[1] %}
  {% if post.layout contains "paper" %}
	{% assign has_paper = has_paper | plus: 1 %}
	{% assign filtered_posts = filtered_posts | push: post %}
  {% endif %}
  {% endfor %}

  <!-- add to list only if there are papers with the current tag -->
  {%if has_paper != 0 %}
  <h2 id="{{ tag[0] }}-ref">{{ tag[0] }}</h2>
  <ul>
    {% assign pages_list = filtered_posts %}  
    {% include JB/pages_list_paper %}
  </ul>
  {% endif %} 
{% endfor %}

</div>