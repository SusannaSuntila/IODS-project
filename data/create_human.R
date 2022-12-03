
# Susanna Suntila
# create data "human"

### week 4

# Read in the datasets
library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# dimension, structure and summaries of the datasets
dim(hd)

# the hd data has 195 observations and 8 variables

str(hd)

summary(hd)

dim(gii)

# the gii has 195 observations and 10 variables

str(gii)

summary(gii)

# rename the variables
library(dplyr)
hd <- rename(hd, "HDI.r" = "HDI Rank",
              "HDI" = "Human Development Index (HDI)",
              "Life.Exp" = "Life Expectancy at Birth",
              "Edu.Exp" = "Expected Years of Education", 
              "Edu.Mean" = "Mean Years of Education",
              "GNI" = "Gross National Income (GNI) per Capita",
              "GNI.r_HDI.r" = "GNI per Capita Rank Minus HDI Rank")

colnames(hd)

gii <- rename(gii, "GII.r" = "GII Rank",
              "GII" = "Gender Inequality Index (GII)",
              "Mat.Mor" = "Maternal Mortality Ratio",
              "Ado.Birth" = "Adolescent Birth Rate",
              "Parli.F" = "Percent Representation in Parliament",
              "Edu2.F" = "Population with Secondary Education (Female)",
              "Edu2.M" = "Population with Secondary Education (Male)",
              "Labo.F" = "Labour Force Participation Rate (Female)",
              "Labo.M" = "Labour Force Participation Rate (Male)")

colnames(gii)

# mutate the gii data to add two new columns

gii <-  mutate(gii, "Edu2.FM" = Edu2.F / Edu2.M,
               "Labo.FM" = Labo.F / Labo.M)

colnames(gii)

# Join together the two datasets using the variable Country as the identifier
human <- inner_join(hd, gii, by = "Country")

# glimpse the final data set
glimpse(human)

# there are now 195 rows and 19 columns

# save the joined and modified data
library(tidyverse)
write_csv(human, "human.csv")

read.csv(file.path(".", "data", "human.csv"))


#### week 5

# read the human data for week 5
human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", 
                    sep =",", header = T)

# look at the structure and dimensions of the human data
str(human) # country variable AND the GNI variable are characters, other variables are numbers or integers.
dim(human) # there are 195 observations and 19 variables
# this dataset is from the United Nations development programme
# it includes components of the Human Development Index (HDI) and Gender Inequality Index (GII)

# mutate the data
human$GNI <- gsub(",", "", human$GNI) %>% as.numeric
str(human) # now the GNI variable is a number as well

# exclude unneeded variables
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# remove all rows with missing values
human <- filter(human, complete.cases(human))

# remove the observations which relate to regions instead of countries
# define the last indice we want to keep
last <- nrow(human) - 7
# choose everything until the last 7 observations
human <- human[1:last, ]

# define the row names of the data by the country names
rownames(human) <- human$Country
# remove the country name column from the data
human <- dplyr::select(human, -Country)

#
dim(human) # there are 155 observations and 8 variables

# save the new modified data with row names
library(tidyverse)
write.table(human, "human.txt", row.names = TRUE)

read.table(file.path(".", "data", "human.txt"))


