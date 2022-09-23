## Programa para ler um arquivo .CSV e plotar os boxplots com labels dos atributos
## Autores: Stanley Oliveira

library(car)

## Lendo o banco de dados
dados <- read.csv('cpu.csv', header=T)

## Fazendo o boxplot dos atributos 1 e 3
x = boxplot(dados[, c(1,3)])
x$stats

## Fazendo o boxplot dos atributos 3
x = boxplot(dados[, c(3)])
x$stats

## Fazendo o boxplot dos atributos 2 e 4
x = boxplot(dados[, c(2, 4)])
x$stats

## Fazendo o boxplot dos atributos 5 e 6
x = boxplot(dados[, c(5, 6)])
x$stats

## Fazendo o boxplot do atributo 1
#x = boxplot(dados[, c(1)])
#x$stats

## Fazendo o boxplot de todos os atributos
#x = boxplot(dados)

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

