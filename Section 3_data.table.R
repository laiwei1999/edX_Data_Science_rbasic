library(dslabs)
data(murders)

murder_rate <- murders$total/murders$population * 100000

#Using Logical Operators to index vectors
index <- murder_rate <= 0.71
index
#determining which states have murder rates less than or equal to 0.71
murders$state[index]

#Function sum()on a logical vector returns the number of entries that are true
sum(index)

#Creating the two logical vectors representing our conditions
west <- murders$region == "West"
safe <- murder_rate <= 1
#The logical operator “&” makes two logicals true only when they are both true.
index <- safe & west
murders$state[index]

#The function which() gives us the entries of a logical vector that are true
ind <- which(murders$state == "Massachusetts")
ind
murder_rate[ind]

#The function match() looks for entries in a vector and returns the index needed to access them
ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind
murders$state[ind]
murder_rate[ind]

#The function %in% if we want to know whether or not each element of a first vector is in a second vector
c("Boston","Dakota","Washington")%in%murders$state

library(dplyr)
#To change a data table by adding a new column, or changing an existing one, we use the mutate() function
murders <- mutate(murders, rate = total/population * 100000)
#To filter the data by subsetting rows, we use the function filter()
filter(murders, rate <= 0.71)
#To subset the data by selecting specific columns, we use the select() function
new_table <- select(murders, state, region, rate)
filter(new_table, rate <= 0.71)
#perform a series of operations by sending the results of one function to another function using the pipe operator, %>%
murders %>% 
  select(state, region, rate) %>% 
  filter(rate <= 0.71)

grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"),
                     exam_1 = c(95,80,90,85),
                     exam_2 = c(90,85,85,90))
grades
#the data.frame() function turned characters into factors by default
class(grades$names)
#stringsAsFactors = FALSE in order to keep strings as characters

#create a simple scatterplot using the function plot()
population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total
plot(population_in_millions, total_gun_murders)

#Histograms are graphical summaries that give you a general overview of the types of values you have
hist(murders$rate)

#Boxplots provide a more compact summary of a distribution than a histogram and are more useful for comparing distributions
boxplot(rate ~ region, data = murders)

murders <- mutate(murders, rate = total/population *10^5)

library(tidyverse)
#minimum, median, and maximum murder rate for the states in the West region
s <- murders %>% filter(region == "West") %>% 
  summarize(minimun = min(rate), median = median(rate), maximum = max(rate))
#Accessing the components with the accessor $
s$median

#Average rate adjusted by population size
us_murder_rate <- murders %>% 
  summarize(rate = sum(total)/sum(population) * 10^5)

#The quantile() function can be used to return the min, median, and max in a single line of code
my_quantile <- function(x){
  r <- quantile(x, c(0, 0.5, 1))
  data.frame(minimum = r[1], median = r[2], maximum = r[3])
}
murders %>% filter(region == "West") %>% 
  summarize(my_quantile(rate))

#summarize() always returns a data frame
class(us_murder_rate)
#The pull() function can be used to access values stored in data when using pipes
us_murder_rate %>% pull(rate)

#The dot (.) can be thought of as a placeholder for the data being passed through the pipe.
us_murder_rate <- murders %>% 
  summarize(rate = sum(total)/sum(population) * 10^5) %>% 
  .$rate
class(us_murder_rate)

#Splitting data into groups and then computing summaries for each group is a common operation in data exploration
murders %>% group_by(region) %>% summarize(median = median(rate))

#arrange() to order an entire table
murders %>% arrange(population) %>% head()
#order the states by murder rate in descending order
murders %>% arrange(desc(rate)) %>% head()
#The function top_n() returns the top n rows of a table
murders %>% arrange(desc(rate)) %>%  top_n(10, rate)

#Selecting in data.table uses notation similar to that used with matrices
library(data.table)
#Convert the data frame into a data.table object
murders <- setDT(murders)
#Select in data.table 
murders[, c("state", "region")] |> head()
#Adding or changing a column in data.table
murders[, rate := total/population * 100000]
murders[, ":="(rate = total/population * 100000, rank = rank(population))]

#y is referring to x and := changes by reference
x <- data.table(a = 1)
y <- x
#it does not create a new object
x[,a := 2]
y
y[, a := 1]
x
#copy() function can make a cope of table
y <- copy(x)

#Subsetting in data.table
murders[rate <= 0.7]

library(dslabs)
data(heights)
heights <- setDT(heights)

#Can call functions inside .() and they will be applied to rows
s <- heights[, .(average = mean(height), standard_deviation = sd(height))]
t <- heights[sex == "Female", .(average = mean(height), standard_deviation = sd(height))]

#Define a function
median_min_max <- function(x) {
  qs <- quantile(x, c(0.5, 0, 1))
  data.frame(median = qs[1], minimun = qs[2], maximum = qs[3])
}
heights[, .(median_min_max(height))]
#Grouping then summarizing in data.table
heights[, .(average = mean(height), standard_deviation = sd(height)), by = sex]

#Order by population
murders[order(population)] |> head()
#Order by descending order
murders[order(population, decreasing = TRUE)]
#Order by region and then murder rate
murders[order(region, rate)]

#A tbl(tibble) is a special kind of data frame
gapminder
#Tibbles are the default data frame in the tidyverse
as_tibble(gapminder)
class(murders[,1])
#Tibbles will warn you if you try to access a column that doesn't exist
murders$State
as_tibble(murders)$State
#Create a tibble
tibble(id = c(1,2,3), func = c(mean, median, sd))
