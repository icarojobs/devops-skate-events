# PROJETO FINAL DE PÓS GRADUAÇÃO - DEVOPS
Esse é um estudo de caso para implantação de aplicação orquestrada com `Docker Swarm` contendo `4 réplicas`, probe `liveness` e `redness` e também monitoramento com `Prometheus` e `Grafana`.

---
## ACESSOS À APLICAÇÃO
- Acesso WEB => [http://devops-skate-events.duckdns.org](http://devops-skate-events.duckdns.org)
- Github => [https://github.com/icarojobs/devops-skate-events](https://github.com/icarojobs/devops-skate-events)

---
## TESTANDO A APLICAÇÃO EM LOCALHOST
Garanta que você tenha o `docker`, `docker compose`, `git`, `curl` e `make` devidamente instalado e configurado.
Você garantir essas dependências com o seguinte comando:
```bash
# Atualiza repositórios do S.O e instala principais dependências
sudo apt update && sudo apt install git curl make

# Instala o docker:
curl -fsSL https://get.docker.com | sh

# Adiciona o usuário atual ao grupo 'docker'
sudo usermod -aG docker $USER
```

Após garantir que todas as dependências estejam instaladas, basta seguir o seguinte passo a passo:
```bash
# 1. Baixe o projeto do github e navegue no diretório do projeto
git pull https://github.com/icarojobs/devops-skate-events.git
cd devops-skate-events

# 2. Simplesmente execute o comando 'make'
make

# 3. Acesse a aplicação, via browser, no endereço http://localhost:8000
```

---
## EXECUÇÕES SUBSEQUENTES DO PROJETO
```bash
# Sobe todos os containers (verificar arquivo Makefile):
make up

# Para todos os containers:
make down
```

---
## VERIFICAÇÃO DE E-MAILS
Você pode verificar os e-mails recebidos, em localhost, no endereço [http://localhost:8025](http://localhost:8025)
