## Programa que calcula o número de clusters
## NbClust: package provides 30 indices for determining the number of clusters and 
## proposes to user the best clustering scheme from the different results obtained 
## by varying all combinations of number of clusters, distance measures, and clustering methods.
## Autores: Stanley Oliveira

library("NbClust")

## Exemplo de matriz
dados=read.csv('../arquivos-aula05/Tecnificacao-Cerrado-Gado-de-Corte.csv', header = T)
dados = dados[,-1]

nb <- NbClust(dados, distance = "euclidean", min.nc = 2,
              max.nc = 5, method = "kmeans")

library("factoextra")
fviz_nbclust(nb)
