#!/bin/bash

# Armazena o nome dos domínios em um arquivo externo
domains_file="domains.txt"

# Verifica se o arquivo com o nome dos domínios existe
if [ ! -f "$domains_file" ]; then
  echo "Arquivo $domains_file não encontrado!"
  exit 1
fi

# Loop para testar cada domínio
while read domain; do
  echo "Testando o domínio $domain..."
  curl -s https://api.ssllabs.com/api/v3/analyze?host=$domain | \
    awk -F '\"' '
      /grade/{g=substr($4,1,1);next}
      /serverName/{
        print "Resultados para " $4 ":"
        print "Nota do SSL: " g
      }
    '
  echo ""
done < "$domains_file"
