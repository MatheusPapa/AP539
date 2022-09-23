## Programa principal que implementa o m?todo do cotovelo para estimar o
## n?mero de clusters - exig?ncia: atributos numericos.
## Observa??o: este programa invoca o programa R: funcoes.R
## Autores: David Ferreira Junior e Stanley Oliveira

source ('/Users/mathe/Documents/Mestrado/Disciplinas/AP539/funcoes.R')

## Exemplo de matriz
	matriz=read.csv('/Users/mathe/Documents/Mestrado/Disciplinas/AP539/dados_cluster.csv', header = T)

## Numero de clusters a serem avaliados
	num_clusters = 15

## Resultado
	## Se nao passar uma seed vai rodar aleatorio
	result = retorna_clusters (matriz, num_clusters=15, seed = NULL)			

## Plots
	plota_clusters (result$SS_int_VIZ, result$SS_ext_VIZ)


## Para obter os clusters, por exemplo 3
	numero_de_clusters <- 3
	clsuter_escolhido <- kmeans(matriz,centers = numero_de_clusters, iter.max = 20)		

	## Clusters
		clsuter_escolhido$cluster
		