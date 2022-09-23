## Programa para ler um arquivo .CSV e exibe o histograma de uma ou mais variaveis.
## Depois calcula a matriz de correlacao das variaveis.
## Autor: Stanley Oliveira

library(corrplot)
library(readr)
library(leaps)
library(psych)
library(GGally)
library(scatterplot3d)
library(caret)

## Lendo o banco de dados
dados <- read.csv('Mestrado/Disciplinas/AP539/Dados/cpu.csv', header=T)

## Histograma do atributo 2
hist(dados[,3], xlab = 'Coluna 3')

## Eliminacao de variaveis redundantes

## Analisando as correlacoes
M <- cor(dados, use = 'complete.obs')
corrplot(M, diag = T, method = 'number', type = 'upper')
summary(M[upper.tri(M)]) 

## Mostra as correlacoes, media, a mais alta e mais baixa
M

## Filtrando variaveis altamente correlacionadas
highlyCorDescr <- findCorrelation(M, cutoff = .7) ## corta variaveis com correlacao maior que 70%
numericas <- dados[,-highlyCorDescr]

## Imprimindo as correlacoes novamente
M <- cor(numericas, use = 'complete.obs')
summary(M[upper.tri(M)])
corrplot(M, method='number', type = 'upper')
save(M, file = 'M.rda')

## Visualizando as correlacoes
ggpairs(numericas)

