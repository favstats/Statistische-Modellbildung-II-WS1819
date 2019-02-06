get_var_labels <- function(data, from = 1, to = length(data)) {
  
  var_nums <- colnames(data) 
  
  var_labels <- labelled::var_label(data) %>% unlist
  
  labelled_dat <- data.frame(var_nums, var_labels) %>%
    .[from:to,]
  
  return(labelled_dat)
}

get_clean_labels <- function(data, from = 1, to = length(data)) {
  library(magrittr)
  
  data %<>% select(from:to)
  
  labs <- get_var_labels(data)
  
  colnames(data) <- labs$var_labels
  data %<>%
    clean_names()
  return(data)
}