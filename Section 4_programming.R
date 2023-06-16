#Section: 4.1 programming Basics: Conditionals and Functions 
library(dslabs)
data(murders)
data(na_example)
murder_rate <- murders$total/murders$population * 100000

#If-else statement
a <- 2
a <- 0
if(a != 0) {
  print(1/a)
} else {
  print("No reciprocal for 0.")
}

#Which states, if any, have a murder rate less than 0.5
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5) {
  print(murders$state[ind])
} else{
  print("No state has murder rate that low")
}
#Changing the condition to < 0.25 changes the result
if(murder_rate[ind] < 0.25) {
  print(murders$state[ind])
} else {
  print("No state has murder rate that low")
}

#The ifelse() function works similarly to an if-else statement
a <- 0
ifelse(a > 0, 1/a, NA)
#It works on vectors by examining each element of the vector and returning a corresponding answer accordingly
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

#Get the number of NA
sum(is.na(na_example))
#Replacing missing values
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))

#The any() function takes a vector of logicals and returns true if any of the entries are true
z <- c(TRUE, TRUE, FALSE)
any(z)
#The all() function takes a vector of logicals and returns true if all of the entries are true
all(z)

#The R function called function() tells R you are about to define a new function
avg <- function(x) {
  s <- sum(x)
  n <- length(x)
  s/n
}
#compute the average of a vector x
x <- 1:100
avg(x)
identical(mean(x), avg(x))
#Variables defined inside a function are not saved in the workspace

#Functions can have multiple arguments as well as default values
avg <- function(x, arithmetic = TRUE) {
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

#For Loop
compute_s_n <- function(n) {
  x <- 1:n
  sum(x)
}
compute_s_n(3)
compute_s_n(100)
#The general form of a for-loop is: "For i in [some range], do operations".
for (i in 1:5) {
  print(i)
}
#At the end of the loop, the value of i is the last value of the range
i
#define the range that our variable takes
m <- 25
#Create an empty vector
s_n <- vector(length = m)
for(n in 1:m) {
  s_n[n] <- compute_s_n(n)
}
#Plot for our summation function
n <- 1:m
plot(n, s_n)
#Overlaying our function with the summation formula
lines(n, n*(n+1)/2)
