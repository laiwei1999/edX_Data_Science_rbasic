library(dslabs)
data(murders)

#The function c(), which stands for concatenate, is useful for creating vectors.
codes <- c(380,124,818)
country <- c("italy", "canada", "egypt")
# We can also name the elements of a numeric vector
codes <- c(italy = 380, canada = 124, egypt = 818)

#The seq() function, which generates sequences.
seq(1,10)
seq(1,10,2)

#Subsetting: we use [] to access elements of a vector 
codes[2]
codes[c(1,3)]
codes[1:3]
codes["canada"]

#Vector Coercion
x <- c(1, "canada", 3)
x
class(x)

y <- 1:5
#The function as.character() turns numbers into characters.
z <- as.character(y)
z
#The function as.numeric() turns characters into numbers.
as.numeric(z)

#The function sort() sorts a vector in increasing order
sort(murders$total)

#Order returns the indices that sort the vector parameter
m <- c(31,4,15,92,65)
m
sort(m)
#The function order() produces the indices needed to obtain the sorted vector
index <- order(m)
m[index]
order(m)

murders$state[1:10]
murders$abb[1:10]

#See the states ordered by murder totals
index <- order(murders$total)
murders$abb[index]

#The function max() returns the largest value
max(murders$total)
#which.max() returns the index of the largest value
i_max <- which.max(murders$total)
i_max
murders$state[i_max]

#The functions min() and which.min() work similarly for minimum values
min(murders$total)
i_min <- which.min(murders$total)
i_min
murders$state[i_min]

#The function rank() gives us the ranks of the items in the original vector
rank(m)

#The name of the state with the maximum population is found by doing the following
murders$state[which.max(murders$population)]
#Access the population number 
max(murders$population)

#Convert height
heights <- c(69,62,66,70,70,73,67,73,67,70)
heights * 2.54
heights - 69

#Obtain the murder rate
murder_rate <- murders$total/murders$population * 100000
#Ordering the states by murder rate, in decreasing order
murders$state[order(murder_rate, decreasing = TRUE)]
