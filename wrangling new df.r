# packages ####
library(tidyverse)
library(here)
library(janitor)

# data ####
start <- here("20026-10-28_TeachingDF.csv")
df <- as_tibble(read.csv(start))

# cleaning ####

df
colnames(df)
# I know there are NAs: two options
  # find the band instances that have <3
df %>% 
  group_by(band) %>% 
  tally() %>% 
  filter(n < 3)
  # OR find the NAs and based on Quadrat ID, change them 
  # based on our raw data, 667 = band 3 and 637 = band 10
df %>% 
  filter(is.na(band)) %>% 
  relocate(Quadrat_ID)


df %>% 
  rename("dc_ct" = "chewed_d_ct",
"dl_ct" = "loose_d_ct",
"dp_ct" = "present.dish_count",
"stc_ct" = "chewed_st_ct",
"stl_ct" = "loose_st_ct",
"sp_ct" = "present.stick_count") %>% 
  relocate(c(Q, Quadrat_ID), .after = site) %>% 
  #relocate(date_out, date_in, band, R, site, Q, Quadrat_ID)
  #excel_numeric_to_date(46232)
  mutate(date_in = case_when(date_in == '46232' ~ '7/29/26',
.default = date_in)) %>% 
  mutate(band = case_when(Quadrat_ID == 667 ~ 3,
  Quadrat_ID == 637 ~ 10,
.default = band)) %>% 
  #print(n = Inf)
  select(-14) %>% 
  #print(n = Inf) 
  mutate(site = 3) %>% 
  print(n = Inf)





