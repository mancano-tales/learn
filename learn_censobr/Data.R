# Este código é dedicado a baixar dados oficiais do IBGE usando o pacote CensoBr
# O pacote foi desenvolvido por Rafael Pereira e por Rogério Barbosa".
# Maiores informações e detalhes de uso podem ser encontrados no link abaixo
# https://ipeagit.github.io/censobr





install.packages("Rtools")
install.packages("censobr")


censobr::read_population(2010)



censobr_cache()
set_censobr_cache_dir()
get_censobr_cache_dir()



read_households(
  year,          # year of reference
  columns,       # select columns to read
  add_labels,    # add labels to categorical variables
  as_data_frame, # return an Arrow DataSet or a data.frame
  showProgress,  # show download progress bar
  cache,         # cache data for faster access later
  verbose        # whether to print informative messages
)


censobr::data_dictionary(
  2010,
  "population",
  showProgress = TRUE,
  cache = TRUE,
  verbose = TRUE
)

censobr::questionnaire()
censobr::interview_manual()



censobr_cache(): can be used to list and/or delete data files cached locally
set_censobr_cache_dir(): can be used to set custom cache directory for {censobr} files
get_censobr_cache_dir():
  
  
  ---
  
  
  censobr::read_population(
    2010,
    columns = "V1006",
    add_labels = NULL,
    as_data_frame = FALSE,
    showProgress = TRUE,
    cache = TRUE,
    verbose = TRUE
  )
