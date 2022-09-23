import os
import pandas as pd
import numpy as np
from glob import glob
from pathlib import Path
import math

data_folder = "/Users/mathe/Documents/Mestrado/Disciplinas/AP539/Aula 5/Programa-data-Imputation" # Pasta com os dados
new_folder = os.path.join(data_folder, "Dados Corrigidos") # Pasta criada para os dados corrigidos
csv_files_list = glob(os.path.join(data_folder, "*.csv")) # Recebendo a lista de arquivos .csv

if not os.path.exists(new_folder): # Criando a nova pasta
  os.makedirs(new_folder)

for file in csv_files_list: # Laço de repetição para cada um dos arquivos
    df = pd.read_csv(file) # Lendo o arquivo como um DataFrame
    
    for column in df.columns: # Laço de repetição para todas as colunas
        df[column] = np.where(df[column] == "?", np.NAN, df[column]) # Substituindo os valores "?" por NaN
    
    for column in df.columns: # Laço de repetição para todas as colunas
        column_list = df[column].tolist() # Variável que recebe a coluna como uma lista
        is_num = False # Variável para verificar se o dados presente na coluna é numérico

        for item in column_list: # Laço de repetição nos dados da coluna
            if (type(item) == str): # Verifica se o tipo do dado é string (str)
                if(item.isdigit()): # Verifica se a string é um dígito
                    df[column] = pd.to_numeric(df[column]) # Muda o tipo da coluna para numérico
                    is_num = True
                    break
            else:
                if(math.isnan(float(item))): # Verifica se o valor é NaN
                    continue
                else:
                    break
        
        if (df[column].dtype == object and not is_num): # Verificando o tipo da coluna
            df[column] = df[column].fillna(df[column].mode()[0]) # Preenchendo os valores inconsistentes com a moda
        else:
            df[column] = df[column].fillna(df[column].mean()) # Preenchendo os valores inconsistentes com a média
    
    filename = Path(file).name.split('.')[0] + '_corrigido.csv' # Nomeando o arquivo corrigido
    df.to_csv(os.path.join(new_folder, filename), index=False) # Adicionando arquivo corrigido na pasta