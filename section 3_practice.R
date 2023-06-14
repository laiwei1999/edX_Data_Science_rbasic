library(dslabs)
data(heights)
library(NHANES)
data(NHANES)
library(data.table)
library(dplyr)
#Report 3 significant digits for all answers
options(digits = 3)

mean(na_example, na.rm = TRUE)
sd(na_example, na.rm = TRUE)

class(NHANES$AgeDecade)
tab <- NHANES %>% filter(Gender == "female" & AgeDecade ==" 20-29") 
head(tab)

ref <- NHANES %>% filter(AgeDecade == " 20-29" & Gender == "female") %>%
  summarize(average = mean(BPSysAve, na.rm = T),
            standard_deviation = sd(BPSysAve, na.rm = T))

Rece1 <- NHANES %>% filter(AgeDecade == " 40-49") %>% group_by(Gender) %>%
  summarize(average = mean(BPSysAve, na.rm = T), 
            standard_deviation = sd(BPSysAve, na.rm = T)) %>% 
  arrange(desc(average)) 

#Q1: How many individuals in the dataset are above average height?
average <- mean(heights$height)
ind <- sum(heights$height > average)

#Q2 :How many individuals in the dataset are above average height and are female?
heights <- setDT(heights)
fem <- heights[height > average & sex == "Female" ]

#Q3: What proportion of individuals in the dataset are female?
female <- heights %>% filter(sex == "Female")

#Q4a :Determine the minimum height in the heights dataset
min(heights$height)
#Q4b :Use the match() function to determine the index of the first individual with the minimum height.
match(50, heights$height)
heights[1032]

#Q5a: Determine the maximum height
max(heights$height)
#Q5c: How many of the integers in x are NOT heights in the dataset
x <- 50:82
sum(!x%in%heights$height)

#Q6: Using the heights dataset, create a new column of heights in centimeters named ht_cm.
heights2 <- heights[, ht_cm := height * 2.54]
#the height in centimeters of the 18th individual
heights2[18]
#the mean height in centimeters
mean(heights2$ht_cm)

#Q7: Create a data frame females by filtering the heights2 data to contain only female individuals
females <- heights2 %>% filter(sex == "Female")
#The mean height of the females in centimeters
mean(females$ht_cm)

data(olive)
#Q8: Plot the percent palmitic acid versus palmitoleic acid in a scatterplot
plot(olive$palmitic, olive$palmitoleic)
#Q9: Create a histogram of the percentage of eicosenoic acid in olive
hist(olive$eicosenoic)
#Q10: Make a boxplot of palmitic acid percentage in olive with separate distributions for each region
boxplot(palmitic ~ region, data = olive)
