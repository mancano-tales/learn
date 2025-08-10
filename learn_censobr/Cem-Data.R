
library(tidyverse)
readr::Arquivo-CEM <- readr::read_csv("2025-7-26-Arquivo-CEM.csv",n_max=0)

library(censobr)
install.packages("censo")

data_dictionary(2010)
questionnaire()
interview_manual()