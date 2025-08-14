
---
title: Lego 2 - Aula 1 - 12/08/2025
subtitle: Revisando o modelo de regressão linear múltipla
autor: Rogério J Barbosa
---

# Setup ------------------------------------------------------------------------
```{r}
rm(list = ls()) # apaga tudo o que havia no environment
options(scipen = 999) # desabilita a notação científica de números grandes

```
# Carregando pacotes -----------------------------------------------------------

```{r}
library(tidyverse)
library(PNADcIBGE) # install.packages("PNADcIBGE")
library(Hmisc)
```

# Abrindo dados ----------------------------------------------------------------
```{r}

pnadc_2019t1 <- get_pnadc(year    = 2019, 
                          quarter = 1, 
                          labels  = F, 
                          design  = F)

```

# Recodificando ----------------------------------------------------------------

pnadc_rec = pnadc_2019t1 %>%
  setNames(tolower(names(.))) |>
  select(peso    = v1028,
         sexo    = v2007,
         idade   = v2009,
         anosEst = vd3005,
         renda   = vd4016) |>
  filter(idade %in% 18:64,
         renda > 0) |>
  mutate(ln_renda    = log(renda),
         anosEst     = as.numeric(anosEst),
         sexoFem     = ifelse(sexo == 2, 1, 0),
         experiencia = idade - anosEst - 6)


# Análises descritivas ---------------------------------------------------------

```{r}

pnadc_rec |>
  ggplot(aes(x = idade, weight = peso)) +
  geom_histogram(bins = 10)
```

pnadc_rec |>
  ggplot(aes(x = renda, weight = peso)) +
  geom_histogram()

pnadc_rec |>
  ggplot(aes(x = ln_renda, weight = peso)) +
  geom_histogram()

# Modelos de regressão ---------------------------------------------------------

X = cbind(constante = 1,
          anosEst   = pnadc_rec$anosEst,
          sexoFem   = pnadc_rec$sexoFem,
          idade     = pnadc_rec$idade)

y = pnadc_rec$ln_renda

beta_hat = solve( t(X)%*%X ) %*% t(X) %*% y

coef_lm = coef(lm(ln_renda ~ anosEst + sexoFem + idade, data = pnadc_rec))
round(beta_hat, 12) == round(coef_lm, 12)
round(beta_hat, 11) == round(coef_lm, 11)

# Produção de valores preditos e resíduos --------------------------------------

y_hat = X %*% beta_hat

u_hat = y - y_hat

cor(X, u_hat)

t(X) %*% u_hat
