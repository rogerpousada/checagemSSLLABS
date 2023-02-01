#!/bin/bash
#Rogerio Lima www.rogeriopousada.com.br
check_ssl_security() {
  domain=$1
  result=$(curl -s "https://api.ssllabs.com/api/v3/analyze?host=$domain")
  status=$(echo $result | jq -r '.status')
  if [ $status = "READY" ] || [ $status = "IN_PROGRESS" ]; then
    endpoints=$(echo $result | jq -r '.endpoints[].grade')
    echo "Estado de segurança SSL para o domínio $domain: $endpoints"
  else
    echo "Não foi possível obter informações de segurança SSL para o domínio $domain."
  fi
}

# Adicionar os domínios que deseja testar na lista "domains"
domains=("google.com" "facebook.com" "example.com")
for domain in "${domains[@]}"; do
  check_ssl_security $domain
done
