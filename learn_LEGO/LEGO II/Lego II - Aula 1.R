# Lego 2 - Aula 1-2025.08.12
# Revisando o conteúdo da Aula 1
# Author: Tales Mançano com base em Rojério J. Barbosa


rm(list = ls()) # Apaga tudo que tem no environment
options(scioen =999)




# Setup -------------------------------------------------------------------


# Carregando Pacotes ------------------------------------------------------

#install.packages("PNADcIBGE")
#install.packages("Hmisc")
library(tidyverse)
library(PNADcIBGE)
library(Hmisc)


# Abrindo dados -----------------------------------------------------------

pnadc_2019t1 <- get_pnadc(year   = 2019,
                          quarter = 1,
                          labels = F,
                          design = F)

pnadc_rec <- pnadc_2019t1 %>% 
  setNames(tolower(names(.))) %>% 
  select(peso = v1028,
         sexo = v2007,
         idade = v2009,
         anosEst = vd3005,
         renda = vd4016 %>%
           filter(idade %in% 18:64,
                  renda > 0) %>% 
           mutate(ln_renda = log(renda),
                  anosEst = as.numeric(anosEst),
                  sexoRem = ifelse(sexo==2,1,0),
                  experiencia = idade - anosEst - 6)
           
         )

pnad_rec %>% 
  ggplot(aes( x= renda, weight = peso)) +
  geo_histogram()


# Recodificandi -----------------------------------------------------------

%>% %>% %>%

#ctrl + shift + I
#ctrl + shift + M
#home = vai para o início
#end = vai para o fim
  
  

# LAMARCA -----------------------------------------------------------------



# setup ------------------------------------------------------------------------
rm(list = ls()) # apaga tudo que havia no env
options(scipen = 999) # desabilita a notação científica

# carregando pacotes -----------------------------------------------------------

library(tidyverse)
library(PNADcIBGE)
library(Hmisc)


# abrindo dados ----------------------------------------------------------------

pnadc_2019t1 <- get_pnadc(
  year = 2019, 
  quarter = 1, 
  labels = FALSE,
  design = FALSE
)


# recodificando ----------------------------------------------------------------

pnad_rec <- pnadc_2019t1 %>%
  setNames(tolower(names(.))) %>%
  select(
    peso = v1028,
    sexo = v2007,
    idade = v2009,
    anosEst = vd3005,
    renda = vd4016
  ) %>%
  filter(
    idade %in% 18:64,
    renda > 0
  ) %>%
  mutate(
    ln_renda = log(renda),
    anosEst = as.numeric(anosEst),
    sexoFem = ifelse(sexo == 2, 1, 0),
    experiencia = idade - anosEst - 6
  )

---------------------------------------------------------------------------
  
pnad_rec %>% 
  ggplot(aes( x= ln_renda, weight = peso)) +
  geom_histogram()

# Modelos de regressão ----------------------------------------------------

pnad_rec$anosEst

X = cbind(constante = 1,
          anosEst = pnad_rec$anosEst)

y = pnad_rec$ln_renda
beta = solve( t(X)%*%X) %*% t(X) %*% y
