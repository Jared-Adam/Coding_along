# 1: what is programming?

# basic R operations ####

# annotate vs
annotate

# 2: logical operations
2+2
(2+2)
(2+2)*2
(2+2)*2*2
(2+2)*(2*2)

# 3: creating variables 
number <- 2
another = 2
numbers <- c(1,2,3,4,5)
test <- 'x'
same <- "x"
# wrong <- "x'


ex <- x # broken
x <- c(1,2,3) # object
ex <- x # name change

# matrix
m1 <- matrix(c(1 ,2, # putting spaces and indents can help read code, personal preference 
               2, 1), nrow = 2, byrow = TRUE)

same <- matrix(c(1,2,2,1), nrow = 2, byrow = TRUE)

# what can we do with a matrix?
# example: matrix algebra for population growth 
library(popbio)
# lambda is the asymtopic population trend
# >1 = growing 
lambda(m1)


# 4: name philosophy
CamelCase <- c('x','y','z')
under_score <- c('x','y','z')
how-about-this <- c('x','y','z')

# be explicit and not overly verbose
ThisIsTooMuchText <- c(x,y,z)
df <- c("not", "enough", "text")

# REMEMBER: prgoramming is writing in another language so do what feels right 
# but ensure your code is reproducibe and legible by others


# 5. FUNCTIONS
# base r arithmetic functions
min(numbers)
max(numbers)
mean(numbers)


# 5.1 Informative functions
colnames()

# we can write our own functions too

function_name <- (x){

  mean(x)

}

function_name(x)

# "nesting" functions
 # we can put functions inside of other functions, example to follow




# 6. information / help

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



# ok great, what else can we do? ####
# R has built in data sets for you to mess with ####

# my favorite is: palmerpenguins
penguins

# Can make plots ####
penguins %>% 
  ggplot(aes(x = flipper_len,
                           y = body_mass)) +
  geom_point(aes(color = species, 
                 shape = species),
             size = 3,
             alpha = 0.8)


# Can make art ####
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


# And mazes ####
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

