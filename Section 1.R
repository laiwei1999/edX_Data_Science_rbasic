#ctrl + shift + N: create a new R script 
library(tidyverse)
library(dslabs)
data(murders)
data(movielens)

murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()

#Solving the equation x^2 + x - 1 = 0
a <- 2
b <- -1
c <- -4
#Sovling the quadratic equation 
(-b + sqrt(b^2 - 4 * a * c))/(2 * a)
(-b - sqrt(b^2 - 4 * a * c))/(2 * a)

#Have to start with a letter & they cannot contain spaces
log(1024,4)

#Data frames can be thought of as tables with rows representing observations and columns representing different variables.
str(murders)
#$: the accessor 
murders$population
names(murders)

pop <- murders$population
length(pop)
#A vector is an object consisting of several entries and can be a numeric vector, a character vector, or a logical vector.
class(pop)

class(murders$state)

# == is a relational operator 
z <- 3 == 2
z
class(z)

#Factor class is used for store Categorical Data
class(murders$region)
levels(murders$region)

#Assessment
class(movielens$title)
class(movielens$genres)
nlevels(movielens$genres)