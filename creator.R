library(tidyverse)
library(glue)

resultsPath <- "results"
dir.create(file.path(resultsPath), showWarnings = F)

data <- "template/copies.csv" %>%
  read_csv() %>%
  mutate(row = row_number())


template <- "template/template.html" %>%
  read_file() %>%
  glue()

data %>%
  pmap(~ with(
    list(...),
    template %>%
      glue() %>% write_file("{resultsPath}/{row}.html" %>% glue())
  ))
