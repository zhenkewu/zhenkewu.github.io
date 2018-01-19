---
layout: post
title: "Testing MathJax"
description: "This blog tests math compatibility on this site"
author: Zhenke Wu
author_handle: Zhenke Wu
category: blog
published: true
tags: []
tagline: "This is The Tagline"
lcb: "{"
---

Math Equations
======
{% include JB/setup %}

We do plenty of math, so I'd like to test out [MathJax](https://www.mathjax.org/) support.

Here is an example of MathJax inline rendering --- $ 1/x^{2} $. And here is a block rendering:

$$ r_{XY} = \frac{\mathrm{cov}(X,Y)}{\sqrt{\mathrm{var}(X)\mathrm{var}(Y)}} $$

Now, if we'd like to get serious, we'd do something involving multiline aligned equations, like 

$$
\begin{align}
\mathcal{N}(t, \mu, \sigma) &= \mathrm{normal} \newline
 &= \frac{1}{\sqrt{2 \pi} \sigma} e^{-\frac{(t-\mu)^2}{2 \sigma^2}}
\end{align}
$$

or even an inline formula like $ \sum_{t=0}^{\infty} \frac{x^t}{t!} = e^x$.

Or we could try defining a command, like this. $ \newcommand{\water}{\mathrm{H}_{2}\mathrm{O}} $

> Buffer slides off the sides of our tubes like $$\water$$ off a duck's back.

Or a more fancy set of equations:

$$
\begin{align}
\mbox{Union: } & A\cup B = \{x\mid x\in A \mbox{ or } x\in B\} \\
\mbox{Concatenation: } & A\circ B  = \{xy\mid x\in A \mbox{ and } y\in B\} \\
\mbox{Star: } & A^\star  = \{x_1x_2\ldots x_k \mid  k\geq 0 \mbox{ and each } x_i\in A\} \\
\end{align}
$$

Or to write the case likelihood function of PLCM model ([Wu et al. 2015](/assets/pdfs/papers/wu-2015-plcm.pdf)):

$$
Pr(\boldsymbol{M}_i \mid I_i=1) = \sum_{\ell=1}^L\pi_\ell\theta_\ell^{M_{i\ell}}(1-\theta_\ell)^{1-M_{i\ell}}\prod_{j\neq \ell}\psi_j^{M_{ij}}(1-\psi_j)^{1-M_{ij}}
$$


One can also use some doses of number theory...
======
~~~ html
{{page.lcb}}% include JB/video id="0Oazb7IWzbA" provider="youtube" %}
~~~


{% include JB/video id="0Oazb7IWzbA" provider="youtube" %}

