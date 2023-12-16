---
layout: post
title: "Creat `lookfor` shortcut for use in command line"
description: "Personal"
authors: Zhenke Wu
author_handle: Zhenke Wu
category: blog
published: true
tags: []
tagline: "macOSX"
lcb: "{"
---

## Quick search on command line?

Want to quickly search in your directories? For example, you want to search for `.R` files that contain a string `"baker"`, and print out the results. You may hope to do something like:

- `lookfor "baker" ".R"`

Or you want to just look for the files without specifying the file type by something like:

- `lookfor "baker"`

If this is achieved, this could speed up your debugging process when you need to find certain variable names or keywords that you identified as useful. 


### Back-story

Here is one excellent solution I have been using:

<div class='jekyll-twitter-plugin' align="center">
<blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">One line of code that have saved lots of time cumulatively: search for pattern $1 in files that end with $2. Thanks <a href="https://twitter.com/rafalab?ref_src=twsrc%5Etfw">@rafalab</a> for sharing this sometime ago!<br />19:31:10  ~/bin<br />$ more lookfor<br />#!/bin/bash<br />rg --no-heading -i &quot;$1&quot; --iglob \*$2</p>&mdash; Zhenke Wu (吴振科) (@ZhenkeWu) <a href="https://twitter.com/ZhenkeWu/status/1116485061745025024?ref_src=twsrc%5Etfw">April 11, 2019</a></blockquote>
<script async="" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

This was motivated by [Rafa Irizarry](https://rafalab.dfci.harvard.edu/) who was my then-Hopkins profesoor and taught me 1st year linear regression class running R and compling files in Emacs (I had not been exposed to Unix before PhD):

<div class='jekyll-twitter-plugin' align="center">
<blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">Why did I wait 20+ years to write this? I&#39;ve looked it up like 500 times!<br /><br />$ less ~/bin/lookfor<br />#!/bin/bash<br />grep -r --include=\*.$2 $1 ./ | less<br /><br />Don&#39;t leave for tomorrow the Unix shell script you can write today!</p>&mdash; Rafael Irizarry (@rafalab) <a href="https://twitter.com/rafalab/status/1049686211391045632?ref_src=twsrc%5Etfw">October 9, 2018</a></blockquote>
<script async="" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

</div>

As you can see by comparing the codes from the two tweets, I have used a different tool `rg` which is faster, but either should work. I have since also appended `"| less"` in my final line to print less when `lookfor` identifies exceedingly long files.


## Set up symbolic link and make the file executable

Then follow [this](https://askubuntu.com/questions/427818/how-to-run-scripts-without-typing-the-full-path) link to create a symlink to the created file in  `/usr/local/bin` so that you may achieve the functionality as desired at the start of this article:
  - `sudo ln -s /full/path/to/your/file /usr/local/bin/name_of_new_command`

- Then make the file excutable: 
    - `chmod +x /full/path/to/your/file`

For example, I created the `lookfor` file at `~/bin/lookfor`, I replaced `/full/path/to/your/file` with `~/bin/lookfor`; I want to type `lookfor` to execute the file, so I replaced `name_of_new_command` with `lookfor`. Note that we just created a symbolic in a different directory `/usr/local/bin` to the now executable file `~/bin/lookfor`

Now you may type `lookfor` with appropriate arguments to do the quick search, save your time, and be less cranky!