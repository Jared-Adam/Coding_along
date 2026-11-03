# 1: Intro to  programming ####

# annotate vs
annotate # I can annotate after code and it will still run 

this is code!
this is code! # blah blah blah
# this is an annotation


# 2: Operations ####
# R is a calculator! 
# Run all of these below (ctrl + enter OR cmd + enter)
# PS: To run code, you can either have your cursor in the code or highlight the whole block, both will work!
2+2
2+2
(2+2)
(2+2)*2
(2+2)*2*2
(2+2)*(2*2)

# 3: Creating variables ####
# We can store as many variables as our computer has storage 
number <- 2
another = 2
numbers <- c(1,2,3,4,5)
test <- 'x'
same <- "x"

# why will the commented out code below work?
# wrong <- "x'

# 4: Order of operations ####

# What happens when our code is out of order?
ex <- x # broken
# concatanate: link or join separate things
x <- c(1,2,3) # object
ex <- x # name change




# 5: Types of data ####

# numeric
a <- 10
class(a)

# character/ string 
b <- "lettuce get rowdy"
class(b)

# logical 
c <- TRUE
class(c)

# LESS common:

# integer : whole number without any fractional or decimal parts
d <- 10L # (must be appened with an L)
d <- 10S # why does this not work?


# complex:
x <- 7i
class(x)




# 6: Name philosophy ####

CamelCase <- c('x','y','z')
under_score <- c('x','y','z')
how-about-this <- c('x','y','z')
# Can I start with a a number?
2026_seed_data <- x


# be explicit and not overly verbose
ThisIsTooMuchText <- c(x,y,z)
df <- c("not", "enough", "text")

# REMEMBER: prgoramming is writing in another language so do what feels right 
# but ensure your code is reproducibe and legible by others


# 7: Functions! ####

# base r arithmetic functions
min(numbers)
max(numbers)
mean(numbers)

# A small fake data set to look at 
bugs <- data.frame( # data.frame is a function used to structure a data
  spiders = rnorm(200), # rnorm is telling these values to follow a normal distribution 
  beetles = rnorm(250),
  wasps = rnorm(1000)
)

# Run just the name of the df (dataframe) to see what it looks like
bugs

# What type of object is "bugs"?
class(bugs)

## Answer:


# What if I want to look at a specific column within a df?
# The dollar ($) operator !
mean(bugs$spiders)

## Answer: 

# How do I know the names of my columns?
colnames(bugs)

## Answer: 

# What about the object type for a specific column?
class(bugs$spiders)

## Answer: 

# What if I want to remove a variable? 
# There is a function for that!
rm(bugs) # note how it is no longer is your session

# 8: Information / help ####

?mean
?mutate

# loading packages 
# TWO functions needed for this
# Install.packages only needs to be used ONCE!
  # Then the information is always on your computer
install.packages("tidyverse")

# Library must be used everytime you open R
# It is common practice for keep all of your packages at the top of your script so you can do it first thing when you begin each session 
library(tidyverse)

?tidyverse
?mutate

# 9: DATA ####

# There are built in data sets in R
# This is my favorite 
?penguins

# Let's look at it:
penguins




# How to bring in data of your own
# Many ways, no wrong one
# This is a helpful link
# https://idahoagstats.github.io/r-for-ag-scientists/lessons/data-import.html

# What we need to do is identify the directory in which your data is stored
# R names this location your "Working Directory"
# Hence, the functions associated with this process are:
getwd() # What does R think my current wd is?
setwd() # If I want to change it



###
##
#
# What else can R do?
# Run some of the code below to see! 


# 10: Can make plots ####
install.packages("tidyverse")
library(tidyverse)
penguins %>% 
  ggplot(aes(x = flipper_len,
                           y = body_mass)) +
  geom_point(aes(color = species, 
                 shape = species),
             size = 3,
             alpha = 0.8)


# 11: Can make art ####

# You can highlight everything below and run it at once! 
# Or run each code block in order

install.packages("RColorBrewer")
library(RColorBrewer)

# DOTS

# blank canvas 

axis_min <- 0
axis_max <- 10

base_data <- tibble(x = axis_min:axis_max,
                    y =x)
base_data %>% 
  ggplot(aes(x,y))

# add points 

base_data %>% 
  ggplot(aes(x,y))+ 
  geom_point()

grid_points <- expand.grid(base_data)

grid_points %>% 
  ggplot(aes(x,y))+
  geom_point()

# spacing 

polk <- grid_points %>% 
  mutate( x = case_when(y %% 2 == 0 & x %% 2 > 0 ~ NA_integer_,
                        TRUE ~ x),
          y = case_when( x %% 2 == 0 & y %% 2 > 0 ~ NA_integer_,
                         TRUE ~ y)) %>% 
  filter(if_all(everything(), ~!is.na(.)))

polk %>% 
  ggplot(aes(x,y))+
  geom_point()

# aes 

dot_size <- 10
dot_color <- "#ffffff"
back_col <- "#598c4c"

polk %>% 
  ggplot(aes(x,y))+
  theme_void()+ # remove axes and labels
  geom_point(size = 10, 
             color = dot_color)+
  theme(plot.background = element_rect(fill = back_col))


###
##
#
##
###


# WERID COLOR WHEEL

# vector with angles all possible angles of a circle create a circle 
# in radiants!
angles <- seq(0, 2*pi, length.out = 1000) # length adjusts how smooth the circle is 

# create full circle with converted equations
circle <- tibble(x = cos(angles), 
                 y = sin(angles))
circle

# plot 
circle %>% 
  ggplot(aes(x,y))+
  geom_path()+
  coord_equal()

# now we need multiple circles 
# time to iterate 
n = 60 

dark <- brewer.pal(n = 8, name = "Dark2")
?colorRampPalette
colors <- colorRampPalette(dark)(n) # take these colors and make 20 color options for each circle 
circle_now <- map2_df(1:n, colors, ~circle %>% 
                        mutate(x = x + .x, # shifting circles left to right, so adding value of first argument
                               color = .y, # for each circle, iterate the colors  
                               group = paste0("group", .x))) # grouping variable

# adding circles on the line 
circle_now %>% 
  ggplot(aes(x,y, group = group))+
  geom_polygon()


# tweak aes 

line_style <- 2
line_color <- "#ffffff"
backg_col <- "#000000"

circle_now %>% 
  ggplot(aes(x,y, group = group))+
  theme_void()+
  geom_polygon(fill = circle_now$color,
               color = line_color,
               linetype = line_style)+
  theme(plot.background = element_rect(fill = backg_col))

# finesse ggplot 
circle_now %>% 
  ggplot(aes(x,y, group = group))+
  theme_void()+
  geom_polygon(fill = circle_now$color,
               color = line_color,
               linetype = line_style)+
  theme(plot.background = element_rect(fill = backg_col))+
  coord_polar() # warps plot into a wheel


# 12: And mazes ####
install.packages("mazing")
library(mazing)
m <- maze(35,100)
plot(m, lwd = 2)


mat <- matrix(1, 20, 20)
for(i in 1:nrow(mat)){
    for(j in 1:ncol(mat)){
        if((i-10.5)^2+(j-10.5)^2 > 100){
            mat[i,j] <- 0
        }
    }
}
ma <- as.maze(mat)
plot(ma, lwd = 10, col= 'pink')
lines(ma, lwd=8, col = 'black', adjust = c(.2,.2))
lines(ma, lwd=6, col='turquoise', adjust = c(.4,.4))


# And so much more 

