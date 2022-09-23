## Programa para ler um arquivo .CSV e plotar os boxplots dos atributos
## Autores: Stanley Oliveira

## Lendo o banco de dados
dados <- read.csv('../arquivos-aula05/cpu.csv', header=T)

## Fazendo o boxplot do atributo 1 
x = boxplot(dados[, 1])
x$stats
x$out

## Fazendo o boxplot dos atributos 1 e 2
x = boxplot(dados[, c(1, 2)])
x$stats

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
