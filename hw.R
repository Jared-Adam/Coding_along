# Practice for you! 
# Fill in the appropriate code below 

# Block 1 ####

# 1. Create three objects:
# A number, character, and vector with just numbers
# Hint: for the vector, c()




# 2. Using R as a caluclator, obtain the mean of the vector you just created




# 3. Using functions, obtain the mean, max, and min of the same vecotr
# Hint: max and min are functions!
# Did you get the same mean?




# Block 2 ####

# Using the penguins data set:
  # 1. What are the names of the columns?
    # Use a function to find these! 


  # 2. 
    # Obtain the mean, min, max, and var of any numerical column 


  # 3. Using the unique() function, what are the names species names?
    # Hint: unique(penguins$year)




# Block 3 ####

# dplyr trial!

# dplyr is a package that is automatically downloaded when we install tidyverse
?dplyr

# dplyr comprises functions named as verbs for their operation 
#1.  Using this (https://dplyr.tidyverse.org/) website, write code to use THREE functions from dplyr on the penguins data set
  # Hint: to accomplish this, you will have to use the "pipe" operator
    # The pipe can be obtained using shift+alt+m OR shift+cmd+m 
    # It will take one of two forms: (both work) 
      # |>  OR  %>%
    # dplyr functions are designed to pipe into one another, allowing for multiple changes within the same block of code
    # Examples:
      penguins %>% 
        filter(year == 2007) # Using "==", I am telling R to pull every value in year that equals 2007
      # NOTE: I am not saving a new object but am still able to manipulate a data frame to test a change before I commit to saving it 
      penguins %>% 
        filter(year != 2007) # Does NOT equal 2007

      penguins %>% 
        filter(year > 2007) # Is GREATER than 2007

      penguins %>% 
        filter( year < 2007) # Is LESS than 2007





# 2. What is the output for when year is less than 2007? Why?
    # Hint: Which years are recorded?
    # Use a function to justify your answer 