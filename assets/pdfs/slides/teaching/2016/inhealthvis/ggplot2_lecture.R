## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)

## ----basic1, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
# create a simple data set with 4 variables in the columns:
dat0 <- as.data.frame(list(A = c(2,1,4,9),
                          B = c(3,2,5,10),
                          C = c(4,1,15,80),
                          D = c("a","a","b","b")))
dat0

## ----basic2, echo=FALSE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
# create a simple data set with 4 variables in the columns:
dat <- as.data.frame(list(x = c(2,1,4,9),
                          y = c(4,1,15,80),
                      Shape = c("a","a","b","b")))
print(dat)

## ----basic3, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
# ggplot2 creates (internally) a simple data set with 
# 3 variables in the columns:
dat_internal <- as.data.frame(list(x = c(25,0,75,200),
                          y = c(11,20,53,300),
                      Shape = c("circle","circle","square","square")))
print(dat_internal)


## ----basic4, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
library(ggplot2)
example <- ggplot(data    = dat0,
                  mapping = aes(x=A,y=C,shape=D))+
           # Set aesthetics to fixed value
           geom_point(size = 7)
example

# run `?geom_point` geom_point understands the 
# following aesthetics (required aesthetics are in bold).


## ----basi5, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
library(ggplot2)
example <- ggplot(data    = dat0,
                  mapping = aes(x=A,y=C,shape=D))+
           # Set aesthetics to fixed value
           geom_point(size = 7)+facet_grid(~D)
example


## ----diamond00, echo=TRUE, message=FALSE, warning=FALSE,fig.width=10, fig.height=6,out.width='\\linewidth'----
# just getting some data
library(ggplot2)
head(diamonds)

## ----diamond01, echo=TRUE, message=FALSE, warning=FALSE,fig.width=10, fig.height=6,out.width='\\linewidth'----
plot(diamonds$carat, diamonds$price, col = diamonds$color,
     pch = as.numeric(diamonds$cut))

## ----diamond02, echo=TRUE, message=FALSE, warning=FALSE,fig.width=10, fig.height=6,out.width='\\linewidth'----
ggplot(diamonds, aes(carat, price, col = color, 
                     shape = cut)) +
    geom_point()

## ----diamond1, echo=TRUE, message=FALSE, warning=FALSE,fig.width=10, fig.height=6,out.width='\\linewidth'----
d <- ggplot(diamonds, aes(cut))
d + geom_bar()

## ----diamond2, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=5,out.width='\\linewidth'----
d + stat_summary_bin(aes(y = price), fun.y = "mean", 
                     geom = "bar")

## ----minard1, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
library(HistData)
head(Minard.troops)
head(Minard.cities)

## ----minard2, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
data(Minard.troops); data(Minard.cities)
library(ggplot2)
plot_troops <- ggplot(Minard.troops, aes(long, lat)) +
  geom_path(aes(size = survivors, 
                colour = direction, group = group))

plot_troops


## ----minard3, echo=TRUE, message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----
plot_both <- plot_troops + 
  geom_text(aes(label = city), size = 4, 
            data = Minard.cities)
plot_both


## ----minard4, echo=TRUE, size="small", message=FALSE, warning=FALSE,fig.width=12, fig.height=3,out.width='\\linewidth'----

plot_polished <- plot_both + 
  scale_size(range = c(1, 12), 
             breaks = c(1, 2, 3) * 10^5, 
             labels = scales::comma(c(1, 2, 3) * 10^5)) + 
  scale_colour_manual(values = c("grey50","red")) +
  xlab(NULL) + 
  ylab(NULL)

plot_polished


