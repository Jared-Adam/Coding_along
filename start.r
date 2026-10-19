# what is programming?

# basic R operations ####
# make notes 
# create a drop down #x4


# logical operations
2+2
(2+2)
(2+2)*2
(2+2)*2*2
(2+2)*(2*2)

# creating variables 
number <- 2
another = 2
numbers <- c(1,2,3,4,5)
test <- x
test <- 'x'
same <- "x"
# wrong <- "x'

# name philosophy
CamelCase <- c('x','y','z')
under_score <- c('x','y','z')
how-about-this <- c('x','y','z')

# be explicit and not overly verbose
ThisIsTooMuchText <- c(x,y,z)
df <- c("not", "enough", "text")

# REMEMBER: prgoramming is writing in another language so do what feels right 
# but ensure your code is reproducibe and legible by others

# base r arithmetic operations
min(numbers)
max(numbers)
mean(numbers)

# information / help

?mean
?mutate

# loading packages ####
install.packages("tidyverse")
library(tidyverse)

?tidyverse
?mutate

# how to bring in data ####
# many ways, no wrong one
# https://idahoagstats.github.io/r-for-ag-scientists/lessons/data-import.html

# I use local docs and the here() package

# OR you can identify the path on your computer
getwd()
setwd()

