
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

##
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




