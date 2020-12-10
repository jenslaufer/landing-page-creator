library(tidyverse)
library(glue)

DATA_DIR <- "data"
RESULT_DIR <- "results"


data <- "{DATA_DIR}/copies.csv" %>%
  glue() %>%
  read_csv()

templates <- DATA_DIR %>%
  list.files(pattern = "\\.html$")

data <- expand_grid(data, template_filename = templates) %>%
  mutate(template_file = "{DATA_DIR}/{template_filename}" %>%
           glue()) %>%
  mutate(row = row_number())


data %>%
  pmap( ~ with(
    list(...),
    template_file %>%
      read_file() %>%
      glue() %>%
      glue() %>%
      write("{RESULT_DIR}/lp{row}.html" %>% glue())
  )) 