## Programa para ler um arquivo .CSV e plotar os boxplots com labels dos atributos.
## Depois esboçar o histograma de uma variáveis e calcular as correlacoes.
## Autor: Stanley Oliveira

library(corrplot)
library(readr)
library(leaps)
library(corrplot)
library(psych)
library(GGally)
library(scatterplot3d)
library(caret)

## Lendo o banco de dados
dados <- read.csv('cpu.csv', header=T)

## Fazendo o boxplot dos atributos 1 e 3
x = boxplot(dados[, c(1,3)])
x$stats

## Fazendo o boxplot dos atributo 3
x = boxplot(dados[, c(2)])
x$stats

## Fazendo o boxplot dos atributos 2 e 4
x = boxplot(dados[, c(2, 4)])
x$stats

## Fazendo o boxplot dos atributos 5 e 6
x = boxplot(dados[, c(5, 6)])
x$stats

## Fazendo o boxplot de todos os atributos
#x = boxplot(dados)
#x$stats

## Fazendo o boxplot de todos os atributos
x = boxplot(dados)

outlierFactor = 3
## Para cada uma dos atributos
for (i in 1:ncol(x$stats)) {
  
  ## Adicionando os valores ao plot
  text(y = x$stats[, i], labels = x$stats[, i], x = i + 0.5)
  
  print(paste0("Box plot ", x$names[i],":"))
  
  # Q1, Q2, Q3, Q4 e Q5
  print(paste0("Minimo: ", x$stats[1, i]))
  print(paste0("Q1: ", x$stats[2, i]))
  print(paste0("Q2: ", x$stats[3, i]))
  print(paste0("Q3: ", x$stats[4, i]))
  print(paste0("Maximo: ", x$stats[5, i]))
  
  # Limite inferior
  limInferior = x$stats[2, i] - outlierFactor * (x$stats[4, i] - x$stats[2, i])
  print(paste0("Limite inferior: ", limInferior))
  inferior = sort(x$out[x$out <= limInferior & x$group == i])
  print(paste0("Outliers (limite inferior): {", paste(inferior, collapse = ", "), "}"))
  
  # Limite superior
  limSuperior = x$stats[4, i] + outlierFactor * (x$stats[4, i] - x$stats[2, i])
  print(paste0("Limite superior:", limSuperior))
  superior = sort(x$out[x$out >= limSuperior & x$group == i])
  print(paste0("Outliers (limite superior): {", paste(superior, collapse = ", "), "}"))
  
  cat(sep = "\n\n")
}

## Histograma do atributo 1
hist(dados[,2])

## Eliminação de variáveis redundantes

## Analisando as correlacoes
M <- cor(dados, use = 'complete.obs')
corrplot(M, diag = T, method = 'circle', type = 'upper')
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

