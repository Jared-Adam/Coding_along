# packages ####
library(tidyverse)
library(here)


# data ####



# cleaning ####
# work one problem at a time
# Tips: 
  # you do not need to save an object to see if the code works
  # subset your data set to make it easier to see the changes you make and then expand it the whole df



# data ####
seeds <- SeedPredation_JA
seeds



# clean ####
# TODO : assign elevations via bands
  # convert elevation to meters
  # visualize 

# functions we will use for this:
?mutate
?relocate
?ggplot

# how do we create sequential changes to our df?
  # piping lines of code together using the pipe operator %>% (ctl shift m / cmd shift m)
  # this operates in a literal such that the code will break if your operations are incorrectly placed

# broken example
seeds %>% 
  select(-3) %>% 
  relocate(band)

# correct example
seeds %>% 
  select(-2) %>% 
  relocate(band)

# Nesting 
colnames(seeds)

seeds %>% 
  select(3:8) %>% # selecting the rows I want to look at
  group_by(band, present_d_ct, site) %>% # grouping by df by certain variables so I extract a mean
  mutate(new = mean(present_d_ct)) %>% # creating a new column and extracting mean (NEST)
  relocate(new) %>% # I want to see my new column in the first row 
  print(n = Inf) # I want to see the whole new df. N = whatever value you want

# why does this not work?
seeds %>% 
  select(3:8) %>% 
  group_by(band, present_d_ct, site) %>% 
  mutate(new <- mean(present_d_ct)) %>% 
  relocate(new)



# complete code below ####
seeds %>% # pipe operator 
  mutate(el = case_when(band == '1' ~ '5400',
                        band == '2' ~'6150',
                        band == '3' ~ '6320',
                        band == '4' ~ '6760', 
                        band == '5' ~ '7200',
                        band == '6' ~ '7900', 
                        band == '7' ~ '8200',
                        band == '8' ~ '8370',
                        band == '9' ~ '8800',
                        band == '10' ~ '9150')) %>% 
  relocate(band, el) %>% 
  mutate(el = as.numeric(el)) %>% 
  mutate(el = el*0.3) %>% 
  ggplot(aes(x = el, y = present_d_ct))+
  geom_smooth(method = 'gam',
       formula = y ~s(x, k=4))+
  theme_bw() +
  xlab("Elevation (m)")+
  ylab("Seeds present on dish (10 max)")+
  labs(title = "Mica Creek Seed Predation - Petri Dish")+
  theme(axis.title = element_text(size=24),
        panel.grid = element_blank(),
        plot.title = element_text(size=24),
        axis.text = element_text(size = 24),
        legend.text = element_text(size = 18),
        axis.ticks.length = unit(.25, 'cm'),
        legend.title = element_text(size = 20),
        strip.text.x = element_text(size = 20))+
  scale_x_continuous(breaks = seq(1620, 2800, by = 160))+
  ylim(0,10)
           
ggsave("SeedPred_Dish.pdf",
       dish,
       width = 16,
       height = 6,
       units = 'in', 
       dpi = 600)


stick <- seeds %>%
  mutate(el = case_when(band == '1' ~ '5400',
                        band == '2' ~'6150',
                        band == '3' ~ '6320',
                        band == '4' ~ '6760', 
                        band == '5' ~ '7200',
                        band == '6' ~ '7900', 
                        band == '7' ~ '8200',
                        band == '8' ~ '8370',
                        band == '9' ~ '8800',
                        band == '10' ~ '9150')) %>% 
  relocate(band, el) %>% 
  mutate(el = as.numeric(el)) %>% 
  mutate(el = el*0.3) %>% 
  ggplot(aes(x = el, y = present_st_ct))+
  geom_smooth(method = 'gam',
              formula = y ~s(x, k=4))+
  theme_bw() +
  xlab("Elevation (m)")+
  ylab("Seeds present on stick")+
  labs(title = "Mica Creek Seed Predation - Stick")+
  theme(axis.title = element_text(size=24),
        panel.grid = element_blank(),
        plot.title = element_text(size=24),
        axis.text = element_text(size = 24),
        legend.text = element_text(size = 18),
        axis.ticks.length = unit(.25, 'cm'),
        legend.title = element_text(size = 20),
        strip.text.x = element_text(size = 20))+
  scale_x_continuous(breaks = seq(1620, 2800, by = 160))+
  ylim(0,10)

ggsave("SeedPred_Stick.pdf",
       stick,
       width = 16,
       height = 6,
       units = 'in', 
       dpi = 600)
