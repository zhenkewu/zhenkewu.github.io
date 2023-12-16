Zhenke Wu's Research Website: [click to view](http://zhenkewu.com)

# Notes

* [2023/12/11] search function added; a useful reference is [here](https://github.com/christian-fei/Simple-Jekyll-Search) and [here](https://kevquirk.com/how-to-add-search-jekyll). Need to do the following:
    - Put the the javascript file at `./js/search-scripts.js`, which is based on the[`SimpleJekyllSearch`](https://github.com/christian-fei/Simple-Jekyll-Search) which specifies options for doing additional operations on the search results, e.g., sorting.
    - Put the javascript file at `./js/search-result.js` which defines a `simple_search()` function that calls the `SimpleJekyllSearch()` function above, with additional specifications of how the search inputs and outputs would be. The inputs and results will be processed by `search-form-global.html` or `search-form.html` below to be included into a page to render search bar and display search results
    - Put `search-form-global.html` into the `_include` folder and put the following into where you'd like your search bar to be 
        -  `<div> {% include search-form-global.html %} </div>`
      - The above is to search globally (based on `search-global.json` which pulls data from posts in all of the website and produce an actual `.json` file with the same name in the generated static site folder named `_site`); if you want to only search for a subset of posts, e.g., papers, you can modify the json file into what you want, e.g., `search.json` in the main directory is a separate json file to pull data on posts in the papers category only. Please feel free to modify the Liquid commands or include additional info to be pulled. To include search bar only for the subset of posts, ew need to use a include a different html statement to insert the search bar where you'd like to be. For example, I included only the paper search bar on the paper pages:
        - `<div> {% include search-form-global.html %} </div>` 
    - Ther optional settings: currently I use sorting function argument `sortMiddleware` in `search-form.html` and `search-form-global.html`, where the former is for papers only (order by year), the latter is for the entire website (order by category and year). You will need to specify the `sort_curr` function to define your desired sorting mechanism in `Javascript`.


* After cloning the repo to your local folder, you'll need to install jekyll to build and test your modified site. 

* fonts
	- Use [Typekit](https://typekit.com/) to publish fonts you like; register an Adobe account;
	- Modify `$font-stack` in `/assets/themes/lab/css/style.scss` to include your fonts. Extra font names are used as fallbacks.
* posts
    - To add a post, e.g., a new paper, follow the format of the existing `.md` files
    - Comment out `</div>` if there are a multiple of three papers in each subsection; otherwise, there will be errors of indentation. 
* tracking
	- To link your site to Google analytic services (Google Analytics 4), modify the `tracking_id` in `_config.yml` file in the root directory so that it points to your website. 
	- Replace the `tracking_id` with your own id in the following block of codes in `_config.yml`
    
    ```
    analytics :
        provider : google
   		google : 
      	  tracking_id : G-XXXXXXX
    ```
* twitter feed:
    - Follow the instructions [here](https://gist.github.com/abhisheknaik96/26ce79ac7a307eb836dcf02a52f87cf2) and [here](https://keitaito.com/blog/2017/01/20/embedding-tweets-in-github-pages.html). The basic idea is to **locally** use the following
    to embed a tweet.
    
    ```
    <div class='jekyll-twitter-plugin' align="center">
    {% twitter https://twitter.com/anaik96 maxwidth=500 limit=5 %}
    </div>
    ```

     Run `bundle exec jekyll server` to generate a subfolder `_site/` and then find the generated `.html` file that contains the code block for embedding your tweet. Copy the code block such as
    
    ```html
    <blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">For our first ever <a href="https://twitter.com/hashtag/StudentSpotlight?src=hash&amp;ref_src=twsrc%5Etfw">#StudentSpotlight</a>, we&#39;re excited to feature Tim NeCamp who graduated in May and is an official <a href="https://twitter.com/hashtag/alum?src=hash&amp;ref_src=twsrc%5Etfw">#alum</a>! Tim’s interests lie in the areas of experimental design, causal inference, intensive longitudinal data, and....<br>Read More: <a href="https://t.co/NYfWov7wDk">https://t.co/NYfWov7wDk</a> <a href="https://t.co/S6D3sM2vo7">pic.twitter.com/S6D3sM2vo7</a></p>&mdash; Statistics (@UMichStatistics) <a href="https://twitter.com/UMichStatistics/status/1144334755506401283?ref_src=twsrc%5Etfw">June 27, 2019</a></blockquote>
    <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    ```

    and replace the above `div` block.

* MathJax (also see [here](http://www.idryman.org/blog/2012/03/10/writing-math-equations-on-octopress/) )
	- To properly display the math expressions rendered by MathJax, 
		+ Add `kramdown` after on the line of `markdown: ` in `_config.yml`; this prevents markdown language to intervene with LaTex commands; Also put `gem 'kramdown'` in `Gemfile`;
	- Add the following code block to /_includes/themes/lab/default.html, before `</head>`
	
>
    <!-- Math via MathJax -->
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                processEscapes: true
            },
        "HTML-CSS": { availableFonts: ["TeX"] }
        });
    </script>
    <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>


* projects
    - For each repo (in the folder `/_data`), the `url` should not end with `/`. For example, use `url: /projects/baker`, instead of `url: /projects/baker/`
* navigation:
    - For example, the "papers" tab is specified in the folder "papers/". At the top, `title` is for tab name; `group` can be either `navigation` or `subnavigation` depending on whether you want to show this tab or collapse into the "More" tab; `navorder` specifies the order appearing in the navigation bar (1 for the first tab).
* team
    - for photos, set roughly 200px wide and 300px height, with resolution 144. The width requirement is to help display the photo properly on an individual's page.

 ## Other Technicalities
 * `categories`
    - refers to the subfolders in the main directory without an underscore `_`;
    - is used to refer to specific locations in the website (my current guess is that the definition of `categories` ships with the engine of jekyll, so no need to user-define categories)
* style sheets
    - There are two that matter: `/assets/themes/lab/css/style.scss` and `/assets/themes/css/style.scss`; The former works for posts, the latter for pages PRIOR to entering posts. 
    - This might best be fixed, but I don't have time now to check how they are currently used in different pages.
* team page
    - Currently the [landing page of the Team](https://github.com/zhenkewu/zhenkewu.github.io/blob/master/team/index.md) is four-column circular headshots (without stacking if the screen is wider than 576px). The circular image is achieved via `border-radius: 50%` - one may remove this to return to rectangular.
    - Please check [here](https://getbootstrap.com/docs/4.0/layout/grid/) and [here](https://www.w3schools.com/bootstrap/bootstrap_grid_examples.asp) for making changes regarding the landing page of Team based on the Bootstrap grid system.