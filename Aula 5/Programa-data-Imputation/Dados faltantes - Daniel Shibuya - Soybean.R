# Script para realizar o preenchimento de dados faltantes
# Atividade AP539
# Daniel Hideki Shibuya

if (!require("pacman")) install.packages("pacman")
pacman::p_load(imputeTS,tidyverse,missForest)

library(tidyverse)
library(missForest)
library(imputeTS)

#Resetando plots e enviroment
rm(list = ls())
gc(reset=T)
graphics.off()

#Lendo o conjunto de dados
dados <- read.csv('soybean.csv', header=T)
#dados <- iris

#iris.mis <- prodNA(iris, 0.05)

#Verificando se o conjunto apresenta NA
head(dados)
str(dados)
summary(dados)

# is.na(dados[32,'hail'])
# Os dados faltantes estão mracados como"? 
# Fazendo alteração de "?" para "NA"
# O conjunto Soybean vem como character, mudar para categórico

dados[dados == '?'] <- NA
dados <- as.data.frame(lapply(dados, FUN = as.factor))

#Criando função para calcular a moda. 
#A função funciona para valores númericos e categóricos
calc_mode <- function(x){
  
  dif <- unique(x)
  dif_count <- tabulate(match(x, dif))
  dif[which.max(dif_count)]
}

#Preenchendo dados faltantes
col = as.numeric(ncol(dados))
row = as.numeric(nrow(dados))
i=1
j=1

#Salvando df com NA para comparação
dados_NA <- dados

# Dois laços for para percorrer linhas e colunas do data frame
# Valores nominais(factor) preencher pela moda -> 1ºLaço
# Valores nemericos preencher pela média -> 2º Laço
# Para preencher os valores numericos, basta utilizar a função na_mean
for (i in 1:col){
  if (is.factor(dados[,i])){
    for (j in 1:row){
      if(is.na(dados[j,i])){
        dados[j,i] <- calc_mode(dados[,i])
      }
    }
  }
  if(is.numeric(dados[,i])){
      dados[,i] = na_mean(dados[,i], option = "mean") 
  }
}


# Preenchimento de dados por meio do missForest
# Algoritmo de preenchimento baseado no RF
set.seed(2022)
df <- missForest(dados,maxiter= 10, ntree = 10, verbose = TRUE)

# Visualizar erro
# PFC - Proportion falsely classified
df$OOBerror 

df= do.call(rbind.data.frame, df)




