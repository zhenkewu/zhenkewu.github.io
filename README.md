Zhenke Wu's Research Website: [click to view](http://zhenkewu.com)

# Notes

* fonts
	- Use [Typekit](https://typekit.com/) to publish fonts you like; register an Adobe account;
	- Modify `$font-stack` in `/assets/themes/css/style.scss` to include your fonts. Extra font names are used as fallbacks.
* posts
    - To add a post, e.g., a new paper, follow the format of the existing `.md` files
* tracking
	- To link your site to Google analytic services, modify the `tracking_id` in `_config.yml` file in the root directory so that it points to your website.
* MathJax (also see [here](http://www.idryman.org/blog/2012/03/10/writing-math-equations-on-octopress/) )
	- To properly display the math expressions rendered by MathJax, 
		+ Add `kramdown` after on the line of `markdown: ` in `_config.yml`; this prevents markdown language to intervene with LaTex commands; Also put `gem 'kramdown'` in `Gemfile`;
	- Add the following code block to /_includes/themes/lab/default.html, before `</head>`
	
>
     <!-- Math via MathJax -->
	<script type="text/x-mathjax-config">
	MathJax.Hub.Config({
	  jax: ["input/TeX", "output/HTML-CSS"],
	  tex2jax: {
	    inlineMath: [ ['$', '$'] ],
	    displayMath: [ ['$$', '$$']],
	    processEscapes: true,
	    skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
	  },
	  messageStyle: "none",
	  "HTML-CSS": { preferredFont: "TeX", availableFonts: ["STIX","TeX"] }
	});
	</script>
	<script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML" type="text/javascript"></script>

* projects
    - For each repo (in the folder `/_data`), the `url` should not end with `/`. For example, use `url: /projects/baker`, instead of `url: /projects/baker/`
* navigation:
    - For example, the "papers" tab is specified in the folder "papers/". At the top, `title` is for tab name; `group` can be either `navigation` or `subnavigation` depending on whether you want to show this tab or collapse into the "More" tab; `navorder` specifies the order appearing in the navigation bar (1 for the first tab).