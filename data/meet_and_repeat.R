
### Data wrangling for week 6

## read in the data
# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# read in the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

## take a look at the data sets
names(BPRS)
names(RATS)

dim(BPRS) # there are 40 observations of 11 variables
dim(RATS) # there are 16 observations of 13 variables

str(BPRS) # each week's measures are compiled in a column
str(RATS) # each day's rats' weights are compiled in a column

summary(BPRS)
summary(RATS)

## Convert the categorical variables of both data sets to factors
library(dplyr)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

## Convert the data sets to long form, add a week variable to BPRS and a Time variable to RATS
library(tidyr)

# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable
# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, 5, 5)))

# Convert data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)


## Check the variable names, view the data contents and structures, and create some brief summaries 

names(BPRSL)
names(RATSL)

dim(BPRSL) # there are 360 observations of 5 variables
dim(RATSL) # there are 176 observations of 5 variables

str(BPRSL)
# the values from each week are compiled in the bprs variable
# and the corresponding week number in the Week variable
str(RATSL)
# the weights of rats from all the days recorded are compiled in the Weight variable
# and the corresponding number of day in the Time variable

summary(BPRSL)
summary(RATSL)

# For the BPRS data in the long format, the week numbers that were column names in the wide form
# are now observations of one variable, Week.
# The measures from each Weeks column belong now to single variable bprs.

# For RATS data in the long format, the day numbers that were column names in teh wide format
# are now observations of one variable, Time.
# The weights of the rats are compiled from those previous weight/day columns to one variable Weight.


## save the new modified data sets
library(tidyverse)

# BPRSL data
write.table(BPRSL, "BPRSL.txt", row.names = TRUE)
read.table(file.path(".", "data", "BPRSL.txt"))

# RATSL data
write.table(RATSL, "RATSL.txt", row.names = TRUE)
read.table(file.path(".", "data", "RATSL.txt"))


