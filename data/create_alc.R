
# Susanna Suntila

# 17.11.2022

# student performance data, including alcohol consumption

# read  both data sets
library(tidyverse)

math <- read.csv(file.path(".", "data", "student-mat.csv"), sep = ";" , header = TRUE)

por <- read.csv(file.path(".", "data", "student-por.csv"), sep = ";" , header = TRUE)

# look at the structure and dimension of both data sets

dim(math)
# there are 395 rows and  33 columns in the math data

dim(por)
# there are 649 rows and  33 columns in the por data

str(math)

str(por)
# there are both characters and integers

# join the data sets by columns included in the join_cols

free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# look at the dimension and structure of this new data set
dim(math_por)
# there are 370 rows and 39 columns
str(math_por)

# Get rid of the duplicate records in the joined data set
alc <- select(math_por, all_of(join_cols))

for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse the final data set
glimpse(alc)
# there are now 370 rows and 35 columns

# save the joined and modified data
library(tidyverse)
write_csv(alc, "alc.csv")

read.csv(file.path(".", "data", "alc.csv"))

