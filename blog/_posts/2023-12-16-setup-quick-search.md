---
layout: post
title: "Creat quick search shortcut for use in command line"
description: "Personal"
authors: Zhenke Wu
author_handle: Zhenke Wu
category: blog
published: true
tags: [tips]
tagline: "macOSX quick search"
lcb: "{"
---

## 1. Quick search on command line?

>Want to quickly search in your directories? For example, you want to search for `.R` files that contain a string `"latent"`, and print out the results. You may hope to do something like:
>
>- `lookfor "latent" ".R"`
>
>Or you want to just look for the files without specifying the file type by something like:
>
>- `lookfor "latent"`
>
>Or you want to print page-by-page using `less`
>
>- `lookfor latent | less` (the quotation marks around `latent` are not needed)
>
>If achieved, this could speed up your debugging process when you need to find certain variable names or keywords that you identified as useful. 


### 1.1. Back-story

Here is one excellent solution I have been using (see more explanation at the end):

<div class='jekyll-twitter-plugin' align="center">
<blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">One line of code that have saved lots of time cumulatively: search for pattern $1 in files that end with $2. Thanks <a href="https://twitter.com/rafalab?ref_src=twsrc%5Etfw">@rafalab</a> for sharing this sometime ago!<br />19:31:10  ~/bin<br />$ more lookfor<br />#!/bin/bash<br />rg --no-heading -i &quot;$1&quot; --iglob \*$2</p>&mdash; Zhenke Wu (吴振科) (@ZhenkeWu) <a href="https://twitter.com/ZhenkeWu/status/1116485061745025024?ref_src=twsrc%5Etfw">April 11, 2019</a></blockquote>
<script async="" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

This was motivated by [Rafa Irizarry](https://rafalab.dfci.harvard.edu/) who was my then-Hopkins profesoor and taught me 1st year linear regression class running R and compling files in Emacs (I had not been exposed to Unix before PhD):

<div class='jekyll-twitter-plugin' align="center">
<blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">Why did I wait 20+ years to write this? I&#39;ve looked it up like 500 times!<br /><br />$ less ~/bin/lookfor<br />#!/bin/bash<br />grep -r --include=\*.$2 $1 ./ | less<br /><br />Don&#39;t leave for tomorrow the Unix shell script you can write today!</p>&mdash; Rafael Irizarry (@rafalab) <a href="https://twitter.com/rafalab/status/1049686211391045632?ref_src=twsrc%5Etfw">October 9, 2018</a></blockquote>
<script async="" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

</div>

As you can see by comparing the codes from the two tweets, I have used a different function `rg` which is faster, but both versions should work. 

  - **Too many outputs?** You may also append `"| less"` when you use the command, e.g., `lookfor latent | less`, to print only page-by-page when `lookfor` identifies exceedingly many files or long files that contain the target string `latent`. However, by using `less`, the results lose syntax highlighting. This is why I have no `| less` by default to make it easier for my eyes when staring at the returned results.


## 2. Set things up

- **Create the file** at `/full/path/to/your/file`, e.g., I created a file `~/bin/lookfor` with the following bash code:
  - ```
    #!/bin/bash
    rg --no-heading -i "$1" --iglob \*$2	
    ```
- **Make the file excutable**: 
  - ```
    chmod +x /full/path/to/your/file
    ```

- **Create a symbolic link to the file** by  following [this](https://askubuntu.com/questions/427818/how-to-run-scripts-without-typing-the-full-path). The symlink may be in a different location `/usr/local/bin/name_of_new_command`. I created a symbolic link with the same name (does not have to be), `lookfor`. 
  - ```
  sudo ln -s /full/path/to/your/file /usr/local/bin/name_of_new_command
  ```

### 2.1. Example

For example, because I created the `lookfor` file at `~/bin/lookfor`, I needed to replace `/full/path/to/your/file` with `~/bin/lookfor`; I wanted to type `lookfor` to execute the file, so I replaced `name_of_new_command` with `lookfor`. 

Note that we just created a symbolic in a different directory `/usr/local/bin` to the now executable file `~/bin/lookfor`

Now you may type `lookfor` with appropriate arguments to do the quick search, save your time, and be less cranky!

## 3. More explanation (by GPT-4)

```
#!/bin/bash
rg --no-heading -i "$1" --iglob \*$2	
```

This Bash script snippet utilizes `rg`, which is the command for Ripgrep, a fast search tool. The script performs a case-insensitive search for the pattern specified by `$1` in files that match the glob pattern `*$2`.

Here's a breakdown of the options used:

- `--no-heading`: This option tells Ripgrep to omit the file names and just show the matching lines from each file.

- `-i`: This flag makes the search case-insensitive, meaning it will match both upper and lower case letters.

- `$1`: This is a placeholder for the first argument passed to the script. It represents the search pattern.

- `--iglob \*$2`: The `--iglob` option allows for case-insensitive file name matching. `\*` matches any number of any characters, and `$2` is a placeholder for the second argument to the script, which specifies the file extension or pattern to search within.

Overall, when you run this script with two arguments, it searches for the first argument (a text pattern) in all files that match the pattern given by the second argument (typically a file extension), without regard to case, and outputs the matching lines without file names.